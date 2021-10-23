//
//  UIApplication+Kit.h
//  IDEALitter
//
//  Created by Harry on 2021/10/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Kit)

/// Application's Version.  e.g. "1.2.0"
@property (nullable, class, nonatomic, readonly) NSString *appVersion;

/// Application's Build number. e.g. "123"
@property (nullable, class, nonatomic, readonly) NSString *appBuildVersion;

@end

NS_ASSUME_NONNULL_END
