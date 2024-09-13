//
//  IDEAThrottle.h
//  IDEAThrottle
//
//  Created by highwayLiu on 2021/2/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - public class

typedef NS_ENUM(NSUInteger, IDEAThrottleMode) {
   IDEAThrottleModeLeading,          //invoking on the leading edge of the timeout
   IDEAThrottleModeTrailing,         //invoking on the trailing edge of the timeout
};

typedef void(^IDEAThrottleTaskBlock)(void);

@interface IDEAThrottle : NSObject

/// Initialize a throttle object, the throttle mode is the default IDEAThrottleModeLeading, the execution queue defaults to the main queue. Note that throttle is for the same IDEAThrottle object, and different IDEAThrottle objects do not interfere with each other
/// @param interval throttle time interval, unit second
/// @param taskBlock the task to be throttled
- (instancetype)initWithInterval:(NSTimeInterval)interval
                       taskBlock:(IDEAThrottleTaskBlock)taskBlock;

/// Initialize a throttle object, the throttle mode is the default IDEAThrottleModeLeading. Note that throttle is for the same IDEAThrottle object, and different IDEAThrottle objects do not interfere with each other
/// @param interval throttle time interval, unit second
/// @param queue execution queue, defaults the main queue
/// @param taskBlock the task to be throttled
- (instancetype)initWithInterval:(NSTimeInterval)interval
                         onQueue:(dispatch_queue_t)queue
                       taskBlock:(IDEAThrottleTaskBlock)taskBlock;

/// Initialize a debounce object. Note that debounce is for the same IDEAThrottle object, and different IDEAThrottle objects do not interfere with each other
/// @param throttleMode the throttle mode, defaults IDEAThrottleModeLeading
/// @param interval throttle time interval, unit second
/// @param queue execution queue, defaults the main queue
/// @param taskBlock the task to be throttled
- (instancetype)initWithThrottleMode:(IDEAThrottleMode)throttleMode
                            interval:(NSTimeInterval)interval
                             onQueue:(dispatch_queue_t)queue
                           taskBlock:(IDEAThrottleTaskBlock)taskBlock;


/// throttling call the task
- (void)call;


/// When the owner of the IDEAThrottle object is about to release, call this method on the IDEAThrottle object first to prevent circular references
- (void)invalidate;

@end

#pragma mark - private classes

@interface IDEAThrottleLeading : IDEAThrottle

@end

@interface IDEAThrottleTrailing : IDEAThrottle

@end

NS_ASSUME_NONNULL_END
