//
//  IDEAColor.h
//  IDEAColor
//
//  Created by Harry on 2020/11/3.
//  Copyright © 2020 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEAColor : NSObject

#if (__has_include(<IDEANightVersion/DKNightVersion.h>) || __has_include("IDEANightVersion/DKNightVersion.h") || __has_include("DKNightVersion.h"))
+ (UIColor *) colorWithKey:(NSString *)aKey;
#endif
+ (NSString *)appTint;

+ (NSString *)text;
+ (NSString *)switchOn;

+ (NSString *)appNavigationBarTitle;
+ (NSString *)appNavigationBarTint;
+ (NSString *)appNavigationBarBackground;

+ (NSString *)appTabbarTint;
+ (NSString *)appTabbarBackground;
+ (NSString *)appTabbarUnselected;

+ (NSString *)translucentBackground;

+ (NSString *)label;
+ (NSString *)secondaryLabel;
+ (NSString *)tertiaryLabel;
+ (NSString *)quaternaryLabel;
+ (NSString *)systemFill;
+ (NSString *)secondarySystemFill;
+ (NSString *)tertiarySystemFill;
+ (NSString *)quaternarySystemFill;
+ (NSString *)placeholderText;
+ (NSString *)systemBackground;
+ (NSString *)secondarySystemBackground;
+ (NSString *)tertiarySystemBackground;
+ (NSString *)systemGroupedBackground;
+ (NSString *)secondarySystemGroupedBackground;
+ (NSString *)tertiarySystemGroupedBackground;
+ (NSString *)separator;
+ (NSString *)opaqueSeparator;
+ (NSString *)link;
+ (NSString *)darkText;
+ (NSString *)lightText;
+ (NSString *)systemBlue;
+ (NSString *)systemGreen;
+ (NSString *)systemIndigo;
+ (NSString *)systemOrange;
+ (NSString *)systemPink;
+ (NSString *)systemPurple;
+ (NSString *)systemRed;
+ (NSString *)systemTeal;
+ (NSString *)systemYellow;
+ (NSString *)systemGray;
+ (NSString *)systemGray2;
+ (NSString *)systemGray3;
+ (NSString *)systemGray4;
+ (NSString *)systemGray5;
+ (NSString *)systemGray6;

+ (NSString *)darkGray;
+ (NSString *)lightGray;

@end

NS_ASSUME_NONNULL_END
