//
//  IDEATabBarControllerAnimationFactory.h
//  IDEATabBarControllerTransition
//
//  Created by Harry on 2021/4/8.
//

#import <Foundation/Foundation.h>

#import <IDEATabBarControllerTransition/IDEATabBarControllerTransition.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEATabBarControllerAnimationFactory : NSObject

+ (CAAnimation *)makeAnimationWithType:(IDEATabBarControllerTransitionAnimationType)aType from:(CGFloat)aFrom to:(CGFloat)aTo;
+ (CAAnimationGroup *)makeGroupAnimation:(NSArray<CAAnimation *> *)aAnimations;

@end

@interface IDEATabBarControllerAnimationFactory ()

/**
 *  Unavailable initializer
 */
+ (instancetype)new NS_UNAVAILABLE;

/**
 *  Unavailable initializer
 */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
