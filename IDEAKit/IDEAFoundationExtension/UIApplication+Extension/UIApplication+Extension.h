//
//  UIApplication+Extension.h
//  IDEAKit
//
//  Created by Harry on 2021/4/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Extension)

#if __has_include(<YYKit/YYKit.h>)
#elif __has_include("YYKit/YYKit.h")
#else
+ (BOOL)isAppExtension;
+ (UIApplication *)sharedExtensionApplication;
#endif

+ (BOOL)hasHardwareSafeAreas;
+ (CGFloat)deviceTopSafeAreaInset;

@end

NS_ASSUME_NONNULL_END
