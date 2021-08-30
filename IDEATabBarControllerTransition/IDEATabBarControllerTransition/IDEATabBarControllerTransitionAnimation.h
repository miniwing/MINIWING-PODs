//
//  IDEATabBarControllerTransitionAnimation.h
//  IDEATabBarControllerTransition
//
//  Created by Harry on 2021/4/8.
//

#import <Foundation/Foundation.h>

#import "IDEATabBarControllerTransition.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IDEATabBarControllerTransitionViewType) {
   IDEATabBarControllerTransitionViewTypeTo     = 0,
   IDEATabBarControllerTransitionViewTypeFrom   = 1
};

@interface IDEATabBarControllerTransitionAnimation : NSObject

+ (CAAnimation *)fadeWithType:(IDEATabBarControllerTransitionViewType)aType;
+ (CAAnimation *)fadeWithType:(IDEATabBarControllerTransitionViewType)aType min:(CGFloat)aMIN;
+ (CAAnimation *)fadeWithType:(IDEATabBarControllerTransitionViewType)aType min:(CGFloat)aMIN max:(CGFloat)aMAX;

+ (CAAnimation *)scaleWithType:(IDEATabBarControllerTransitionViewType)aType;
+ (CAAnimation *)scaleWithType:(IDEATabBarControllerTransitionViewType)aType min:(CGFloat)aMIN;
+ (CAAnimation *)scaleWithType:(IDEATabBarControllerTransitionViewType)aType min:(CGFloat)aMIN max:(CGFloat)aMAX;

+ (CAAnimation *)moveWithType:(IDEATabBarControllerTransitionViewType)aType direction:(IDEATabBarControllerTransitionDirection)aDirection;
+ (CAAnimation *)moveWithType:(IDEATabBarControllerTransitionViewType)aType direction:(IDEATabBarControllerTransitionDirection)aDirection bounceValue:(CGFloat)aBounceValue;

@end

NS_ASSUME_NONNULL_END
