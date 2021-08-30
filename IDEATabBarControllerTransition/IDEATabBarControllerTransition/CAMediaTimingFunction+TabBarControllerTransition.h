//
//  CAMediaTimingFunction+TabBarControllerTransition.h
//  IDEATabBarControllerTransition
//
//  Created by Harry on 2021/4/8.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAMediaTimingFunction (TabBarControllerTransition)

+ (instancetype)linear;

+ (instancetype)easeIn;

+ (instancetype)easeOut;

+ (instancetype)easeInOut;

@end

NS_ASSUME_NONNULL_END
