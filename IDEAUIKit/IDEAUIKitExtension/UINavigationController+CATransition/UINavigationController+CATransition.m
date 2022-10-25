//
//  UINavigationController+CATransition.m
//  UINavigationController+CATransition
//
//  Created by Peak on 17/3/24.
//  Copyright © 2017年 Peak. All rights reserved.
//

#import <objc/runtime.h>



#import "UINavigationController+CATransition.h"

//#define kTransitionDuration 0.8

//#define kTransitionDuration               0.25 /* UIAViewAnimationDefaultDuraton */

#define kTransitionDuration               [UIView animationDefaultDuraton]

NSString *getCATransitionTypeStringWithCATransitionType(UICATransitionType type) {
   switch (type) {
      case UICATransitionTypeFade:
         return kCATransitionFade;  // 淡化
         break;
      case UICATransitionTypeMoveIn:
         return kCATransitionMoveIn;  // 覆盖
         break;
      case UICATransitionTypePush:
         return kCATransitionPush;  // push
         break;
      case UICATransitionTypeReveal:
         return kCATransitionReveal;   // 揭开
         break;
      case UICATransitionTypeCube:
         return @"cube";         // 3D立方
         break;
      case UICATransitionTypeSuckEffect:
         return @"suckEffect";  // 吮吸
         break;
      case UICATransitionTypeOglFlip:
         return @"oglFlip";  // 翻转
         break;
      case UICATransitionTypeRippleEffect:
         return @"rippleEffect";   // 波纹
         break;
      case UICATransitionTypePageCurl:
         return @"pageCurl";  // 翻页
         break;
      case UICATransitionTypePageUnCurl:
         return @"pageUnCurl";  // 反翻页
         break;
      case UICATransitionTypeCameraIrisHollowOpen:
         return @"cameraIrisHollowOpen";  // 开镜头
         break;
      case UICATransitionTypeCameraIrisHollowClose:
         return @"cameraIrisHollowClose";   // 关镜头
         break;
      default:
         return @"";
         break;
   }
}




NSString *getCATransitionSubType(UICATransitionSubType subType) {
   switch (subType) {
      case UICATransitionSubTypeFromRight:
         return kCATransitionFromRight;
         break;
      case UICATransitionSubTypeFromLeft:
         return kCATransitionFromLeft;
         break;
      case UICATransitionSubTypeFromTop:
         return kCATransitionFromTop;
         break;
      case UICATransitionSubTypeFromBottom:
         return kCATransitionFromBottom;
         break;
         
      default:
         return @"";
         break;
   }
}

@implementation UINavigationController (CATransition)


- (void)pushViewController:(UIViewController *)viewController withCATransitionTypeString:(NSString *)typeString subTypeString:(NSString *)subTypeString animated:(BOOL)animated
{
   CATransition *transition = [CATransition animation];
   transition.duration = kTransitionDuration;
   transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
   transition.type = typeString;
   transition.subtype = subTypeString;
   
   [self.view.layer addAnimation:transition forKey:@"animation"];
   
   [self pushViewController:viewController animated:animated];
   
}

- (void)popViewControllerWithCATransitionTypeString:(NSString *)typeString subTypeString:(NSString *)subTypeString animated:(BOOL)animated
{
   CATransition *transition = [CATransition animation];
   transition.duration = kTransitionDuration;
   transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
   transition.type = typeString;
   transition.subtype = subTypeString;
   
   [self.view.layer addAnimation:transition forKey:@"animation"];
   
   
   [self popViewControllerAnimated:animated];
}


- (void)pushViewController:(UIViewController *)viewController withCATransitionType:(UICATransitionType)type subType:(UICATransitionSubType)subType animated:(BOOL)animated
{
   NSString *typeString = getCATransitionTypeStringWithCATransitionType(type);
   NSString *subTypeString = getCATransitionSubType(subType);
   
   [self pushViewController:viewController withCATransitionTypeString:typeString subTypeString:subTypeString animated:animated];
}


- (void)popViewControllerWithCATransitionType:(UICATransitionType)type subType:(UICATransitionSubType)subType animated:(BOOL)animated
{
   NSString *typeString = getCATransitionTypeStringWithCATransitionType(type);
   NSString *subTypeString = getCATransitionSubType(subType);
   
   [self popViewControllerWithCATransitionTypeString:typeString subTypeString:subTypeString animated:animated];
}

@end

