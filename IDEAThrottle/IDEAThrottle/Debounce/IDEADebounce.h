//
//  IDEADebounce.h
//  IDEAThrottle
//
//  Created by highwayLiu on 2021/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - public class

typedef NS_ENUM(NSUInteger, IDEADebounceMode) {
   IDEADebounceModeTrailing,        //invoking on the trailing edge of the timeout
   IDEADebounceModeLeading,         //invoking on the leading edge of the timeout
};

typedef void(^IDEADebounceTaskBlock)(void);

@interface IDEADebounce : NSObject

/// Initialize a debounce object, the debounce mode is the default IDEADebounceModeTrailing, the execution queue defaults to the main queue. Note that debounce is for the same IDEADebounce object, and different IDEADebounce objects do not interfere with each other
/// @param interval debounce time interval, unit second
/// @param taskBlock the task to be debounced
- (instancetype)initWithInterval:(NSTimeInterval)interval
                       taskBlock:(IDEADebounceTaskBlock)taskBlock;

/// Initialize a debounce object, the debounce mode is the default IDEADebounceModeTrailing. Note that debounce is for the same IDEADebounce object, and different IDEADebounce objects do not interfere with each other
/// @param interval debounce time interval, unit second
/// @param queue execution queue, defaults the main queue
/// @param taskBlock the task to be debounced
- (instancetype)initWithInterval:(NSTimeInterval)interval
                         onQueue:(dispatch_queue_t)queue
                       taskBlock:(IDEADebounceTaskBlock)taskBlock;

/// Initialize a debounce object. Note that debounce is for the same IDEADebounce object, and different IDEADebounce objects do not interfere with each other
/// @param debounceMode the debounce mode, defaults IDEADebounceModeTrailing
/// @param interval debounce time interval, unit second
/// @param queue execution queue, defaults the main queue
/// @param taskBlock the task to be debounced
- (instancetype)initWithDebounceMode:(IDEADebounceMode)debounceMode
                            interval:(NSTimeInterval)interval
                             onQueue:(dispatch_queue_t)queue
                           taskBlock:(IDEADebounceTaskBlock)taskBlock;


/// debouncing call the task
- (void)call;


/// When the owner of the IDEADebounce object is about to release, call this method on the IDEADebounce object first to prevent circular references
- (void)invalidate;

@end

#pragma mark - private classes

@interface IDEADebounceTrailing : IDEADebounce

@end

@interface IDEADebounceLeading : IDEADebounce

@end

NS_ASSUME_NONNULL_END
