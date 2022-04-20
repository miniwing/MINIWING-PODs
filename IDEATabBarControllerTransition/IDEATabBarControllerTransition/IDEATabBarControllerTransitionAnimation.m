//
//  IDEATabBarControllerTransitionAnimation.m
//  IDEATabBarControllerTransition
//
//  Created by Harry on 2021/4/8.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEATabBarControllerTransitionAnimation.h"
#import "IDEATabBarControllerAnimationFactory.h"
#import "IDEATabBarControllerTransition.h"

@interface IDEATabBarControllerTransitionAnimation ()

@end

@implementation IDEATabBarControllerTransitionAnimation

+ (CAAnimation *)fadeWithType:(IDEATabBarControllerTransitionViewType)aType {
   
   return [IDEATabBarControllerTransitionAnimation fadeWithType:aType min:0];
}

+ (CAAnimation *)fadeWithType:(IDEATabBarControllerTransitionViewType)aType min:(CGFloat)aMIN {
   
   return [IDEATabBarControllerTransitionAnimation fadeWithType:aType min:aMIN max:1];
}

+ (CAAnimation *)fadeWithType:(IDEATabBarControllerTransitionViewType)aType min:(CGFloat)aMIN max:(CGFloat)aMAX {
   
   CGFloat   fFromOpacity  = (aType == IDEATabBarControllerTransitionViewTypeFrom) ? aMAX : aMIN;
   CGFloat   fToOpacity    = (aType == IDEATabBarControllerTransitionViewTypeTo)   ? aMAX : aMIN;
   
   return [IDEATabBarControllerAnimationFactory makeAnimationWithType:AnimationTypeOpacity from:fFromOpacity to:fToOpacity];
}

+ (CAAnimation *)scaleWithType:(IDEATabBarControllerTransitionViewType)aType {
   
   return [IDEATabBarControllerTransitionAnimation scaleWithType:aType min:0];
}

+ (CAAnimation *)scaleWithType:(IDEATabBarControllerTransitionViewType)aType min:(CGFloat)aMIN {
   
   return [IDEATabBarControllerTransitionAnimation scaleWithType:aType min:aMIN max:1];
}

+ (CAAnimation *)scaleWithType:(IDEATabBarControllerTransitionViewType)aType min:(CGFloat)aMIN max:(CGFloat)aMAX {
   
   CGFloat      fFromValue          = (aType == IDEATabBarControllerTransitionViewTypeFrom) ? aMAX : aMIN;
   CGFloat      fToValue            = (aType == IDEATabBarControllerTransitionViewTypeTo)   ? aMAX : aMIN;

   CAAnimation *stOpacityAnimation  = [IDEATabBarControllerTransitionAnimation fadeWithType:aType];
   CAAnimation *stScaleAnimation    = [IDEATabBarControllerAnimationFactory makeAnimationWithType:AnimationTypeScale from:fFromValue to: fToValue];
   
   return [IDEATabBarControllerAnimationFactory makeGroupAnimation:@[ stOpacityAnimation, stScaleAnimation ]];
}

+ (CAAnimation *)moveWithType:(IDEATabBarControllerTransitionViewType)aType direction:(IDEATabBarControllerTransitionDirection)aDirection {
   
   return [IDEATabBarControllerTransitionAnimation moveWithType:aType direction:aDirection bounceValue:TRANSITION_ANIMATION_BOUNCE];
}

+ (CAAnimation *)moveWithType:(IDEATabBarControllerTransitionViewType)aType direction:(IDEATabBarControllerTransitionDirection)aDirection bounceValue:(CGFloat)aBounceValue {
         
   CGFloat      fFromX  = (aDirection == DirectionRight) ? aBounceValue : -aBounceValue;
   CGFloat      fToX    = (aDirection == DirectionLeft)  ? aBounceValue : -aBounceValue;
   
   CAAnimation *stOpacityAnimation        = [IDEATabBarControllerTransitionAnimation fadeWithType:aType];
   CAAnimation *stTranslatationAnimation  = (aType == IDEATabBarControllerTransitionViewTypeFrom)
   ? [IDEATabBarControllerAnimationFactory makeAnimationWithType:AnimationTypeTranslation from:0 to:fToX]
   : [IDEATabBarControllerAnimationFactory makeAnimationWithType:AnimationTypeTranslation from:fFromX to: 0];
      
   return [IDEATabBarControllerAnimationFactory makeGroupAnimation:@[ stOpacityAnimation, stTranslatationAnimation ]];
}

@end
