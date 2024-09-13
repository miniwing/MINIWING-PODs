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
@property (class, nonatomic, readonly) NSString *appTint;

@property (class, nonatomic, readonly) NSString *text;
@property (class, nonatomic, readonly) NSString *switchOn;

@property (class, nonatomic, readonly) NSString *appNavigationBarTitle;
@property (class, nonatomic, readonly) NSString *appNavigationBarTint;
@property (class, nonatomic, readonly) NSString *appNavigationBarBackground;

@property (class, nonatomic, readonly) NSString *appTabbarTint;
@property (class, nonatomic, readonly) NSString *appTabbarBackground;
@property (class, nonatomic, readonly) NSString *appTabbarUnselected;

@property (class, nonatomic, readonly) NSString *translucentBackground;

@property (class, nonatomic, readonly) NSString *label;
@property (class, nonatomic, readonly) NSString *secondaryLabel;
@property (class, nonatomic, readonly) NSString *tertiaryLabel;
@property (class, nonatomic, readonly) NSString *quaternaryLabel;
@property (class, nonatomic, readonly) NSString *systemFill;
@property (class, nonatomic, readonly) NSString *secondarySystemFill;
@property (class, nonatomic, readonly) NSString *tertiarySystemFill;
@property (class, nonatomic, readonly) NSString *quaternarySystemFill;
@property (class, nonatomic, readonly) NSString *placeholderText;
@property (class, nonatomic, readonly) NSString *systemBackground;
@property (class, nonatomic, readonly) NSString *secondarySystemBackground;
@property (class, nonatomic, readonly) NSString *tertiarySystemBackground;
@property (class, nonatomic, readonly) NSString *systemGroupedBackground;
@property (class, nonatomic, readonly) NSString *secondarySystemGroupedBackground;
@property (class, nonatomic, readonly) NSString *tertiarySystemGroupedBackground;
@property (class, nonatomic, readonly) NSString *separator;
@property (class, nonatomic, readonly) NSString *opaqueSeparator;
@property (class, nonatomic, readonly) NSString *link;
@property (class, nonatomic, readonly) NSString *darkText;
@property (class, nonatomic, readonly) NSString *lightText;
@property (class, nonatomic, readonly) NSString *systemBlue;
@property (class, nonatomic, readonly) NSString *systemGreen;
@property (class, nonatomic, readonly) NSString *systemIndigo;
@property (class, nonatomic, readonly) NSString *systemOrange;
@property (class, nonatomic, readonly) NSString *systemPink;
@property (class, nonatomic, readonly) NSString *systemPurple;
@property (class, nonatomic, readonly) NSString *systemRed;
@property (class, nonatomic, readonly) NSString *systemTeal;
@property (class, nonatomic, readonly) NSString *systemYellow;
@property (class, nonatomic, readonly) NSString *systemGray;
@property (class, nonatomic, readonly) NSString *systemGray2;
@property (class, nonatomic, readonly) NSString *systemGray3;
@property (class, nonatomic, readonly) NSString *systemGray4;
@property (class, nonatomic, readonly) NSString *systemGray5;
@property (class, nonatomic, readonly) NSString *systemGray6;

@property (class, nonatomic, readonly) NSString *darkGray;
@property (class, nonatomic, readonly) NSString *lightGray;

@end

NS_ASSUME_NONNULL_END
