//
//  IDEATabBarControllerAnimationFactory.m
//  IDEATabBarControllerTransition
//
//  Created by Harry on 2021/4/8.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEATabBarControllerAnimationFactory.h"

@interface IDEATabBarControllerAnimationFactory ()

@end

@implementation IDEATabBarControllerAnimationFactory

+ (CAAnimation *)makeAnimationWithType:(IDEATabBarControllerTransitionAnimationType)aType from:(CGFloat)aFrom to:(CGFloat)aTo {
   
   NSString          *szKeyPath        = nil;
   
   if (AnimationTypeOpacity == aType) {
      
      szKeyPath   = @"opacity";
      
   } /* End if () */
   else if (AnimationTypeScale == aType) {
      
      szKeyPath   = @"transform.scale";
      
   } /* End else if () */
   else if (AnimationTypeTranslation == aType) {
      
      szKeyPath   = @"transform.translation.x";
      
   } /* End else if () */
   
   CABasicAnimation  *stBasicAnimation = [CABasicAnimation animationWithKeyPath:szKeyPath];
   
   stBasicAnimation.fromValue = @(aFrom);
   stBasicAnimation.toValue   = @(aTo);
   
   return stBasicAnimation;
}

+ (CAAnimationGroup *)makeGroupAnimation:(NSArray<CAAnimation *> *)aAnimations {
   
   CAAnimationGroup  *stAnimationGroup  = [CAAnimationGroup animation];
   
   stAnimationGroup.animations   = aAnimations;
   
   return stAnimationGroup;
}

@end
