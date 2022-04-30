//
//  UIColorX+System.m
//  IDEAKit
//
//  Created by Harry on 15/1/31.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "UIColorX+System.h"

//#ifdef __IPHONE_13_0
//#else /* __IPHONE_13_0 */

#ifndef rgba
#  define rgba(r,g,b,a)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#endif /* rgba */

#pragma mark - Light Mode
@implementation UIColorX

+ (UIColor *)labelColor {
   
   return rgba(0.0, 0.0, 0.0, 1.0);
}

+ (UIColor *)secondaryLabelColor {
   
   return rgba(60.0, 60.0, 67.0, 0.6);
}

+ (UIColor *)tertiaryLabelColor {
   
   return rgba(60.0, 60.0, 67.0, 0.3);
}

+ (UIColor *)quaternaryLabelColor {
   
   return rgba(60.0, 60.0, 67.0, 0.18);
}

+ (UIColor *)systemFillColor {
   
   return rgba(120.0, 120.0, 128.0, 0.2);
}

+ (UIColor *)secondarySystemFillColor {
   
   return rgba(120.0, 120.0, 128.0, 0.16);
}

+ (UIColor *)tertiarySystemFillColor {
   
   return rgba(118.0, 118.0, 128.0, 0.12);
}

+ (UIColor *)quaternarySystemFillColor {
   
   return rgba(116.0, 116.0, 128.0, 0.08);
}

+ (UIColor *)placeholderTextColor {
   
   return rgba(60.0, 60.0, 67.0, 0.3);
}

+ (UIColor *)systemBackgroundColor {
   
   return rgba(255.0, 255.0, 255.0, 1.0);
}

+ (UIColor *)secondarySystemBackgroundColor {
   
   return rgba(242.0, 242.0, 247.0, 1.0);
}

+ (UIColor *)tertiarySystemBackgroundColor {
   
   return rgba(255.0, 255.0, 255.0, 1.0);
}

+ (UIColor *)systemGroupedBackgroundColor {
   
   return rgba(242.0, 242.0, 247.0, 1.0);
}

+ (UIColor *)secondarySystemGroupedBackgroundColor {
   
   return rgba(255.0, 255.0, 255.0, 1.0);
}

+ (UIColor *)tertiarySystemGroupedBackgroundColor {
   
   return rgba(242.0, 242.0, 247.0, 1.0);
}

+ (UIColor *)separatorColor {
   
   return rgba(60.0, 60.0, 67.0, 0.29);
}

+ (UIColor *)opaqueSeparatorColor {
   
   return rgba(198.0, 198.0, 200.0, 1.0);
}

+ (UIColor *)linkColor {
   
   return rgba(0.0, 122.0, 255.0, 1.0);
}

+ (UIColor *)darkTextColor {
   
   return rgba(0.0, 0.0, 0.0, 1.0);
}

+ (UIColor *)lightTextColor {
   
   return rgba(255.0, 255.0, 255.0, 0.6);
}

+ (UIColor *)systemBlueColor {
   
   return rgba(0.0, 122.0, 255.0, 1.0);
}

+ (UIColor *)systemGreenColor {
   
   return rgba(52.0, 199.0, 89.0, 1.0);
}

+ (UIColor *)systemIndigoColor {
   
   return rgba(88.0, 86.0, 214.0, 1.0);
}

+ (UIColor *)systemOrangeColor {
   
   return rgba(255.0, 149.0, 0.0, 1.0);
}

+ (UIColor *)systemPinkColor{
   
   return rgba(255.0, 45.0, 85.0, 1.0);
}

+ (UIColor *)systemPurpleColor {
   
   return rgba(175.0, 82.0, 222.0, 1.0);
}

+ (UIColor *)systemRedColor {
   
   return rgba(255.0, 59.0, 48.0, 1.0);
}

+ (UIColor *)systemTealColor {
   
   return rgba(90.0, 200.0, 250.0, 1.0);
}

+ (UIColor *)systemYellowColor {
   
   return rgba(255.0, 204.0, 0.0, 1.0);
}

+ (UIColor *)systemGrayColor {
   
   return rgba(142.0, 142.0, 147.0, 1.0);
}

+ (UIColor *)systemGray2Color {
   
   return rgba(174.0, 174.0, 178.0, 1.0);
}

+ (UIColor *)systemGray3Color {
   
   return rgba(199.0, 199.0, 204.0, 1.0);
}

+ (UIColor *)systemGray4Color {
   
   return rgba(209.0, 209.0, 214.0, 1.0);
}

+ (UIColor *)systemGray5Color {
   
   return rgba(229.0, 229.0, 234.0, 1.0);
}

+ (UIColor *)systemGray6Color {
   
   return rgba(242.0, 242.0, 247.0, 1.0);
}

#pragma mark Other NavigationBar
+ (UIColor *)appNavigationBarTintColor {
   
   return rgba(0, 0, 0, 1.0);
}

+ (UIColor *)appNavigationBarTitleColor {
   
   return rgba(0x1C, 0x1C, 0x1E, 1.0);
}

+ (UIColor *)appTabbarBackgroundColor {
   
   return rgba(0xFF, 0xFF, 0xFF, 1.0);
}

+ (UIColor *)appTabbarTintColor {
   
   return rgba(0x00, 0x5F, 0x81, 1.0);
}

+ (UIColor *)appTabbarUnselectedColor {
   
   return rgba(0x40, 0x9C, 0xC8, 1.0);
}

@end

//#endif /* !__IPHONE_13_0 */

#pragma mark - Dark Mode

#if 0
+ (UIColor *)labelColor {
   return rgba(255.0, 255.0, 255.0, 1.0);
}
+ (UIColor *)secondaryLabelColor {
   return rgba(235.0, 235.0, 245.0, 0.6);
}
+ (UIColor *)tertiaryLabelColor {
   return rgba(235.0, 235.0, 245.0, 0.3);
}
+ (UIColor *)quaternaryLabelColor {
   return rgba(235.0, 235.0, 245.0, 0.18);
}
+ (UIColor *)systemFillColor {
   return rgba(120.0, 120.0, 128.0, 0.36);
}
+ (UIColor *)secondarySystemFillColor {
   return rgba(120.0, 120.0, 128.0, 0.32);
}
+ (UIColor *)tertiarySystemFillColor {
   return rgba(118.0, 118.0, 128.0, 0.24);
}
+ (UIColor *)quaternarySystemFillColor {
   return rgba(118.0, 118.0, 128.0, 0.18);
}
+ (UIColor *)placeholderTextColor {
   return rgba(235.0, 235.0, 245.0, 0.3);
}
+ (UIColor *)systemBackgroundColor {
   return rgba(0.0, 0.0, 0.0, 1.0);
}
+ (UIColor *)secondarySystemBackgroundColor {
   return rgba(28.0, 28.0, 30.0, 1.0);
}
+ (UIColor *)tertiarySystemBackgroundColor {
   return rgba(44.0, 44.0, 46.0, 1.0);
}
+ (UIColor *)systemGroupedBackgroundColor {
   return rgba(0.0, 0.0, 0.0, 1.0);
}
+ (UIColor *)secondarySystemGroupedBackgroundColor {
   return rgba(28.0, 28.0, 30.0, 1.0);
}
+ (UIColor *)tertiarySystemGroupedBackgroundColor {
   return rgba(44.0, 44.0, 46.0, 1.0);
}
+ (UIColor *)separatorColor {
   return rgba(84.0, 84.0, 88.0, 0.6);
}
+ (UIColor *)opaqueSeparatorColor {
   return rgba(56.0, 56.0, 58.0, 1.0);
}
+ (UIColor *)linkColor {
   return rgba(9.0, 132.0, 255.0, 1.0);
}
+ (UIColor *)darkTextColor {
   return rgba(0.0, 0.0, 0.0, 1.0);
}
+ (UIColor *)lightTextColor {
   return rgba(255.0, 255.0, 255.0, 0.6);
}
+ (UIColor *)systemBlueColor {
   return rgba(10.0, 132.0, 255.0, 1.0);
}
+ (UIColor *)systemGreenColor {
   return rgba(48.0, 209.0, 88.0, 1.0);
}
+ (UIColor *)systemIndigoColor {
   return rgba(94.0, 92.0, 230.0, 1.0);
}
+ (UIColor *)systemOrangeColor {
   return rgba(255.0, 159.0, 10.0, 1.0);
}
+ (UIColor *)systemPinkColor {
   return rgba(255.0, 55.0, 95.0, 1.0);
}
+ (UIColor *)systemPurpleColor {
   return rgba(191.0, 90.0, 242.0, 1.0);
}
+ (UIColor *)systemRedColor {
   return rgba(255.0, 69.0, 58.0, 1.0);
}
+ (UIColor *)systemTealColor {
   return rgba(100.0, 210.0, 255.0, 1.0);
}
+ (UIColor *)systemYellowColor {
   return rgba(255.0, 214.0, 10.0, 1.0);
}
+ (UIColor *)systemGrayColor {
   return rgba(142.0, 142.0, 147.0, 1.0);
}
+ (UIColor *)systemGray2Color {
   return rgba(99.0, 99.0, 102.0, 1.0);
}
+ (UIColor *)systemGray3Color {
   return rgba(72.0, 72.0, 74.0, 1.0);
}
+ (UIColor *)systemGray4Color {
   return rgba(58.0, 58.0, 60.0, 1.0);
}
+ (UIColor *)systemGray5Color {
   return rgba(44.0, 44.0, 46.0, 1.0);
}
+ (UIColor *)systemGray6Color {
   return rgba(28.0, 28.0, 30.0, 1.0);
}

#endif

