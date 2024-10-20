//
//  IDEAThrottle.m
//  IDEAThrottle
//
//  Created by highwayLiu on 2021/2/9.
//

#import "IDEAThrottle.h"


#pragma mark - IDEAThrottle

@implementation IDEAThrottle

#pragma mark - life cycle

- (instancetype)initWithInterval:(NSTimeInterval)interval
                       taskBlock:(IDEAThrottleTaskBlock)taskBlock {
   return [self initWithInterval:interval
                         onQueue:dispatch_get_main_queue()
                       taskBlock:taskBlock];
}

- (instancetype)initWithInterval:(NSTimeInterval)interval
                         onQueue:(dispatch_queue_t)queue
                       taskBlock:(IDEAThrottleTaskBlock)taskBlock {
   return [self initWithThrottleMode:IDEAThrottleModeLeading
                            interval:interval
                             onQueue:queue
                           taskBlock:taskBlock];
}

- (instancetype)initWithThrottleMode:(IDEAThrottleMode)throttleMode
                            interval:(NSTimeInterval)interval
                             onQueue:(dispatch_queue_t)queue
                           taskBlock:(IDEAThrottleTaskBlock)taskBlock {
   if (interval < 0) {
      interval = 0.1;
   }
   if (!queue) {
      queue = dispatch_get_main_queue();
   }
   
   switch (throttleMode) {
      case IDEAThrottleModeLeading: {
         self = [[IDEAThrottleLeading alloc] initWithInterval:interval
                                                      onQueue:queue
                                                    taskBlock:taskBlock];
         break;
      }
      case IDEAThrottleModeTrailing: {
         self = [[IDEAThrottleTrailing alloc] initWithInterval:interval
                                                       onQueue:queue
                                                     taskBlock:taskBlock];
         break;
      }
   }
   return self;
}

#pragma mark - public methods

- (void)call:(id)aSender {
   NSAssert(1, @"This method should be overrided!");
}

- (void)invalidate {
   NSAssert(1, @"This method should be overrided!");
}

@end

#pragma mark - IDEAThrottleLeading

@interface IDEAThrottleLeading()

@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, copy) IDEAThrottleTaskBlock taskBlock;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) NSDate *lastRunTaskDate;

@end

@implementation IDEAThrottleLeading

- (instancetype)initWithInterval:(NSTimeInterval)interval
                         onQueue:(dispatch_queue_t)queue
                       taskBlock:(IDEAThrottleTaskBlock)taskBlock {
   self = [super init];
   if (self) {
      _interval = interval;
      _taskBlock = taskBlock;
      _queue = queue;
   }
   return self;
}

- (void)call:(id)aSender {
   if (self.lastRunTaskDate) {
      if ([[NSDate date] timeIntervalSinceDate:self.lastRunTaskDate] > self.interval) {
         [self runTaskDirectly:aSender];
      }
   } else {
      [self runTaskDirectly:aSender];
   }
}

- (void)runTaskDirectly:(id)aSender {
   dispatch_async(self.queue, ^{
      if (self.taskBlock) {
         self.taskBlock(aSender);
      }
      self.lastRunTaskDate = [NSDate date];
   });
}

- (void)invalidate {
   self.taskBlock = nil;
}

@end

#pragma mark - IDEAThrottleTrailing

@interface IDEAThrottleTrailing()

@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, copy) IDEAThrottleTaskBlock taskBlock;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) NSDate *lastRunTaskDate;
@property (nonatomic, strong) NSDate *nextRunTaskDate;

@end

@implementation IDEAThrottleTrailing

- (instancetype)initWithInterval:(NSTimeInterval)interval
                         onQueue:(dispatch_queue_t)queue
                       taskBlock:(IDEAThrottleTaskBlock)taskBlock {
   self = [super init];
   if (self) {
      _interval = interval;
      _taskBlock = taskBlock;
      _queue = queue;
   }
   return self;
}

- (void)call:(id)aSender {
   
   NSDate *now = [NSDate date];
   
   if (!self.nextRunTaskDate) {
      
      if (self.lastRunTaskDate) {
         
         if ([now timeIntervalSinceDate:self.lastRunTaskDate] > self.interval) {
            
            self.nextRunTaskDate = [NSDate dateWithTimeInterval:self.interval sinceDate:now];
         }
         else {
            self.nextRunTaskDate = [NSDate dateWithTimeInterval:self.interval sinceDate:self.lastRunTaskDate];
         }
      }
      else {
         self.nextRunTaskDate = [NSDate dateWithTimeInterval:self.interval sinceDate:now];
      }
      
      
      NSTimeInterval nextInterval = [self.nextRunTaskDate timeIntervalSinceDate:now];
      
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(nextInterval * NSEC_PER_SEC)), self.queue, ^{
         
         if (self.taskBlock) {
            
            self.taskBlock(aSender);
         }
         self.lastRunTaskDate = [NSDate date];
         self.nextRunTaskDate = nil;
      });
   }
}

- (void)invalidate {
   self.taskBlock = nil;
}

@end
