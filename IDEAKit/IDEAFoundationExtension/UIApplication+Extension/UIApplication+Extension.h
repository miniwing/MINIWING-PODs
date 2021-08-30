//
//  UIApplication+Extension.h
//  IDEAKit
//
//  Created by Harry on 2021/4/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Extension)

+ (BOOL)isAppExtension;
+ (UIApplication *)sharedExtensionApplication;

+ (BOOL)hasHardwareSafeAreas;
+ (CGFloat)deviceTopSafeAreaInset;

@end

NS_ASSUME_NONNULL_END
