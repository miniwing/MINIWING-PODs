//
//  IDEAThrottle.m
//  IDEAThrottle
//
//  Created by Harry on 2021/3/21.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "IDEAThrottle.h"

#if !__has_feature(objc_arc)
#error
#endif

NS_INLINE BOOL throttle_object_isClass(id _Nullable aObject) {
   
   if (!aObject) {
      
      return NO;
      
   } /* End if () */
   
   if (@available(iOS 8.0, macOS 10.10, tvOS 9.0, watchOS 2.0, *)) {
      
      return object_isClass(aObject);
      
   } /* End if () */
   else {
      
      return aObject == [aObject class];
      
   } /* End if () */
}

Class throttleMetaClass(Class aClass) {
   
   if (class_isMetaClass(aClass)) {
      
      return aClass;
      
   } /* End if () */
   
   return object_getClass(aClass);
}

enum {
   
   BLOCK_HAS_COPY_DISPOSE  = (1 << 25),
   BLOCK_HAS_CTOR          = (1 << 26),   // helpers have C++ code
   BLOCK_IS_GLOBAL         = (1 << 28),
   BLOCK_HAS_STRET         = (1 << 29),   // IFF BLOCK_HAS_SIGNATURE
   BLOCK_HAS_SIGNATURE     = (1 << 30),
};

typedef struct _ThrottleBlockDescriptor {
   
   unsigned long   reserved;
   unsigned long   size;
   void           *rest[1];
   
} St_ThrottleBlockDescriptor;

typedef struct _ThrottleBlock {
   
   void                       *isa;
   int                         flags;
   int                         reserved;
   void                       *invoke;
   St_ThrottleBlockDescriptor *descriptor;
   
} St_ThrottleBlock;

static const char * throttleBlockMethodSignature(id aBlockObject) {
   
   St_ThrottleBlock           *stBlock       = (__bridge void *)aBlockObject;
   St_ThrottleBlockDescriptor *stDescriptor  = stBlock->descriptor;
   
   assert(stBlock->flags & BLOCK_HAS_SIGNATURE);
   
   int                   nIndex        = 0;
   
   if(stBlock->flags & BLOCK_HAS_COPY_DISPOSE) {
      
      nIndex += 2;
      
   } /* End if () */
   
   return stDescriptor->rest[nIndex];
}

@interface ThrottleDealloc : NSObject

@property (nonatomic, strong)                ThrottleRule                        * rule;
@property (nonatomic, strong)                Class                                 clzz;
@property (nonatomic, assign)                pthread_mutex_t                       invokeLock;

- (void)lock;
- (void)unlock;

@end

@implementation ThrottleDealloc

- (instancetype)init {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self = [super init];
   
   if (self) {
      
      pthread_mutexattr_t   stMutexAttr;
      pthread_mutexattr_init(&stMutexAttr);
      pthread_mutexattr_settype(&stMutexAttr, PTHREAD_MUTEX_RECURSIVE);
      pthread_mutex_init(&_invokeLock, &stMutexAttr);
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (void)dealloc {
   
   SEL    stSelector = NSSelectorFromString(@"discardRule:whenTargetDealloc:");
   
   if (nil != stSelector) {
      
      IMP    stIMP   = ((void (*)(id, SEL, ThrottleRule *, ThrottleDealloc *))[ThrottleEngine.defaultEngine methodForSelector:stSelector]);
      
      if (nil != stIMP) {
         
         ((void (*)(id, SEL, ThrottleRule *, ThrottleDealloc *))stIMP)(ThrottleEngine.defaultEngine, stSelector, self.rule, self);
         
      } /* End if () */
      
   } /* End if () */
   
   __SUPER_DEALLOC;
   
   return;
}

- (void)lock {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   pthread_mutex_lock(&_invokeLock);
   
   __CATCH(nErr);
   
   return;
}

- (void)unlock {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   pthread_mutex_unlock(&_invokeLock);
   
   __CATCH(nErr);
   
   return;
}

@end

@interface ThrottleRule () <NSSecureCoding>

@property (nonatomic, assign)                NSTimeInterval                        lastTimeRequest;
@property (nonatomic, strong)                NSInvocation                        * lastInvocation;
@property (nonatomic, assign)                SEL                                   aliasSelector;
@property (nonatomic, readwrite, getter=isActive) BOOL active;
@property (nonatomic, readwrite)             id                                    alwaysInvokeBlock;
@property (nonatomic, readwrite)             dispatch_queue_t                      messageQueue;

@end

@implementation ThrottleRule

- (instancetype)initWithTarget:(id)aTarget selector:(SEL)aSelector durationThreshold:(NSTimeInterval)aDurationThreshold {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self = [super init];
   
   if (self) {
      
      _target              = aTarget;
      _selector            = aSelector;
      _durationThreshold   = aDurationThreshold;
      _mode                = ThrottlePerformModeDebounce;
      _lastTimeRequest     = 0;
      _messageQueue        = dispatch_get_main_queue();
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

#pragma mark Getter & Setter

- (SEL)aliasSelector {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   if (!_aliasSelector) {
      
      NSString *szSelectorName   = NSStringFromSelector(self.selector);
      
      _aliasSelector = NSSelectorFromString([NSString stringWithFormat:@"__throttle%@", szSelectorName]);
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return _aliasSelector;
}

- (BOOL)isPersistent {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   if (!throttle_object_isClass(self.target)) {
      
      _persistent = NO;
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return _persistent;
}

#pragma mark Public Method

- (BOOL)apply {
   
   return [ThrottleEngine.defaultEngine applyRule:self];
}

- (BOOL)discard {
   
   return [ThrottleEngine.defaultEngine discardRule:self];
}

- (NSString *)description {
   
   return [NSString stringWithFormat:@"target:%@, selector:%@, durationThreshold:%f, mode:%lu", [self.target description], NSStringFromSelector(self.selector), self.durationThreshold, (unsigned long)self.mode];
}

#pragma mark Private Method

- (ThrottleDealloc *)throttleDeallocObject {
   
   int                            nErr                                     = EFAULT;
   
   ThrottleDealloc               *stDealloc                                = nil;
   
   __TRY;
   
   stDealloc   = objc_getAssociatedObject(self.target, self.selector);
   
   if (!stDealloc) {
      
      stDealloc      = [ThrottleDealloc new];
      stDealloc.rule = self;
      stDealloc.clzz = object_getClass(self.target);
      
      objc_setAssociatedObject(self.target, self.selector, stDealloc, OBJC_ASSOCIATION_RETAIN);
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return stDealloc;
}

#pragma mark NSSecureCoding

+ (BOOL)supportsSecureCoding {
   
   return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   if (throttle_object_isClass(self.target)) {
      
      Class     stClass    = self.target;
      NSString *szClassKey = @"target";
      
      if (class_isMetaClass(stClass)) {
         
         szClassKey = @"meta_target";
         
      } /* End if () */
      
      [aCoder encodeObject:NSStringFromClass(stClass) forKey:szClassKey];
      [aCoder encodeObject:NSStringFromSelector(self.selector) forKey:@"selector"];
      [aCoder encodeDouble:self.durationThreshold forKey:@"durationThreshold"];
      [aCoder encodeObject:@(self.mode) forKey:@"mode"];
      [aCoder encodeDouble:self.lastTimeRequest forKey:@"lastTimeRequest"];
      [aCoder encodeBool:self.isPersistent forKey:@"persistent"];
      [aCoder encodeObject:NSStringFromSelector(self.aliasSelector) forKey:@"aliasSelector"];
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
   
   int                            nErr                                     = EFAULT;
   
   ThrottleRule                  *stThrottleRule                           = nil;
   
   __TRY;
   
   id  stTarget   = NSClassFromString([aDecoder decodeObjectOfClass:NSString.class forKey:@"target"]);
   if (!stTarget) {
      
      stTarget = NSClassFromString([aDecoder decodeObjectOfClass:NSString.class forKey:@"meta_target"]);
      stTarget = throttleMetaClass(stTarget);
      
   } /* End if () */
   
   if (stTarget) {
      
      SEL                   stSelector          = NSSelectorFromString([aDecoder decodeObjectOfClass:NSString.class forKey:@"selector"]);
      NSTimeInterval        dDurationThreshold  = [aDecoder decodeDoubleForKey:@"durationThreshold"];
      ThrottlePerformMode   eMode               = [[aDecoder decodeObjectForKey:@"mode"] unsignedIntegerValue];
      NSTimeInterval        dLastTimeRequest    = [aDecoder decodeDoubleForKey:@"lastTimeRequest"];
      BOOL                  bPersistent         = [aDecoder decodeBoolForKey:@"persistent"];
      NSString             *szAliasSelector     = [aDecoder decodeObjectOfClass:NSString.class forKey:@"aliasSelector"];
      
      self = [self initWithTarget:stTarget selector:stSelector durationThreshold:dDurationThreshold];
      
      if (nil != self) {
         
         self.mode            = eMode;
         self.lastTimeRequest = dLastTimeRequest;
         self.persistent      = bPersistent;
         self.aliasSelector   = NSSelectorFromString(szAliasSelector);
         
      } /* End if () */
      
      stThrottleRule = self;
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return stThrottleRule;
}

@end

@interface ThrottleInvocation ()

@property (nonatomic, weak, readwrite)       NSInvocation                        * invocation;
@property (nonatomic, weak, readwrite)       ThrottleRule                        * rule;

@end

@implementation ThrottleInvocation

@end

@interface ThrottleEngine ()

@property (nonatomic, strong)                NSMapTable<id, NSMutableSet<NSString *> *>   * targetSELs;
@property (nonatomic, strong)                NSMutableSet<Class>                    * classHooked;

- (void)discardRule:(ThrottleRule *)rule whenTargetDealloc:(ThrottleDealloc *)mtDealloc;

@end

@implementation ThrottleEngine

static pthread_mutex_t g_stMutex;

NSString * const kThrottlePersistentRulesKey = @"kThrottlePersistentRulesKey";

+ (instancetype)defaultEngine {
   
   static dispatch_once_t onceToken;
   static ThrottleEngine *instance;
   
   dispatch_once(&onceToken, ^{
      instance = [ThrottleEngine new];
   });
   return instance;
}

+ (void)load {
   
   int                            nErr                                     = EFAULT;
   
   NSArray<NSData *>             *stArray                                  = nil;
   
   __TRY;
   
   stArray  = [NSUserDefaults.standardUserDefaults objectForKey:kThrottlePersistentRulesKey];
   
   for (NSData *stData in stArray) {
      
      if (@available(iOS 11.0, macOS 10.13, tvOS 11.0, watchOS 4.0, *)) {
         
         NSError        *stError = nil;
         ThrottleRule   *stRule  = [NSKeyedUnarchiver unarchivedObjectOfClass:ThrottleRule.class fromData:stData error:&stError];
         
         if (stError) {
            
            LogError((@"%@", stError.localizedDescription));
            
         } /* End if () */
         else {
            
            [stRule apply];
            
         } /* End else */
         
      } /* End if () */
      else {
         
         @try {
            
            ThrottleRule   *stRule = [NSKeyedUnarchiver unarchiveObjectWithData:stData];
            [stRule apply];
            
         } /* End @try */
         @catch (NSException *_E) {
            
            LogError((@"%@", _E.description));
            
         } /* End @catch () */
      }
   }
   
   __CATCH(nErr);
   
   return;
}

- (instancetype)init {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self = [super init];
   
   if (self) {
      
      _targetSELs = [NSMapTable weakToStrongObjectsMapTable];
      _classHooked = [NSMutableSet set];
      
      pthread_mutex_init(&g_stMutex, NULL);
      
      NSNotificationName    szName = nil;
      
#if (TARGET_OS_IOS || TARGET_OS_TV)
      szName   = UIApplicationWillTerminateNotification;
#elif (TARGET_OS_OSX)
      szName   = NSApplicationWillTerminateNotification;
#endif
      
      if (szName.length > 0) {
         
         [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleAppWillTerminateNotification:) name:szName object:nil];
         
      } /* End if () */
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (void)handleAppWillTerminateNotification:(NSNotification *)aNotification {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   if (@available(macOS 10.11, *)) {
      
      [self savePersistentRules];
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return;
}

- (void)savePersistentRules {
   
   int                            nErr                                     = EFAULT;
   
   NSMutableArray<NSData *>      *stArray                                  = [NSMutableArray array];
   
   __TRY;
   
   for (ThrottleRule *stRule in self.allRules) {
      
      if (stRule.isPersistent) {
         
         NSData   *stData     = nil;
         if (@available(iOS 11.0, macOS 10.13, tvOS 11.0, watchOS 4.0, *)) {
            
            NSError *error = nil;
            
            stData = [NSKeyedArchiver archivedDataWithRootObject:stRule requiringSecureCoding:YES error:&error];
            
            if (error) {
               
               LogError((@"%@", error.localizedDescription));
               
            } /* End if () */
            
         } /* End if () */
         else {
            
            stData = [NSKeyedArchiver archivedDataWithRootObject:stRule];
            
         } /* End else */
         
         if (stData) {
            
            [stArray addObject:stData];
            
         } /* End if () */
         
      } /* End if () */
      
   } /* End for () */
   
   [NSUserDefaults.standardUserDefaults setObject:stArray forKey:kThrottlePersistentRulesKey];
   
   __CATCH(nErr);
   
   return;
}

- (NSArray<ThrottleRule *> *)allRules {
   
   int                            nErr                                     = EFAULT;
   
   NSMutableArray<ThrottleRule *>*stRules                                  = [NSMutableArray<ThrottleRule *> array];
   
   __TRY;
   
   pthread_mutex_lock(&g_stMutex);
   
   for (id stTarget in [[self.targetSELs keyEnumerator] allObjects]) {
      
      NSMutableSet   *stSelectors   = [self.targetSELs objectForKey:stTarget];
      
      for (NSString *szSelectorName in stSelectors) {
         
         LogDebug((@"-[ThrottleEngine allRules] : SelectorName : %@", szSelectorName));
         
         ThrottleDealloc *stDealloc = objc_getAssociatedObject(stTarget, NSSelectorFromString(szSelectorName));
         
         if (stDealloc.rule) {
            
            [stRules addObject:stDealloc.rule];
            
         } /* End if () */
         
      } /* End for () */
      
   } /* End for () */
   
   pthread_mutex_unlock(&g_stMutex);
   
   __CATCH(nErr);
   
   return stRules;
}

/**
 添加 target-selector 记录
 
 @param selector 方法名
 @param target 对象，类，元类
 */
- (void)addSelector:(SEL)aSelector onTarget:(id)aTarget {
   
   int                            nErr                                     = EFAULT;
   
   NSMutableSet                  *stSelectors                              = nil;
   
   __TRY;
   
   if (!aTarget) {
      
      nErr  = EINVAL;
      
      break;
      
   } /* End if () */
   
   stSelectors = [self.targetSELs objectForKey:aTarget];
   
   if (!stSelectors) {
      
      stSelectors = [NSMutableSet set];
      
   } /* End if () */
   
   [stSelectors addObject:NSStringFromSelector(aSelector)];
   [self.targetSELs setObject:stSelectors forKey:aTarget];
   
   __CATCH(nErr);
   
   return;
}

/**
 移除 target-selector 记录
 
 @param selector 方法名
 @param target 对象，类，元类
 */
- (void)removeSelector:(SEL)aSelector onTarget:(id)aTarget
{
   int                            nErr                                     = EFAULT;
   
   NSMutableSet                  *stSelectors                              = nil;
   
   __TRY;
   
   if (!aTarget) {
      
      nErr  = EINVAL;
      
      break;
      
   } /* End if () */
   
   stSelectors = [self.targetSELs objectForKey:aTarget];
   
   if (!stSelectors) {
      
      stSelectors = [NSMutableSet set];
      
   } /* End if () */
   
   [stSelectors removeObject:NSStringFromSelector(aSelector)];
   [self.targetSELs setObject:stSelectors forKey:aTarget];
   
   __CATCH(nErr);
   
   return;
}

/**
 是否存在 target-selector 记录
 
 @param selector 方法名
 @param target 对象，类，元类
 @return 是否存在记录
 */
- (BOOL)containsSelector:(SEL)aSelector onTarget:(id)aTarget {
   
   LogDebug((@"-[ThrottleEngine containsSelector] : Selector : %p : %@", aSelector, NSStringFromSelector(aSelector)));
   LogDebug((@"-[ThrottleEngine containsSelector] : Target   : %@", aTarget));
   
   return [[self.targetSELs objectForKey:aTarget] containsObject:NSStringFromSelector(aSelector)];
}

/**
 是否存在 target-selector 记录，未指定具体 target，但 target 的类型为 cls 即可
 
 @param aSelector 方法名
 @param aClass 类
 @return 是否存在记录
 */
- (BOOL)containsSelector:(SEL)aSelector onTargetsOfClass:(Class)aClass {
   
   int                            nErr                                     = EFAULT;
   
   BOOL                           bFound                                   = NO;
   
   __TRY;
   
   for (id target in [[self.targetSELs keyEnumerator] allObjects]) {
      
      if (!throttle_object_isClass(target) &&
          object_getClass(target) == aClass &&
          [[self.targetSELs objectForKey:target] containsObject:NSStringFromSelector(aSelector)]) {
         
         bFound   = YES;
         
         break;
         
      } /* End if () */
      
   } /* End for () */
   
   __CATCH(nErr);
   
   return bFound;
}

- (BOOL)applyRule:(ThrottleRule *)aRule {
   
   int                            nErr                                     = EFAULT;
   
   BOOL                           bShouldApply                             = YES;
   ThrottleDealloc               *stDealloc                                = nil;
   
   __TRY;
   
   pthread_mutex_lock(&g_stMutex);
   
   stDealloc   = [aRule throttleDeallocObject];
   
   [stDealloc lock];
   
   if (throttleCheckRuleValid(aRule)) {
      
      for (id stTarget in [[self.targetSELs keyEnumerator] allObjects]) {
         
         NSMutableSet   *stSelectors      = [self.targetSELs objectForKey:stTarget];
         NSString       *szSelectorName   = NSStringFromSelector(aRule.selector);
         
         if ([stSelectors containsObject:szSelectorName]) {
            
            if (stTarget == aRule.target) {
               
               bShouldApply = NO;
               
               continue;
               
            } /* End if () */
            
            if (throttle_object_isClass(aRule.target) && throttle_object_isClass(stTarget)) {
               
               Class stClassA = aRule.target;
               Class stClassB = stTarget;
               bShouldApply = !([stClassA isSubclassOfClass:stClassB] || [stClassB isSubclassOfClass:stClassA]);
               
               // inheritance relationship
               if (!bShouldApply) {
                  
                  LogDebug((@"Sorry: %@ already apply rule in %@. A message can only have one rule per class hierarchy.", szSelectorName, NSStringFromClass(stClassB)));
                  
                  break;
                  
               } /* End if () */
               
            } /* End if () */
            else if (throttle_object_isClass(stTarget) && stTarget == object_getClass(aRule.target)) {
               
               bShouldApply = NO;
               LogDebug((@"Sorry: %@ already apply rule in target's Class(%@).", szSelectorName, stTarget));
               
               break;
               
            } /* End else */
            
         } /* End if () */
         
      } /* End for () */
      
      bShouldApply = bShouldApply && throttleOverrideMethod(aRule);
      
      if (bShouldApply) {
         
         [self addSelector:aRule.selector onTarget:aRule.target];
         aRule.active = YES;
         
      } /* End if () */
      
   } /* End if () */
   else {
      
      bShouldApply = NO;
      LogError((@"Sorry: invalid rule."));
      
   } /* End if () */
   
   [stDealloc unlock];
   if (!bShouldApply) {
      
      objc_setAssociatedObject(aRule.target, aRule.selector, nil, OBJC_ASSOCIATION_RETAIN);
      
   } /* End if () */
   
   pthread_mutex_unlock(&g_stMutex);
   
   __CATCH(nErr);
   
   return bShouldApply;
}

- (BOOL)discardRule:(ThrottleRule *)aRule
{
   int                            nErr                                     = EFAULT;
   
   BOOL                           bShouldDiscard                           = NO;
   ThrottleDealloc               *stDealloc                                = nil;
   
   __TRY;
   
   pthread_mutex_lock(&g_stMutex);
   
   stDealloc   = [aRule throttleDeallocObject];
   
   [stDealloc lock];
   
   if (throttleCheckRuleValid(aRule)) {
      
      [self removeSelector:aRule.selector onTarget:aRule.target];
      bShouldDiscard = throttleRecoverMethod(aRule.target, aRule.selector, aRule.aliasSelector);
      aRule.active = NO;
      
   } /* End if () */
   
   [stDealloc unlock];
   pthread_mutex_unlock(&g_stMutex);
   
   __CATCH(nErr);
   
   return bShouldDiscard;
}

- (void)discardRule:(ThrottleRule *)aRule whenTargetDealloc:(ThrottleDealloc *)aThrottleDealloc {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   if (throttle_object_isClass(aRule.target)) {
      
      break;
      
   } /* End if () */
   
   pthread_mutex_lock(&g_stMutex);
   
   [aThrottleDealloc lock];
   
   if (![self containsSelector:aRule.selector onTarget:aThrottleDealloc.clzz] &&
       ![self containsSelector:aRule.selector onTargetsOfClass:aThrottleDealloc.clzz]) {
      
      throttleRevertHook(aThrottleDealloc.clzz, aRule.selector, aRule.aliasSelector);
      
   } /* End if () */
   
   aRule.active   = NO;
   [aThrottleDealloc unlock];
   pthread_mutex_unlock(&g_stMutex);
   
   __CATCH(nErr);
   
   return;
}

#pragma mark - Private Helper Function

NS_INLINE BOOL throttleCheckRuleValid(ThrottleRule *aRule) {
   
   int                            nErr                                     = EFAULT;
   
   BOOL                           bValid                                   = NO;
   
   __TRY;
   
   if (aRule.target && aRule.selector && aRule.durationThreshold > 0) {
      
      NSString *szSelectorName   = NSStringFromSelector(aRule.selector);
      
      if ([szSelectorName isEqualToString:@"forwardInvocation:"]) {
         
         bValid   = NO;
         
         nErr     = noErr;
         
         break;
         
      } /* End if () */
      
      Class     stClass       = [aRule.target class];
      NSString *szClassName   = NSStringFromClass(stClass);
      
      if ([szClassName isEqualToString:@"ThrottleRule"] || [szClassName isEqualToString:@"ThrottleEngine"]) {
         
         bValid   = NO;
         
         nErr     = noErr;
         
         break;
         
      } /* End if () */
      
      bValid   = YES;
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return bValid;
}

NS_INLINE BOOL throttleInvokeFilterBlock(ThrottleRule *aRule, NSInvocation *aOriginalInvocation) {
   
   int                            nErr                                     = EFAULT;
   
   BOOL                           bReturnedValue                           = NO;
   ThrottleInvocation            *stInvocation                             = nil;
   
   void                          *pvArgBuf                                 = NULL;
   
   __TRY;
   
   if (!aRule.alwaysInvokeBlock || ![aRule.alwaysInvokeBlock isKindOfClass:NSClassFromString(@"NSBlock")]) {
      
      bReturnedValue = NO;
      
      break;
      
   } /* End if () */
   
   NSMethodSignature *stFilterBlockSignature = [NSMethodSignature signatureWithObjCTypes:throttleBlockMethodSignature(aRule.alwaysInvokeBlock)];
   NSInvocation      *stBlockInvocation      = [NSInvocation invocationWithMethodSignature:stFilterBlockSignature];
   NSUInteger         nNumberOfArguments     = stFilterBlockSignature.numberOfArguments;
   
   if (nNumberOfArguments > aOriginalInvocation.methodSignature.numberOfArguments) {
      
      LogDebug((@"Block has too many arguments. Not calling %@", aRule));
      
      bReturnedValue = NO;
      
      break;
      
   } /* End if () */
   
   if (nNumberOfArguments > 1) {
      
      stInvocation = [ThrottleInvocation new];
      stInvocation.invocation = aOriginalInvocation;
      stInvocation.rule = aRule;
      [stBlockInvocation setArgument:&stInvocation atIndex:1];
      
   } /* End if () */
   
   for (NSUInteger nIndex = 2; nIndex < nNumberOfArguments; nIndex++) {
      
      const char  *cpszType   = [aOriginalInvocation.methodSignature getArgumentTypeAtIndex:nIndex];
      NSUInteger   nArgSize   = 0;
      NSGetSizeAndAlignment(cpszType, &nArgSize, NULL);
      
      if (!(pvArgBuf = reallocf(pvArgBuf, nArgSize))) {
         
         LogDebug((@"Failed to allocate memory for block invocation."));
         
         bReturnedValue = NO;
         nErr           = ENOMEM;
         
         break;
         
      } /* End if () */
      
      [aOriginalInvocation getArgument:pvArgBuf atIndex:nIndex];
      [stBlockInvocation setArgument:pvArgBuf atIndex:nIndex];
      
   } /* End for () */
   
   if (NULL == pvArgBuf) {
      
      break;
      
   } /* End if () */
   
   [stBlockInvocation invokeWithTarget:aRule.alwaysInvokeBlock];
   
   [stBlockInvocation getReturnValue:&bReturnedValue];
   
   //   if (pvArgBuf != NULL) {
   //
   //      free(pvArgBuf);
   //
   //   } /* End if () */
   
   __CATCH(nErr);
   
   FREE_IF(pvArgBuf);
   
   return bReturnedValue;
}

/**
 处理执行 NSInvocation
 
 @param invocation NSInvocation 对象
 @param rule ThrottleRule 对象
 */
NS_INLINE void throttleHandleInvocation(NSInvocation *aInvocation, ThrottleRule *aRule) {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   NSCParameterAssert(aInvocation);
   NSCParameterAssert(aRule);
   
   if (!aRule.isActive) {
      
      [aInvocation invoke];
      
      nErr  = noErr;
      
      break;
      
   } /* End if () */
   
   if (aRule.durationThreshold <= 0 || throttleInvokeFilterBlock(aRule, aInvocation)) {
      
      aInvocation.selector = aRule.aliasSelector;
      [aInvocation invoke];
      
      nErr  = noErr;
      
      break;
      
   } /* End if () */
   
   NSTimeInterval dNow = [[NSDate date] timeIntervalSince1970];
   dNow += ThrottleEngine.defaultEngine.correctionForSystemTime;
   
   switch (aRule.mode) {
      
   case ThrottlePerformModeFirstly: {
      
      if (dNow - aRule.lastTimeRequest > aRule.durationThreshold) {
         
         aInvocation.selector = aRule.aliasSelector;
         [aInvocation invoke];
         aRule.lastTimeRequest = dNow;
         
         dispatch_async(aRule.messageQueue, ^{
            
            // May switch from other modes, set nil just in case.
            aRule.lastInvocation = nil;
         });
         
      } /* End if () */
      break;
   }
   case ThrottlePerformModeLast: {
      
      aInvocation.selector = aRule.aliasSelector;
      [aInvocation retainArguments];
      
      dispatch_async(aRule.messageQueue, ^{
         
         aRule.lastInvocation = aInvocation;
         
         if (dNow - aRule.lastTimeRequest > aRule.durationThreshold) {
            
            aRule.lastTimeRequest = dNow;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(aRule.durationThreshold * NSEC_PER_SEC)), aRule.messageQueue, ^{
               if (!aRule.isActive) {
                  
                  aRule.lastInvocation.selector = aRule.selector;
                  
               } /* End if () */
               [aRule.lastInvocation invoke];
               aRule.lastInvocation = nil;
            });
         } /* End if () */
      });
      
      break;
   }
   case ThrottlePerformModeDebounce: {
      
      aInvocation.selector = aRule.aliasSelector;
      [aInvocation retainArguments];
      
      dispatch_async(aRule.messageQueue, ^{
         
         aRule.lastInvocation = aInvocation;
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(aRule.durationThreshold * NSEC_PER_SEC)), aRule.messageQueue, ^{
            
            if (aRule.lastInvocation == aInvocation) {
               
               if (!aRule.isActive) {
                  
                  aRule.lastInvocation.selector = aRule.selector;
                  
               } /* End if () */
               
               [aRule.lastInvocation invoke];
               aRule.lastInvocation = nil;
               
            } /* End if () */
         });
      });
      break;
   }
   }
   
   __CATCH(nErr);
   
   return;
}

NS_INLINE void throttleForwardInvocation(__unsafe_unretained id aAssignSelf, SEL aSelector, NSInvocation *aInvocation) {
   
   int                            nErr                                     = EFAULT;
   
   ThrottleDealloc               *stDealloc                                = nil;
   
   BOOL                           bRespondsToAlias                         = YES;
   Class                          stClass                                  = nil;
   
   __TRY;
   
   if (!throttle_object_isClass(aInvocation.target)) {
      
      stDealloc = objc_getAssociatedObject(aInvocation.target, aInvocation.selector);
      
   } /* End if () */
   else {
      
      stDealloc = objc_getAssociatedObject(object_getClass(aInvocation.target), aInvocation.selector);
      
   } /* End if () */
   
   stClass  = object_getClass(aInvocation.target);
   
   do {
      
      if (!stDealloc.rule) {
         
         stDealloc = objc_getAssociatedObject(stClass, aInvocation.selector);
         
      } /* End if () */
      
      if ((bRespondsToAlias = [stClass instancesRespondToSelector:stDealloc.rule.aliasSelector])) {
         
         break;
         
      } /* End if () */
      
      stDealloc = nil;
      
   } while (!bRespondsToAlias && (stClass = class_getSuperclass(stClass)));  /* End do while () */
   
   [stDealloc lock];
   
   if (!bRespondsToAlias) {
      
      throttleExecuteOrigForwardInvocation(aAssignSelf, aSelector, aInvocation);
      
   } /* End if () */
   else {
      
      throttleHandleInvocation(aInvocation, stDealloc.rule);
      
   } /* End if () */
   
   [stDealloc unlock];
   
   __CATCH(nErr);
   
   return;
}

static NSString *const ThrottleForwardInvocationSelectorName   = @"__throttleForwardInvocation:";
static NSString *const ThrottleSubclassPrefix                  = @"_IDEAThrottle_";

/**
 获取实例对象的类。如果 instance 是类对象，则返回元类。
 兼容 KVO 用子类替换 isa 并覆写 class 方法的场景。
 */
NS_INLINE Class throttleClassOfTarget(id aTarget) {
   
   int                            nErr                                     = EFAULT;
   
   Class                          stClass                                  = nil;
   
   __TRY;
   
   if (throttle_object_isClass(aTarget)) {
      
      stClass = object_getClass(aTarget);
      
   } /* End if () */
   else {
      
      stClass = [aTarget class];
      
   } /* End else */
   
   __CATCH(nErr);
   
   return stClass;
}

NS_INLINE void throttleHookedGetClass(Class aClass, Class aStatedClass) {
   
   int                            nErr                                     = EFAULT;
   
   Method                         stMethod                                 = nil;
   IMP                            stNewIMP                                 = nil;
   
   __TRY;
   
   NSCParameterAssert(aClass);
   NSCParameterAssert(aStatedClass);
   stMethod = class_getInstanceMethod(aClass, @selector(class));
   stNewIMP = imp_implementationWithBlock(^(id self) {
      
      return aStatedClass;
   });
   
   class_replaceMethod(aClass, @selector(class), stNewIMP, method_getTypeEncoding(stMethod));
   
   __CATCH(nErr);
   
   return;
}

NS_INLINE BOOL throttleIsMsgForwardIMP(IMP aImpl) {
   
   return aImpl == _objc_msgForward
#if !defined(__arm64__)
   || impl == (IMP)_objc_msgForward_stret
#endif
   ;
}

NS_INLINE IMP throttleGetMsgForwardIMP(Class aClass, SEL selector) {
   
   IMP    stMsgForwardIMP     = _objc_msgForward;
   
#if !defined(__arm64__)
   Method       stOriginMethod   = class_getInstanceMethod(aClass, selector);
   const char  *cpcOriginType    = (char *)method_getTypeEncoding(stOriginMethod);
   
   if (cpcOriginType != NULL && cpcOriginType[0] == _C_STRUCT_B) {
      
      //In some cases that returns struct, we should use the '_stret' API:
      //http://sealiesoftware.com/blog/archive/2008/10/30/objc_explain_objc_msgSend_stret.html
      // As an ugly internal runtime implementation detail in the 32bit runtime, we need to determine of the method we hook returns a struct or anything larger than id.
      // https://developer.apple.com/library/mac/documentation/DeveloperTools/Conceptual/LowLevelABI/000-Introduction/introduction.html
      // https://github.com/ReactiveCocoa/ReactiveCocoa/issues/783
      // http://infocenter.arm.com/help/topic/com.arm.doc.ihi0042e/IHI0042E_aapcs.pdf (Section 5.4)
      //NSMethodSignature knows the detail but has no API to return, we can only get the info from debugDescription.
      NSMethodSignature *stMethodSignature   = [NSMethodSignature signatureWithObjCTypes:cpcOriginType];
      
      if ([stMethodSignature.debugDescription rangeOfString:@"is special struct return? YES"].location != NSNotFound) {
         
         stMsgForwardIMP = (IMP)_objc_msgForward_stret;
         
      } /* End if () */
      
   } /* End if () */
#endif
   
   return stMsgForwardIMP;
}

NS_INLINE BOOL throttleOverrideMethod(ThrottleRule *aRule) {
   
   id        stTarget         = aRule.target;
   SEL       stSelector       = aRule.selector;
   SEL       stAliasSelector  = aRule.aliasSelector;
   Class     stClass;
   Class     stStatedClass    = [stTarget class];
   Class     stBaseClass      = object_getClass(stTarget);
   NSString *szClassName      = NSStringFromClass(stBaseClass);
   
   if ([szClassName hasPrefix:ThrottleSubclassPrefix]) {
      
      stClass = stBaseClass;
      
   } /* End if () */
   else if (throttle_object_isClass(stTarget)) {
      
      stClass = stTarget;
      
   } /* End else if () */
   else if (stStatedClass != stBaseClass) {
      
      stClass = stBaseClass;
      
   } /* End else if () */
   else {
      
      const char  *cpcSubclassName  = [ThrottleSubclassPrefix stringByAppendingString:szClassName].UTF8String;
      Class        stSubClass       = objc_getClass(cpcSubclassName);
      
      if (stSubClass == nil) {
         
         stSubClass = objc_allocateClassPair(stBaseClass, cpcSubclassName, 0);
         
         if (stSubClass == nil) {
            
            LogError((@"objc_allocateClassPair failed to allocate class %s.", cpcSubclassName));
            
            return NO;
            
         } /* End if () */
         
         throttleHookedGetClass(stSubClass, stStatedClass);
         throttleHookedGetClass(object_getClass(stSubClass), stStatedClass);
         objc_registerClassPair(stSubClass);
         
      } /* End else */
      
      object_setClass(stTarget, stSubClass);
      stClass = stSubClass;
      
   } /* End else */
   
   // check if subclass has hooked!
   for (Class clsHooked in ThrottleEngine.defaultEngine.classHooked) {
      
      if (clsHooked != stClass && [clsHooked isSubclassOfClass:stClass]) {
         
         LogError((@"Sorry: %@ used to be applied, can't apply it's super class %@!", NSStringFromClass(stClass), NSStringFromClass(stClass)));
         
         return NO;
         
      } /* End if () */
      
   } /* End for () */
   
   [aRule throttleDeallocObject].clzz = stClass;
   
   if (class_getMethodImplementation(stClass, @selector(forwardInvocation:)) != (IMP)throttleForwardInvocation) {
      
      IMP stOriginalImplementation = class_replaceMethod(stClass, @selector(forwardInvocation:), (IMP)throttleForwardInvocation, "v@:@");
      
      if (stOriginalImplementation) {
         
         class_addMethod(stClass, NSSelectorFromString(ThrottleForwardInvocationSelectorName), stOriginalImplementation, "v@:@");
         
      } /* End if () */
      
   } /* End if () */
   
   Class  stSuperClass        = class_getSuperclass(stClass);
   Method stTargetMethod      = class_getInstanceMethod(stClass, stSelector);
   IMP    stTargetMethodIMP   = method_getImplementation(stTargetMethod);
   
   if (!throttleIsMsgForwardIMP(stTargetMethodIMP)) {
      
      const char  *cpcTypeEncoding           = method_getTypeEncoding(stTargetMethod);
      Method       stTargetAliasMethod       = class_getInstanceMethod(stClass, stAliasSelector);
      Method       stTargetAliasMethodSuper  = class_getInstanceMethod(stSuperClass, stAliasSelector);
      
      if (![stClass instancesRespondToSelector:stAliasSelector] || stTargetAliasMethod == stTargetAliasMethodSuper) {
         
         __unused BOOL bAddedAlias = class_addMethod(stClass, stAliasSelector, method_getImplementation(stTargetMethod), cpcTypeEncoding);
         NSCAssert(bAddedAlias, @"Original implementation for %@ is already copied to %@ on %@", NSStringFromSelector(stSelector), NSStringFromSelector(stAliasSelector), stClass);
         
      } /* End if () */
      
      class_replaceMethod(stClass, stSelector, throttleGetMsgForwardIMP(stStatedClass, stSelector), cpcTypeEncoding);
      [ThrottleEngine.defaultEngine.classHooked addObject:stClass];
      
   } /* End if () */
   
   return YES;
}

NS_INLINE void throttleRevertHook(Class aClass, SEL aSelector, SEL aAliasSelector) {
   
   int                            nErr                                     = EFAULT;
   
   Method                         stTargetMethod                           = nil;
   IMP                            stTargetMethodIMP                        = nil;
   
   __TRY;
   
   stTargetMethod    = class_getInstanceMethod(aClass, aSelector);
   stTargetMethodIMP = method_getImplementation(stTargetMethod);
   
   if (throttleIsMsgForwardIMP(stTargetMethodIMP)) {
      
      const char  *cpcTypeEncoding  = method_getTypeEncoding(stTargetMethod);
      Method       stOriginalMethod = class_getInstanceMethod(aClass, aAliasSelector);
      IMP          stOriginalIMP    = method_getImplementation(stOriginalMethod);
      
      NSCAssert(stOriginalMethod, @"Original implementation for %@ not found %@ on %@", NSStringFromSelector(aSelector), NSStringFromSelector(aAliasSelector), aClass);
      
      class_replaceMethod(aClass, aSelector, stOriginalIMP, cpcTypeEncoding);
      
   } /* End if () */
   
   if (class_getMethodImplementation(aClass, @selector(forwardInvocation:)) == (IMP)throttleForwardInvocation) {
      
      Method    stOriginalMethod          = class_getInstanceMethod(aClass, NSSelectorFromString(ThrottleForwardInvocationSelectorName));
      Method    stObjectMethod            = class_getInstanceMethod(NSObject.class, @selector(forwardInvocation:));
      IMP       stOriginalImplementation  = method_getImplementation(stOriginalMethod ?: stObjectMethod);
      
      class_replaceMethod(aClass, @selector(forwardInvocation:), stOriginalImplementation, "v@:@");
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return;
}

NS_INLINE BOOL throttleRecoverMethod(id aTarget, SEL aSelector, SEL aAliasSelector) {
   
   int                            nErr                                     = EFAULT;
   
   Class                          stClass                                  = nil;
   
   __TRY;
   
   if (throttle_object_isClass(aTarget)) {
      
      stClass = aTarget;
      
      if ([ThrottleEngine.defaultEngine containsSelector:aSelector onTargetsOfClass:stClass]) {
         
         nErr  = EINVAL;
         
         break;
         //         return NO;
         
      } /* End if () */
      
   } /* End if () */
   else {
      
      ThrottleDealloc *stDealloc = objc_getAssociatedObject(aTarget, aSelector);
      // get class when apply rule on target.
      stClass = stDealloc.clzz;
      // target current real class name
      NSString *szClassName = NSStringFromClass(object_getClass(aTarget));
      if ([szClassName hasPrefix:ThrottleSubclassPrefix]) {
         
         Class stOriginalClass = NSClassFromString([szClassName stringByReplacingOccurrencesOfString:ThrottleSubclassPrefix withString:@""]);
         NSCAssert(stOriginalClass != nil, @"Original class must exist");
         if (stOriginalClass)
         {
            object_setClass(aTarget, stOriginalClass);
            
         } /* End if () */
         
      } /* End if () */
      if ([ThrottleEngine.defaultEngine containsSelector:aSelector onTarget:stClass] ||
          [ThrottleEngine.defaultEngine containsSelector:aSelector onTargetsOfClass:stClass]) {
         
         nErr  = noErr;
         
         break;
         //         return NO;
         
      } /* End if () */
      
   } /* End else */
   
   throttleRevertHook(stClass, aSelector, aAliasSelector);
   
   __CATCH(nErr);
   
   return (noErr == nErr);
}

NS_INLINE void throttleExecuteOrigForwardInvocation(id aSELF, SEL aSelector, NSInvocation *aInvocation) {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   SEL    stOrigForwardSelector  = NSSelectorFromString(ThrottleForwardInvocationSelectorName);
   
   if ([object_getClass(aSELF) instancesRespondToSelector:stOrigForwardSelector]) {
      
      NSMethodSignature *stMethodSignature   = [aSELF methodSignatureForSelector:stOrigForwardSelector];
      
      if (!stMethodSignature) {
         
         NSCAssert(NO, @"unrecognized selector -%@ for instance %@", NSStringFromSelector(stOrigForwardSelector), aSELF);
         
         //         return;
         
         break;
         
      } /* End if () */
      
      NSInvocation *stForwardInvocation   = [NSInvocation invocationWithMethodSignature:stMethodSignature];
      [stForwardInvocation setTarget:aSELF];
      [stForwardInvocation setSelector:stOrigForwardSelector];
      [stForwardInvocation setArgument:&aInvocation atIndex:2];
      [stForwardInvocation invoke];
      
   }  /* End if () */
   else {
      
      Class  stSuperClass           = [[aSELF class] superclass];
      Method stSuperForwardMethod   = class_getInstanceMethod(stSuperClass, @selector(forwardInvocation:));
      void (*superForwardIMP)(id, SEL, NSInvocation *);
      superForwardIMP = (void (*)(id, SEL, NSInvocation *))method_getImplementation(stSuperForwardMethod);
      superForwardIMP(aSELF, @selector(forwardInvocation:), aInvocation);
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return;
}

@end

@implementation NSObject (IDEAThrottle)

- (NSArray<ThrottleRule *> *)throttleAllRules {
   
   int                            nErr                                     = EFAULT;
   
   NSMutableArray<ThrottleRule *>*stRules                                  = [NSMutableArray array];
   
   __TRY;
   
   for (ThrottleRule *stRule in ThrottleEngine.defaultEngine.allRules)
   {
      if (stRule.target == self || stRule.target == throttleClassOfTarget(self))
      {
         [stRules addObject:stRule];
         
      } /* End if () */
      
   } /* End for () */
   
   __CATCH(nErr);
   
   return stRules;
}

- (nullable ThrottleRule *)throttleLimitSelector:(SEL)aSelector oncePerDuration:(NSTimeInterval)dDurationThreshold {
   
   return [self throttleLimitSelector:aSelector oncePerDuration:dDurationThreshold usingMode:ThrottlePerformModeDebounce];
}

- (nullable ThrottleRule *)throttleLimitSelector:(SEL)aSelector oncePerDuration:(NSTimeInterval)dDurationThreshold usingMode:(ThrottlePerformMode)aMode {
   
   return [self throttleLLimitSelector:aSelector oncePerDuration:dDurationThreshold usingMode:aMode onMessageQueue:dispatch_get_main_queue()];
}

- (nullable ThrottleRule *)throttleLLimitSelector:(SEL)aSelector oncePerDuration:(NSTimeInterval)dDurationThreshold usingMode:(ThrottlePerformMode)aMode onMessageQueue:(dispatch_queue_t)aMessageQueue {
   
   return [self throttleLimitSelector:aSelector oncePerDuration:dDurationThreshold usingMode:aMode onMessageQueue:aMessageQueue alwaysInvokeBlock:nil];
}

- (nullable ThrottleRule *)throttleLimitSelector:(SEL)aSelector oncePerDuration:(NSTimeInterval)dDurationThreshold usingMode:(ThrottlePerformMode)aMode onMessageQueue:(dispatch_queue_t)aMessageQueue alwaysInvokeBlock:(id)aAlwaysInvokeBlock {
   
   int                            nErr                                     = EFAULT;
   
   ThrottleDealloc               *stDealloc                                = nil;
   ThrottleRule                  *stRule                                   = nil;
   BOOL                           bIsNewRule                               = NO;
   
   __TRY;
   
   stDealloc   = objc_getAssociatedObject(self, aSelector);
   stRule      = stDealloc.rule;
   
   if (!stRule) {
      
      stRule = [[ThrottleRule alloc] initWithTarget:self selector:aSelector durationThreshold:dDurationThreshold];
      bIsNewRule = YES;
      
   } /* End if () */
   
   stRule.durationThreshold   = dDurationThreshold;
   stRule.mode                = aMode;
   stRule.messageQueue        = aMessageQueue ?: dispatch_get_main_queue();
   stRule.alwaysInvokeBlock   = aAlwaysInvokeBlock;
   stRule.persistent          = (aMode == ThrottlePerformModeFirstly && dDurationThreshold > 5 && throttle_object_isClass(self));
   
   if (bIsNewRule) {
      
      if (NO == [stRule apply]) {
         
         __RELEASE(stRule);
         
         break;
         
      } /* End if () */
      
//      return [stRule apply] ? stRule : nil;
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return stRule;
}

@end
