//
//  UIApplication+Path.h
//  IDEAKit
//
//  Created by Harry on 2021/4/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Path)

+ (NSURL *)groupURL:(NSString *)aGroupIdentifier;
+ (NSString *)groupPath:(NSString *)aGroupIdentifier;

@end

NS_ASSUME_NONNULL_END
