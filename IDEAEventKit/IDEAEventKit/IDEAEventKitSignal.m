//
//  IDEAEventKitSignal.m
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKit/IDEAEventKitSignal.h"

#import "IDEAEventKit/IDEAEventKitProperty.h"
#import "IDEAEventKit/IDEAEventKitSignalBus.h"
#import "IDEAEventKit/IDEAEventKitThread.h"

#import "IDEAEventKit/NSObject+EventKit.h"
#import "IDEAEventKit/NSMutableArray+EventKit.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation NSObject(SignalResponder)

@def_prop_dynamic( IDEAEventKitSignalBlock   , onSignal       );
@def_prop_dynamic( NSMutableArray         *, userResponders );

#pragma mark -

- (IDEAEventKitSignalBlock)onSignal {
   
   @weakify(self);
   
   IDEAEventKitSignalBlock stBlock = ^ NSObject * (NSString *aName, id aSignalBlock) {
      
      @strongify(self);
      
      aName = [aName stringByReplacingOccurrencesOfString:@"signal."    withString:@"handleSignal____"];
      aName = [aName stringByReplacingOccurrencesOfString:@"signal____" withString:@"handleSignal____"];
      aName = [aName stringByReplacingOccurrencesOfString:@"-"          withString:@"____"];
      aName = [aName stringByReplacingOccurrencesOfString:@"."          withString:@"____"];
      aName = [aName stringByReplacingOccurrencesOfString:@"/"          withString:@"____"];
      aName = [aName stringByAppendingString:@":"];
      
      if (aSignalBlock) {
         
         [self addBlock:aSignalBlock forName:aName];
         
      } /* End if () */
      else {
         
         [self removeBlockForName:aName];
         
      } /* End else */
      
      return self;
   };
   
   return [stBlock copy];
}

#pragma mark -

- (id)signalResponders {
   
   return [self userResponders];
}

- (id)signalAlias {
   
   return nil;
}

- (NSString *)signalNamespace {
   
   return NSStringFromClass([self class]);
}

- (NSString *)signalTag {
   
   return nil;
}

- (NSString *)signalDescription {
   
   return [NSString stringWithFormat:@"%@", [[self class] description]];
}

#pragma mark -

- (id)userRespondersOrCreate {
   
   const char        *cpcStoreKey   = "NSObject.userResponders";
   NSMutableArray    *stResponders  = [self getAssociatedObjectForKey:cpcStoreKey];
   
   if (nil == stResponders) {
      
      stResponders = [NSMutableArray nonRetainingArray];
      
      [self retainAssociatedObject:stResponders forKey:cpcStoreKey];
      
   } /* End if () */
   
   return stResponders;
}

- (NSMutableArray *)userResponders {
   
   const char *cpcStoreKey   = "NSObject.userResponders";
   
   return [self getAssociatedObjectForKey:cpcStoreKey];
}

#pragma mark -

- (BOOL)hasSignalResponder:(id)aObject {
   
   NSMutableArray *stResponders  = [self userResponders];
   
   if (nil == stResponders) {
      
      return NO;
      
   } /* End if () */
   
   for (id responder in stResponders) {
      
      if (responder == aObject) {
         
         return YES;
         
      } /* End if () */
      
   } /* End for () */
   
   return NO;
}

- (void)addSignalResponder:(id)aObject {
   
   NSMutableArray *stResponders  = [self userRespondersOrCreate];
   
   if (stResponders && NO == [stResponders containsObject:aObject]) {
      
      [stResponders addObject:aObject];
      
   } /* End if () */
   
   return;
}

- (void)removeSignalResponder:(id)aObject {
   
   NSMutableArray *stResponders  = [self userResponders];
   
   if (stResponders && [stResponders containsObject:aObject]) {
      
      [stResponders removeObject:aObject];
      
   } /* End if () */
   
   return;
}

- (void)removeAllSignalResponders {
   
   NSMutableArray *stResponders  = [self userResponders];
   
   if (stResponders) {
      
      [stResponders removeAllObjects];
      
   } /* End if () */
   
   return;
}

#pragma mark -

- (void)handleSignal:(IDEAEventKitSignal *)aSignal {
   
   UNUSED(aSignal);
   
   return;
}

@end

#pragma mark -

@implementation NSObject(SignalSender)

- (IDEAEventKitSignal *)sendSignal:(NSString *)aName {
   
   return [self sendSignal:aName from:self withObject:nil input:nil];
}

- (IDEAEventKitSignal *)sendSignal:(NSString *)aName withObject:(NSObject *)aObject {
   
   return [self sendSignal:aName from:self withObject:aObject input:nil];
}

- (IDEAEventKitSignal *)sendSignal:(NSString *)aName withObject:(NSObject *)aObject input:(NSDictionary *)aInput {
   
   return [self sendSignal:aName from:self withObject:aObject input:aInput];
}

- (IDEAEventKitSignal *)sendSignal:(NSString *)aName input:(NSDictionary *)aInput {
   
   return [self sendSignal:aName from:self withObject:nil input:aInput];
}

- (IDEAEventKitSignal *)sendSignal:(NSString *)aName from:(id)aSource {
   
   return [self sendSignal:aName from:aSource withObject:nil input:nil];
}

- (IDEAEventKitSignal *)sendSignal:(NSString *)aName from:(id)aSource input:(NSDictionary *)aInput {
   
   return [self sendSignal:aName from:aSource withObject:nil input:aInput];
}

- (IDEAEventKitSignal *)sendSignal:(NSString *)aName from:(id)aSource withObject:(NSObject *)aObject {
   
   //   IDEAEventKitSignal  *stSignal   = [IDEAEventKitSignal signal];
   //
   //   stSignal.source   = aSource ? aSource : self;
   //   stSignal.target   = self;
   //   stSignal.name     = aName;
   //   stSignal.object   = aObject;
   //
   //   [stSignal send];
   //
   //   return stSignal;
   
   return [self sendSignal:aName from:aSource withObject:aObject input:nil];
}

- (IDEAEventKitSignal *)sendSignal:(NSString *)aName from:(id)aSource withObject:(NSObject *)aObject input:(NSDictionary *)aInput {
   
   IDEAEventKitSignal  *stSignal   = [IDEAEventKitSignal signal];
   
   stSignal.source   = aSource ? aSource : self;
   stSignal.target   = self;
   stSignal.name     = aName;
   stSignal.object   = aObject;
   stSignal.input    = aInput ? [aInput mutableCopy] : nil;
   
   [stSignal send];
   
   return stSignal;
}

//- (void)postSignal:(NSString *)aName {
//
//   [self postSignal:aName from:self withObject:nil];
//
//   return;
//}
//
//- (void)postSignal:(NSString *)aName withObject:(NSObject *)aObject {
//
//   [self postSignal:aName from:self withObject:aObject];
//
//   return;
//}
//
//- (void)postSignal:(NSString *)aName from:(id)aSource {
//
//   [self postSignal:aName from:aSource withObject:nil];
//
//   return;
//}
//
//- (void)postSignal:(NSString *)aName from:(id)aSource withObject:(NSObject *)aObject {
//
//   dispatch_async_background_concurrent(^() {
//
//      IDEAEventKitSignal  *stSignal   = [IDEAEventKitSignal signal];
//
//      stSignal.source   = aSource ? aSource : self;
//      stSignal.target   = self;
//      stSignal.name     = aName;
//      stSignal.object   = aObject;
//
//      [stSignal send];
//
//   });
//
//   return;
//}

- (void)postSignal:(NSString *)aName onQueue:(dispatch_queue_t)aQueue {
   
   [self postSignal:aName from:self withObject:nil input:nil onQueue:aQueue];
   
   return;
}

- (void)postSignal:(NSString *)aName input:(NSDictionary *)aInput onQueue:(dispatch_queue_t)aQueue {
   
   [self postSignal:aName from:self withObject:nil input:aInput onQueue:aQueue];
   
   return;
}

- (void)postSignal:(NSString *)aName withObject:(NSObject *)aObject onQueue:(dispatch_queue_t)aQueue {
   
   [self postSignal:aName from:self withObject:aObject input:nil onQueue:aQueue];
   
   return;
}

- (void)postSignal:(NSString *)aName withObject:(NSObject *)aObject input:(NSDictionary *)aInput onQueue:(dispatch_queue_t)aQueue {
   
   [self postSignal:aName from:self withObject:aObject input:aInput onQueue:aQueue];
   
   return;
}

- (void)postSignal:(NSString *)aName from:(id)aSource onQueue:(dispatch_queue_t)aQueue {
   
   [self postSignal:aName from:aSource withObject:nil onQueue:aQueue];
   
   return;
}

- (void)postSignal:(NSString *)aName from:(id)aSource input:(NSDictionary *)aInput onQueue:(dispatch_queue_t)aQueue {
   
   [self postSignal:aName from:aSource withObject:nil input:aInput onQueue:aQueue];
   
   return;
}

- (void)postSignal:(NSString *)aName from:(id)aSource withObject:(NSObject *)aObject onQueue:(dispatch_queue_t)aQueue {
   
   [self postSignal:aName from:aSource withObject:nil input:nil onQueue:aQueue];
   
   return;
}

- (void)postSignal:(NSString *)aName from:(id)aSource withObject:(NSObject *)aObject input:(NSDictionary *)aInput onQueue:(dispatch_queue_t)aQueue {
   
   if (NULL == aQueue) {
      
      aQueue   = [IDEAEventKitQueue sharedInstance].concurrent;
      
   } /* End if () */
   
   dispatch_async(aQueue, ^{
      
      IDEAEventKitSignal  *stSignal   = [IDEAEventKitSignal signal];
      
      stSignal.source   = aSource ? aSource : self;
      stSignal.target   = self;
      stSignal.name     = aName;
      stSignal.object   = aObject;
      stSignal.input    = aInput ? [aInput mutableCopy] : nil;
      
      [stSignal send];
   });
   
   return;
}

@end

#pragma mark -

@implementation IDEAEventKitSignal

@def_joint(stateChanged);

//@def_prop_unsafe(id,                  foreign);
//@def_prop_strong(NSString *,            prefix);

@def_prop_unsafe  (id                   ,    source);
@def_prop_unsafe  (id                   ,    target);

@def_prop_copy    (BlockType            ,    stateChanged);
@def_prop_assign  (SignalState          ,    state);
@def_prop_dynamic (BOOL                 ,    sending);
@def_prop_dynamic (BOOL                 ,    arrived);
@def_prop_dynamic (BOOL                 ,    dead);

@def_prop_assign  (BOOL                 ,    hit);
@def_prop_assign  (NSUInteger           ,    hitCount);
@def_prop_dynamic (NSString            *,    prettyName);

@def_prop_strong  (NSString            *,    name);
@def_prop_strong  (id                   ,    object);
@def_prop_strong  (NSMutableDictionary *,    input);
@def_prop_strong  (NSMutableDictionary *,    output);

@def_prop_assign  (NSTimeInterval       ,    initTimeStamp);
@def_prop_assign  (NSTimeInterval       ,    sendTimeStamp);
@def_prop_assign  (NSTimeInterval       ,    arriveTimeStamp);

@def_prop_dynamic (NSTimeInterval       ,    timeElapsed);
@def_prop_dynamic (NSTimeInterval       ,    timeCostPending);
@def_prop_dynamic (NSTimeInterval       ,    timeCostExecution);

@def_prop_assign  (NSInteger            ,    jumpCount);
@def_prop_strong  (NSArray             *,    jumpPath);

BASE_CLASS  (IDEAEventKitSignal);

#pragma mark -

+ (IDEAEventKitSignal *)signal {
   
   return [[IDEAEventKitSignal alloc] init];
}

+ (IDEAEventKitSignal *)signal:(NSString *)aName {
   
   IDEAEventKitSignal  *stSignal   = [[IDEAEventKitSignal alloc] init];
   stSignal.name  = aName;
   
   return stSignal;
}

- (id)init {
   
   static NSUInteger __seed = 0;
   
   self = [super init];
   
   if (self) {
      
      _name    = [NSString stringWithFormat:@"signal-%lu", (unsigned long)__seed++];
      _state   = SignalState_Inited;
      
      _initTimeStamp    = [NSDate timeIntervalSinceReferenceDate];
      _sendTimeStamp    = _initTimeStamp;
      _arriveTimeStamp  = _initTimeStamp;
      
   } /* End if () */
   
   return self;
}

- (void)dealloc {
   
   self.jumpPath     = nil;
   self.stateChanged = nil;
   
   self.name         = nil;
   //   self.prefix = nil;
   self.object       = nil;
   
   self.input        = nil;
   self.output       = nil;
   
   __SUPER_DEALLOC;
   
   return;
}

- (void)deepCopyFrom:(IDEAEventKitSignal *)aRight {
   
   //   [super deepCopyFrom:right];
   
   //   self.foreign         = aRight.foreign;
   self.source          = aRight.source;
   self.target          = aRight.target;
   
   self.state           = aRight.state;
   
   self.name            = [aRight.name copy];
   //   self.prefix          = [aRight.prefix copy];
   self.object          = aRight.object;
   
   self.initTimeStamp   = aRight.initTimeStamp;
   self.sendTimeStamp   = aRight.sendTimeStamp;
   self.arriveTimeStamp = aRight.arriveTimeStamp;
   
   self.jumpCount = aRight.jumpCount;
   self.jumpPath  = [aRight.jumpPath mutableCopy];
   
   return;
}

- (NSString *)prettyName {
   
   //   NSString * name = [self.name stringByReplacingOccurrencesOfString:@"signal." withString:@""];
   //   NSString * normalizedName = name;
   //   normalizedName = [normalizedName stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
   //   normalizedName = [normalizedName stringByReplacingOccurrencesOfString:@":" withString:@"_"];
   //   return normalizedName;
   
   return self.name;
}

#if APPLET_DESCRIPTION
- (NSString *)description {
   
#if __IDEA_EVENT_KIT_DEBUG__
   return [NSString stringWithFormat:@"[%@] > %@", self.prettyName, [self.jumpPath join:@" > "]];
#else
   return self.name;
#endif
}
#endif /* APPLET_DESCRIPTION */

- (BOOL)is:(NSString *)aName {
   
   return [self.name isEqualToString:aName];
}

- (BOOL)isSentFrom:(id)source {
   
   return (self.source == source) ? YES : NO;
}

- (SignalState)state {
   
   return _state;
}

- (void)setState:(SignalState)aNewState {
   
   [self changeState:aNewState];
}

- (BOOL)sending {
   
   return SignalState_Sending == _state ? YES : NO;
}

- (void)setSending:(BOOL)aFlag {
   
   if (aFlag) {
      
      [self changeState:SignalState_Sending];
      
   } /* End if () */
   
   return;
}

- (BOOL)arrived {
   
   return SignalState_Arrived == _state ? YES : NO;
}

- (void)setArrived:(BOOL)aFlag {
   
   if (aFlag) {
      
      [self changeState:SignalState_Arrived];
      
   } /* End if () */
   
   return;
}

- (BOOL)dead {
   
   return SignalState_Dead == _state ? YES : NO;
}

- (void)setDead:(BOOL)aFlag {
   
   if (aFlag) {
      
      [self changeState:SignalState_Dead];
      
   } /* End if () */
   
   return;
}

- (BOOL)changeState:(SignalState)aNewState {
   
   //   static const char * __states[] = {
   //      "!Inited",
   //      "!Sending",
   //      "!Arrived",
   //      "!Dead"
   //   };
   
   if (aNewState == _state) {
      
      return NO;
      
   } /* End if () */
   
   triggerBefore(self, stateChanged);
   
   LogDebug((@"Signal '%@', state %d -> %d", self.prettyName, _state, aNewState));
   
   _state = aNewState;
   
   if (SignalState_Sending == _state) {
      
      _sendTimeStamp = [NSDate timeIntervalSinceReferenceDate];
      
   } /* End if () */
   else if (SignalState_Arrived == _state) {
      
      _arriveTimeStamp = [NSDate timeIntervalSinceReferenceDate];
      
   } /* End else if () */
   else if (SignalState_Dead == _state) {
      
      _arriveTimeStamp = [NSDate timeIntervalSinceReferenceDate];
      
   } /* End else if () */
   
   if (self.stateChanged) {
      
      ((BlockTypeVarg)self.stateChanged)(self);
      
   } /* End if () */
   
   triggerAfter(self, stateChanged);
   
   return YES;
}

- (BOOL)send {
   
   @autoreleasepool {
      return [[IDEAEventKitSignalBus sharedInstance] send:self];
   };
}


- (BOOL)forward {
   
   @autoreleasepool {
      return [[IDEAEventKitSignalBus sharedInstance] forward:self];
   };
}

- (BOOL)forward:(id)aTarget {
   
   @autoreleasepool {
      return [[IDEAEventKitSignalBus sharedInstance] forward:self to:aTarget];
   };
}

- (NSTimeInterval)timeElapsed {
   
   return _arriveTimeStamp - _initTimeStamp;
}

- (NSTimeInterval)timeCostPending {
   
   return _sendTimeStamp - _initTimeStamp;
}

- (NSTimeInterval)timeCostExecution {
   
   return _arriveTimeStamp - _sendTimeStamp;
}

- (void)log:(id)aTarget {
   
   if (self.arrived || self.dead) {
      
      return;
      
   } /* End if () */
   
#if __IDEA_EVENT_KIT_DEBUG__
   if (aTarget) {
      
      if (nil == self.jumpPath) {
         
         self.jumpPath = [[NSMutableArray alloc] init];
         
      } /* End if () */
      
      [self.jumpPath addObject:[aTarget signalDescription]];
      
   } /* End if () */
#endif /* __IDEA_EVENT_KIT_DEBUG__ */
   
   _jumpCount += 1;
   
   return;
}

#pragma mark -

- (NSMutableDictionary *)inputOrOutput {
   
   if (SignalState_Inited == _state) {
      
      if (nil == self.input) {
         
         self.input = [NSMutableDictionary dictionary];
         
      } /* End if () */
      
      return self.input;
      
   } /* End if () */
   else {
      
      if (nil == self.output) {
         
         self.output = [NSMutableDictionary dictionary];
         
      } /* End if () */
      
      return self.output;
      
   } /* End else () */
}

- (id)objectForKey:(id)aKey {
   
   NSMutableDictionary  *stObjects  = [self inputOrOutput];
   
   return [stObjects objectForKey:aKey];
}

- (BOOL)hasObjectForKey:(id)aKey {
   
   NSMutableDictionary  *stObjects  = [self inputOrOutput];
   
   return [stObjects objectForKey:aKey] ? YES : NO;
}

- (void)setObject:(id)value forKey:(id)aKey {
   
   NSMutableDictionary  *stObjects  = [self inputOrOutput];
   [stObjects setObject:value forKey:aKey];
   
   return;
}

- (void)removeObjectForKey:(id)aKey {
   
   NSMutableDictionary  *stObjects  = [self inputOrOutput];
   [stObjects removeObjectForKey:aKey];
   
   return;
}

- (void)removeAllObjects {
   
   NSMutableDictionary  *stObjects  = [self inputOrOutput];
   [stObjects removeAllObjects];
   
   return;
}

- (id)objectForKeyedSubscript:(id)aKey; {
   
   return [self objectForKey:aKey];
}

- (void)setObject:(id)obj forKeyedSubscript:(id)aKey {
   
   [self setObject:obj forKey:aKey];
   
   return;
}

@end

// ----------------------------------
// Unit test
// ----------------------------------

#pragma mark -

#if __IDEA_EVENT_KIT_TESTING__

#endif // #if __IDEA_EVENT_KIT_TESTING__

#import "IDEAEventKit/__pragma_pop.h"
