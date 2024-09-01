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

#if (__has_include(<IDEANightVersion/IDEANightVersion-umbrella.h>) || __has_include("IDEANightVersion/IDEANightVersion-umbrella.h") || __has_include("DKNightVersion.h"))
+ (UIColor *) colorWithKey:(NSString *)aKey;
#endif
@property (class, nonatomic, readonly) UIColor *appTint;

@property (class, nonatomic, readonly) UIColor *text;
@property (class, nonatomic, readonly) UIColor *switchOn;

@property (class, nonatomic, readonly) UIColor *appNavigationBarTitle;
@property (class, nonatomic, readonly) UIColor *appNavigationBarTint;
@property (class, nonatomic, readonly) UIColor *appNavigationBarBackground;

@property (class, nonatomic, readonly) UIColor *appTabbarTint;
@property (class, nonatomic, readonly) UIColor *appTabbarBackground;
@property (class, nonatomic, readonly) UIColor *appTabbarUnselected;

@property (class, nonatomic, readonly) UIColor *translucentBackground;

@property (class, nonatomic, readonly) UIColor *label;
@property (class, nonatomic, readonly) UIColor *secondaryLabel;
@property (class, nonatomic, readonly) UIColor *tertiaryLabel;
@property (class, nonatomic, readonly) UIColor *quaternaryLabel;
@property (class, nonatomic, readonly) UIColor *systemFill;
@property (class, nonatomic, readonly) UIColor *secondarySystemFill;
@property (class, nonatomic, readonly) UIColor *tertiarySystemFill;
@property (class, nonatomic, readonly) UIColor *quaternarySystemFill;
@property (class, nonatomic, readonly) UIColor *placeholderText;
@property (class, nonatomic, readonly) UIColor *systemBackground;
@property (class, nonatomic, readonly) UIColor *secondarySystemBackground;
@property (class, nonatomic, readonly) UIColor *tertiarySystemBackground;
@property (class, nonatomic, readonly) UIColor *systemGroupedBackground;
@property (class, nonatomic, readonly) UIColor *secondarySystemGroupedBackground;
@property (class, nonatomic, readonly) UIColor *tertiarySystemGroupedBackground;
@property (class, nonatomic, readonly) UIColor *separator;
@property (class, nonatomic, readonly) UIColor *opaqueSeparator;
@property (class, nonatomic, readonly) UIColor *link;
@property (class, nonatomic, readonly) UIColor *darkText;
@property (class, nonatomic, readonly) UIColor *lightText;
@property (class, nonatomic, readonly) UIColor *systemBlue;
@property (class, nonatomic, readonly) UIColor *systemGreen;
@property (class, nonatomic, readonly) UIColor *systemIndigo;
@property (class, nonatomic, readonly) UIColor *systemOrange;
@property (class, nonatomic, readonly) UIColor *systemPink;
@property (class, nonatomic, readonly) UIColor *systemPurple;
@property (class, nonatomic, readonly) UIColor *systemRed;
@property (class, nonatomic, readonly) UIColor *systemTeal;
@property (class, nonatomic, readonly) UIColor *systemYellow;
@property (class, nonatomic, readonly) UIColor *systemGray;
@property (class, nonatomic, readonly) UIColor *systemGray2;
@property (class, nonatomic, readonly) UIColor *systemGray3;
@property (class, nonatomic, readonly) UIColor *systemGray4;
@property (class, nonatomic, readonly) UIColor *systemGray5;
@property (class, nonatomic, readonly) UIColor *systemGray6;

@property (class, nonatomic, readonly) UIColor *darkGray;
@property (class, nonatomic, readonly) UIColor *lightGray;

@end

NS_ASSUME_NONNULL_END
