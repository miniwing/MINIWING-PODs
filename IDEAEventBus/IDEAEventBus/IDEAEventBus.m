//
//  IDEAEventBus.m
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "IDEAEventBus.h"
#import "NSObject+IDEAEventBus.h"
#import "IDEAEventBusCollection.h"
#import "NSNotification+IDEAEvent.h"
#import "NSObject+IDEAEventBus+Inner.h"

static inline NSString * __generateUnqiueKey(Class<IDEAEvent> aClass,NSString *aEventType) {
   
   Class  stTargetClass = [aClass respondsToSelector:@selector(eventClass)] ? [aClass eventClass] : aClass;
   
   if (aEventType) {
      
      return [NSString stringWithFormat:@"%@_of_%@", aEventType, NSStringFromClass(stTargetClass)];
   }
   else {
      
      return NSStringFromClass(stTargetClass);
   }
}

/**
 内存中保存的监听者
 */
@interface IDEAEventSubscriberMaker()

- (instancetype)initWithEventBus:(IDEAEventBus *)aEventBus
                      eventClass:(Class)aEventClass;

@property (nonatomic, strong) Class              eventClass;

@property (nonatomic, strong) NSObject          * lifeTimeTracker;

@property (nonatomic, strong) dispatch_queue_t    queue;

@property (nonatomic, strong) NSMutableArray    * eventSubTypes;

@property (nonatomic, strong) IDEAEventBus      * eventBus;

@property (nonatomic, copy)   void              (^hander)(__kindof NSObject *);

@end


/**
 保存的监听者信息
 */
@interface _IDEAEventSubscriber: NSObject<IDEAEventBusContainerValue>

@property (nonatomic, strong) Class eventClass;

@property (nonatomic, copy)   void              (^handler)(__kindof NSObject *);

@property (nonatomic, strong) dispatch_queue_t    queue;

@property (nonatomic, copy)   NSString          * uniqueId;

@end

@implementation _IDEAEventSubscriber

- (NSString *)valueUniqueId {
   
   return self.uniqueId;
}

@end

/**
 返回可以取消的token
 */
@interface _IDEAEventToken: NSObject<IDEAEventToken>

@property (nonatomic, copy)   NSString       * uniqueId;

@property (nonatomic, copy)   void           (^onDispose)(NSString * uniqueId);

@property (assign, nonatomic) BOOL             isDisposed;

@end

@implementation _IDEAEventToken

- (instancetype)initWithKey:(NSString *)uniqueId {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;

   if (self = [super init]) {
      
      _uniqueId = uniqueId;
      _isDisposed = NO;
   }
   
   __CATCH(nErr);
   
   return self;
}

- (void)dispose {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   @synchronized(self) {
      
      if (_isDisposed) {
         return;
      }
      _isDisposed = YES;
   }
   
   if (self.onDispose) {
      
      self.onDispose(self.uniqueId);
   }
   
   __CATCH(nErr);
   
   return;
}

@end

/**
 组合token
 */
@interface _IDEAComposeToken: NSObject <IDEAEventToken>

- (instancetype)initWithTokens:(NSArray<_IDEAEventToken *> *)aTokens;

@property (assign, nonatomic) BOOL                         isDisposed;

@property (nonatomic, strong) NSArray<_IDEAEventToken *> * tokens;

@end

@implementation _IDEAComposeToken

- (instancetype)initWithTokens:(NSArray<_IDEAEventToken *> *)tokens {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   if (self = [super init]) {
      
      _tokens = tokens;
      _isDisposed = NO;
   }
   
   __CATCH(nErr);
   
   return self;
}

- (void)dispose {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   @synchronized(self) {
      
      if (_isDisposed) {
         
         nErr  = noErr;
         
         break;
      }
      
      _isDisposed = YES;
   }
   
   for (_IDEAEventToken *stToken in self.tokens) {
      
      [stToken dispose];
   }
   
   __CATCH(nErr);
   
   return;
}

@end


@interface IDEAEventBus() {
   
   pthread_mutex_t    _accessLock;
}

@property (nonatomic, copy)   NSString                * prefix;

@property (nonatomic, strong) IDEAEventBusCollection  * collection;

@property (nonatomic, strong) dispatch_queue_t          publishQueue;

@property (nonatomic, strong) NSMutableDictionary     * notificationTracker;

@end

@implementation IDEAEventBus

+ (instancetype)shared {
   
   static IDEAEventBus     *_instance;
   static dispatch_once_t   onceToken;
   dispatch_once(&onceToken, ^ {
      
      _instance = [[IDEAEventBus alloc] init];
   });
   
   return _instance;
}

- (instancetype)init {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;

   if (self = [super init]) {
      
      _prefix              = @([[NSDate date] timeIntervalSince1970]).stringValue;
      _collection          = [[IDEAEventBusCollection alloc] init];
      _publishQueue        = dispatch_queue_create("com.eventbus.publish.queue", DISPATCH_QUEUE_SERIAL);
      _notificationTracker = [[NSMutableDictionary alloc] init];
      
      pthread_mutex_init(&_accessLock, NULL);
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (void)lockAndDo:(void(^)(void))block {
   
   @try {
      
      pthread_mutex_lock(&_accessLock);
      block();
   }
   @finally {
      
      pthread_mutex_unlock(&_accessLock);
   }
   
   return;
}

#pragma mark - Normal Event


- (id<IDEAEventToken>)_createNewSubscriber:(IDEAEventSubscriberMaker *)aMaker {

   int                            nErr                                     = EFAULT;
   
   _IDEAEventToken               *stToken                                  = nil;
   NSMutableArray                *stTokens                                 = nil;

   __TRY;

   if (!aMaker.hander) {
      
      nErr  = EINVAL;
      
      break;
      
   } /* End if () */
   
   if (aMaker.eventSubTypes.count == 0) {//一级事件
      
      stToken  = [self _addSubscriberWithMaker:aMaker eventType:nil];
      
      nErr  = noErr;
      
      break;
      
   } /* End if () */
   
   stTokens = [NSMutableArray array];
   
   for (NSString *szEventType in aMaker.eventSubTypes) {
      
      stToken  = [self _addSubscriberWithMaker:aMaker eventType:szEventType];
      
      [stTokens addObject:stToken];
      
   } /* End for () */
   
   stToken = [[_IDEAComposeToken alloc] initWithTokens:stTokens];
   
   __CATCH(nErr);
   
   return stToken;
}

- (void)_addNotificationObserverIfNeeded:(NSString *)aName {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;

   if (!aName) {
      
      nErr  = EINVAL;
      
      break;
   }
   
   [self lockAndDo:^ {
      
      if ([self.notificationTracker objectForKey:aName]) {
         
         return;
      }
      
      [self.notificationTracker setObject:@(1) forKey:aName];
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(receiveNotification:)
                                                   name:aName object:nil];
   }];
   
   __CATCH(nErr);
   
   return;
}

- (void)_removeNotificationObserver:(NSString *)aName {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;

   if (!aName) {
      
      nErr  = EINVAL;
      
      break;
   }
   
   [self lockAndDo:^ {
      
      [self.notificationTracker removeObjectForKey:aName];
      
      @try {
         
         [[NSNotificationCenter defaultCenter] removeObserver:self name:aName object:nil];
         
      }
      @catch(NSException *aException) {
      }
   }];
   
   __CATCH(nErr);
   
   return;
}

- (_IDEAEventToken *)_addSubscriberWithMaker:(IDEAEventSubscriberMaker *)aMaker eventType:(NSString *)aEventType {
   
   int                            nErr                                     = EFAULT;
   
   NSString                      *szEventKey                               = nil;
   NSString                      *szGroupId                                = nil;
   NSString                      *szUniqueId                               = nil;
   _IDEAEventToken               *stToken                                  = nil;
   BOOL                           isCFNotifiction                          = NO;
   
   _IDEAEventSubscriber          *stSubscriber                             = nil;

   __TRY;

   @weakify(self);
   
   szEventKey  = __generateUnqiueKey(aMaker.eventClass, aEventType);
   szGroupId   = [self.prefix stringByAppendingString:szEventKey];
   szUniqueId  = [szGroupId stringByAppendingString:@([NSDate date].timeIntervalSince1970).stringValue];
   stToken     = [[_IDEAEventToken alloc] initWithKey:szUniqueId];
   
   isCFNotifiction   = (aMaker.eventClass == [NSNotification class]);

   if (aEventType && isCFNotifiction) {
      
      [self _addNotificationObserverIfNeeded:aEventType];
   }
   
   stToken.onDispose = ^(NSString *uniqueId) {
      
      @strongify(self);

      if (!self) {
         
         return;
      }
      
      BOOL bEmpty = [self.collection removeUniqueId:uniqueId ofKey:szGroupId];
      
      if (bEmpty && isCFNotifiction) {
         
         [self _removeNotificationObserver:aEventType];
      }
   };
   
   //创建监听者
   stSubscriber = [[_IDEAEventSubscriber alloc] init];
   stSubscriber.queue      = aMaker.queue;
   stSubscriber.handler    = aMaker.hander;
   stSubscriber.uniqueId   = szUniqueId;
   
   if (aMaker.lifeTimeTracker) {
      
      [aMaker.lifeTimeTracker.eb_disposeBag addToken:stToken];
   }
   
   [self.collection addObject:stSubscriber forKey:szGroupId];
   
   __CATCH(nErr);
   
   return stToken;
}

- (IDEAEventSubscriberMaker<id> *(^)(Class eventClass))on {
   
   return ^IDEAEventSubscriberMaker *(Class eventClass) {
      
      return [[IDEAEventSubscriberMaker alloc] initWithEventBus:self
                                                     eventClass:eventClass];
   };
}

- (IDEAEventSubscriberMaker<id> *)on:(Class)aEventClass {
   
   return [[IDEAEventSubscriberMaker alloc] initWithEventBus:self eventClass:aEventClass];
}

- (void)receiveNotification:(NSNotification *)aNotificaion {
   
   [self dispatch:aNotificaion];
}

- (void)dispatch:(id<IDEAEvent>)aEvent {
   
   int                            nErr                                     = EFAULT;
   
   NSString                      *szEventSubType                           = nil;
   NSString                      *szKey                                    = nil;
   
   __TRY;

   if (!aEvent) {
      
      nErr  = EINVAL;
      
      break;
   }
   
   szEventSubType = [aEvent respondsToSelector:@selector(eventSubType)] ? [aEvent eventSubType] : nil;
   
   if (szEventSubType) {
      
      //二级事件
      szKey = __generateUnqiueKey(aEvent.class, szEventSubType);
      [self _publishKey:szKey event:aEvent];
   }
   
   //一级事件
   szKey = __generateUnqiueKey(aEvent.class, nil);
   
   [self _publishKey:szKey event:aEvent];
   
   __CATCH(nErr);
   
   return;
}

- (void)dispatchOnBusQueue:(id<IDEAEvent>)aEvent {
   
   dispatch_async(self.publishQueue, ^ {
      
      [self dispatch:aEvent];
   });
   
   return;
}

- (void)dispatchOnMain:(id<IDEAEvent>)event {
   
   if ([NSThread isMainThread]) {
      
      [self dispatch:event];
   }
   else {
      
      dispatch_async(dispatch_get_main_queue(), ^ {
         
         [self dispatch:event];
      });
   }
   
   return;
}

- (void)_publishKey:(NSString *)aEventKey event:(NSObject *)aEvent {
   
   NSString *szGroupId     = [self.prefix stringByAppendingString:aEventKey];
   NSArray  *stSubscribers = [self.collection objectsForKey:szGroupId];
   
   if (!stSubscribers || stSubscribers.count == 0) {
      
      return;
   }
   
   for (_IDEAEventSubscriber * subscriber in stSubscribers) {
      
      if (subscriber.queue) { //异步分发
         
         dispatch_async(subscriber.queue, ^ {
            
            if (subscriber.handler) {
               
               subscriber.handler(aEvent);
            }
         });
      }
      else { //同步分发
         if (subscriber.handler) {
            subscriber.handler(aEvent);
         }
      }
   }
   
   return;
}

@end

@implementation IDEAEventSubscriberMaker

- (NSMutableArray *)eventSubTypes {
   
   if (!_eventSubTypes) {
      
      _eventSubTypes = [[NSMutableArray alloc] init];
   }
   
   return _eventSubTypes;
}

- (instancetype)initWithEventBus:(IDEAEventBus *)aEventBus
                      eventClass:(Class)aEventClass {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;

   if (self = [super init]) {
      
      _eventBus = aEventBus;
      _eventClass = aEventClass;
      _queue = nil;
   }
   
   __CATCH(nErr);
   
   return self;
}

- (id<IDEAEventToken>)next:(IDEAEventNextBlock)aHander {
   
   return self.next(aHander);
}

- (IDEAEventSubscriberMaker *)atQueue:(dispatch_queue_t)aQueue {
   
   return self.atQueue(aQueue);
}

- (IDEAEventSubscriberMaker *)freeWith:(id)aObject {
   
   return self.freeWith(aObject);
}

- (IDEAEventSubscriberMaker *)ofSubType:(NSString *)aEventType {
   
   return self.ofSubType(aEventType);
}

#pragma mark - 点语法

- (IDEAEventSubscriberMaker<id> *(^)(dispatch_queue_t))atQueue {
   
   return ^IDEAEventSubscriberMaker *(dispatch_queue_t aQueue) {
      
      self.queue = aQueue;
      
      return self;
   };
}

- (IDEAEventSubscriberMaker<id> *(^)(NSString *))ofSubType {
   
   return ^IDEAEventSubscriberMaker *(NSString * eventType) {
      
      if (!eventType) {
         
         return self;
      }
      
      @synchronized(self) {
         
         [self.eventSubTypes addObject:eventType];
      }
      
      return self;
   };
}

- (IDEAEventSubscriberMaker<id> *(^)(id))freeWith {
   
   return ^IDEAEventSubscriberMaker *(id lifeTimeTracker) {
      
      self.lifeTimeTracker = lifeTimeTracker;
      
      return self;
   };
}

- (id<IDEAEventToken>(^)(void(^)(id event)))next {
   
   return ^id<IDEAEventToken>(void(^hander)(__kindof NSObject * event)) {
      
      self.hander = hander;
      
      return [self.eventBus _createNewSubscriber:self];
   };
}

@end


