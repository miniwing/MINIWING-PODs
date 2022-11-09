//
//  IDEATabBarControllerTransition.h
//  IDEATabBarControllerTransition
//
//  Created by Harry on 2021/4/8.
//

#import <Foundation/Foundation.h>

#import <IDEATabBarControllerTransition/CAMediaTimingFunction+TabBarControllerTransition.h>
#import <IDEATabBarControllerTransition/IDEATabBarControllerLayerContext.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TransType) {
   
   TransTypeNone  = -1,
   TransTypeMove  = 0,
   TransTypeFade  = 1,
   TransTypeScale = 2,
   TransTypeCustom= 3
};

typedef NS_ENUM(NSInteger, IDEATabBarControllerTransitionDirection) {
   DirectionLeft  = 0,
   DirectionRight = 1
};

typedef NS_ENUM(NSInteger, IDEATabBarControllerTransitionAnimationType) {
   AnimationTypeOpacity       = 0,
   AnimationTypeScale         = 1,
   AnimationTypeTranslation   = 2
};

typedef NSString * IDEATabBarControllerTransitionAnimationKeys NS_TYPED_ENUM;

UIKIT_EXTERN IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyBackground;
UIKIT_EXTERN IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyView;
UIKIT_EXTERN IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyToView;
UIKIT_EXTERN IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyFromView;
UIKIT_EXTERN IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyToNavigationBar;
UIKIT_EXTERN IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyFromNavigationBar;

@protocol IDEATabBarControllerTransitionControllerDelegate <NSObject>

@required
- (__kindof UIView *)navigationBarOrHeadView;

@end

UIKIT_EXTERN NSNotificationName  const IDEATabBarControllerTransitionBeginNotification;
UIKIT_EXTERN NSNotificationName  const IDEATabBarControllerTransitionEndNotification;

@interface IDEATabBarControllerTransition : UITabBarController <UITabBarControllerDelegate>

-(TransType)transType;
- (CAMediaTimingFunction *)transitionTimingFunction;
- (CFTimeInterval)transitionDuration;

- (CAAnimation *) fromTransitionAnimation:(CALayer *)layer direction:(IDEATabBarControllerTransitionDirection)aDirection;
- (CAAnimation *) toTransitionAnimation:(CALayer *)layer direction:(IDEATabBarControllerTransitionDirection)aDirection;

- (BOOL)animateTransition:(UITabBarController *)tabBarController shouldSelect:(UIViewController *)viewController;

@end

@interface IDEATabBarControllerTransition (IDEATabBarControllerTransitionDirection)

+ (IDEATabBarControllerTransitionDirection)direction:(NSInteger)selectedIndex shouldSelectIndex:(NSInteger)shouldSelectIndex;

@end

NS_ASSUME_NONNULL_END
