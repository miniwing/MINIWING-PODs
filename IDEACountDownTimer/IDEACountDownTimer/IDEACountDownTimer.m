//
//  IDEACountDownTimer.m
//  IDEACountDownTimer
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "IDEACountDownTimer/IDEACountDownTimer.h"

#undef  __DebugFunc__
#define __DebugFunc__                              (__OFF__)

#undef  __DebugDebug__
#define __DebugDebug__                             (__OFF__)

#undef  __DebugWarn__
#define __DebugWarn__                              (__OFF__)

#undef  __DebugError__
#define __DebugError__                             (__OFF__)

#undef  __DebugColor__
#define __DebugColor__                             (__OFF__)

#undef  __DebugView__
#define __DebugView__                              (__OFF__)

@interface IDEACountDownTimer()

@property (nonatomic, assign)                NSInteger                             secondInFuture;
@property (nonatomic, assign)                NSInteger                             secondInterval;

@property (nonatomic, assign)                BOOL                                  cancelled;

@property (nonatomic, strong)                NSTimer                             * timer;

@property (nonatomic, copy  )                void                                  (^onTick)(NSInteger aSecondUntilFinished);
@property (nonatomic, copy  )                void                                  (^onFinish)(void);

@end

@implementation IDEACountDownTimer

+ (instancetype)countDownTimerWithFuture:(NSInteger)aSecondInFuture
                               countDown:(NSInteger)aSecondInterval
                                    tick:(void (^)(NSInteger aSecondUntilFinished))onTick
                                  finish:(void (^)(void))onFinish {
   
   return [[IDEACountDownTimer alloc] initWithFuture:aSecondInFuture
                                           countDown:aSecondInterval
                                                tick:onTick
                                              finish:onFinish];
}

- (instancetype)initWithFuture:(NSInteger)aSecondInFuture
                     countDown:(NSInteger)aSecondInterval
                          tick:(void (^)(NSInteger aSecondUntilFinished))onTick
                        finish:(void (^)(void))onFinish {
   
   self  = [super init];
   
   if (self) {
      
      self.secondInFuture  = aSecondInFuture;
      self.secondInterval  = aSecondInterval;
      
      self.timer           = [NSTimer timerWithTimeInterval:aSecondInterval
                                                    repeats:YES
                                                       block:^(NSTimer * _Nonnull aTimer) {
         [self tick:aTimer];
      }];
      
      [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

      self.onTick    = onTick;
      self.onFinish  = onFinish;
      
   } /* End if () */
   
   return self;
}

- (void)start {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self.cancelled    = NO;
   
   if (0 >= self.secondInFuture) {
      
      [self finish];
      
      nErr  = noErr;
      
      break;

   } /* End if () */
   
   if (nil != _timer) {
      
      [_timer fire];
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return;
}

- (void)tick:(NSTimer *)aTimer {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   if (self.cancelled) {
      
      return;
      
   } /* End if () */
   
   self.secondInFuture  -= self.secondInterval;

   if (0 >= self.secondInFuture) {
      
      [self finish];
      
   } /* End if () */
   else {
      
      if (self.onTick) {
         
         self.onTick(self.secondInFuture);
         
      } /* End if () */
      
   } /* End else */

   __CATCH(nErr);
   
   return;
}

- (void)finish {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self.cancelled = YES;
   
   if (nil != _timer) {
      
      [_timer invalidate];
      __RELEASE(_timer);
      
   } /* End if () */
   
   if (self.onFinish) {
      
      self.onFinish();
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return;
}
- (void)cancel {

   int                            nErr                                     = EFAULT;
   
   __TRY;

   self.cancelled = YES;
   
   if (nil != _timer) {
      
      [_timer invalidate];
      __RELEASE(_timer);
      
   } /* End if () */

   __CATCH(nErr);

   return;
}

@end
