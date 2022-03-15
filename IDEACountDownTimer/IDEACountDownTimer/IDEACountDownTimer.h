//
//  IDEACountDownTimer.h
//  IDEACountDownTimer
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEACountDownTimer : NSObject

@end

@interface IDEACountDownTimer ()

+ (instancetype) countDownTimerWithFuture:(NSInteger)aSecondInFuture
                                countDown:(NSInteger)aSecondInterval
                                     tick:(void (^)(NSInteger aSecondUntilFinished))aTick
                                   finish:(void (^)(void))aFinish;

/**
 *  Unavailable initializer
 */
+ (instancetype)new NS_UNAVAILABLE;

/**
 *  Unavailable initializer
 */
- (instancetype)init NS_UNAVAILABLE;

- (void)start;
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
