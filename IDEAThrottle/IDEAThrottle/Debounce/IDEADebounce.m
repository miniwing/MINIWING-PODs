//
//  IDEADebounce.m
//  IDEAThrottle
//
//  Created by highwayLiu on 2021/2/23.
//

#import "IDEADebounce.h"

#pragma mark - IDEADebounce

@implementation IDEADebounce

#pragma mark - life cycle

- (instancetype)initWithInterval:(NSTimeInterval)interval
                       taskBlock:(IDEADebounceTaskBlock)taskBlock {
   return [self initWithInterval:interval
                         onQueue:dispatch_get_main_queue()
                       taskBlock:taskBlock];
}

- (instancetype)initWithInterval:(NSTimeInterval)interval
                         onQueue:(dispatch_queue_t)queue
                       taskBlock:(IDEADebounceTaskBlock)taskBlock {
   return [self initWithDebounceMode:IDEADebounceModeTrailing
                            interval:interval
                             onQueue:queue
                           taskBlock:taskBlock];
}

- (instancetype)initWithDebounceMode:(IDEADebounceMode)debounceMode
                            interval:(NSTimeInterval)interval
                             onQueue:(dispatch_queue_t)queue
                           taskBlock:(IDEADebounceTaskBlock)taskBlock {
   if (interval < 0) {
      interval = 0.1;
   }
   if (!queue) {
      queue = dispatch_get_main_queue();
   }
   
   switch (debounceMode) {
      case IDEADebounceModeTrailing:
         self = [[IDEADebounceTrailing alloc] initWithInterval:interval
                                                       onQueue:queue
                                                     taskBlock:taskBlock];
         break;
         
      case IDEADebounceModeLeading:
         self = [[IDEADebounceLeading alloc] initWithInterval:interval
                                                      onQueue:queue
                                                    taskBlock:taskBlock];
         break;
   }
   return self;
}

#pragma mark - public methods

- (void)call {
   NSAssert(1, @"This method should be overrided!");
}

- (void)invalidate {
   NSAssert(1, @"This method should be overrided!");
}

@end

#pragma mark - IDEADebounceTrailing

@interface IDEADebounceTrailing ()

@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, copy) IDEADebounceTaskBlock taskBlock;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) dispatch_block_t block;

@end

@implementation IDEADebounceTrailing

- (instancetype)initWithInterval:(NSTimeInterval)interval
                         onQueue:(dispatch_queue_t)queue
                       taskBlock:(IDEADebounceTaskBlock)taskBlock {
   self = [super init];
   if (self) {
      _interval = interval;
      _taskBlock = taskBlock;
      _queue = queue;
   }
   return self;
}

- (void)call {
   if (self.block) {
      dispatch_block_cancel(self.block);
   }
   __weak typeof(self)weakSelf = self;
   self.block = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, ^{
      if (weakSelf.taskBlock) {
         weakSelf.taskBlock();
      }
   });
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.interval * NSEC_PER_SEC)), self.queue, self.block);
}

- (void)invalidate {
   self.taskBlock = nil;
   self.block = nil;
}

@end

#pragma mark - IDEADebounceLeading

@interface IDEADebounceLeading ()

@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, copy) IDEADebounceTaskBlock taskBlock;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) dispatch_block_t block;
@property (nonatomic, strong) NSDate *lastCallTaskDate;

@end

@implementation IDEADebounceLeading

- (instancetype)initWithInterval:(NSTimeInterval)interval
                         onQueue:(dispatch_queue_t)queue
                       taskBlock:(IDEADebounceTaskBlock)taskBlock {
   self = [super init];
   if (self) {
      _interval = interval;
      _taskBlock = taskBlock;
      _queue = queue;
   }
   return self;
}

- (void)call {
   if (self.lastCallTaskDate) {
      if ([[NSDate date] timeIntervalSinceDate:self.lastCallTaskDate] > self.interval) {
         [self runTaskDirectly];
      }
   } else {
      [self runTaskDirectly];
   }
   self.lastCallTaskDate = [NSDate date];
}

- (void)invalidate {
   self.taskBlock = nil;
   self.block = nil;
}

- (void)runTaskDirectly {
   dispatch_async(self.queue, ^{
      if (self.taskBlock) {
         self.taskBlock();
      }
   });
}

@end

