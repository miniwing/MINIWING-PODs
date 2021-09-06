//
//  UINavigationController+CATransition.h
//  UINavigationController+CATransition
//
//  Created by Peak on 17/3/24.
//  Copyright © 2017年 Peak. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, UICATransitionType) {
   UICATransitionTypeFade = 1,      // 淡化
   UICATransitionTypeMoveIn,        // 覆盖
   UICATransitionTypePush,          // push
   UICATransitionTypeReveal,         // 揭开
   
   UICATransitionTypeCube,         // 3D立方
   UICATransitionTypeSuckEffect,   // 吮吸
   UICATransitionTypeOglFlip,      // 翻转
   UICATransitionTypeRippleEffect,  // 波纹
   
   UICATransitionTypePageCurl,      // 翻页
   UICATransitionTypePageUnCurl,        // 反翻页
   UICATransitionTypeCameraIrisHollowOpen,      // 开镜头
   UICATransitionTypeCameraIrisHollowClose,     //  关镜头
};

typedef NS_ENUM(NSInteger, UICATransitionSubType) {
   
   UICATransitionSubTypeFromRight = 1,
   UICATransitionSubTypeFromLeft,
   UICATransitionSubTypeFromTop,
   UICATransitionSubTypeFromBottom
};


@interface UINavigationController (CATransition)

// 传枚举
// push
- (void)pushViewController:(UIViewController *)viewController withCATransitionType:(UICATransitionType)type subType:(UICATransitionSubType)subType animated:(BOOL)animated;
// pop
- (void)popViewControllerWithCATransitionType:(UICATransitionType)type subType:(UICATransitionSubType)subType animated:(BOOL)animated;


// 传字符串
// push
- (void)pushViewController:(UIViewController *)viewController withCATransitionTypeString:(NSString *)typeString subTypeString:(NSString *)subTypeString animated:(BOOL)animated;
// pop
- (void)popViewControllerWithCATransitionTypeString:(NSString *)typeString subTypeString:(NSString *)subTypeString animated:(BOOL)animated;



@end

