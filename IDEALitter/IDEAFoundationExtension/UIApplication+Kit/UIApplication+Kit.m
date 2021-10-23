//
//  UIApplication+Kit.m
//  IDEALitter
//
//  Created by Harry on 2021/10/23.
//

#import "IDEALitter/UIApplication+Kit.h"

@implementation UIApplication (Kit)

+ (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

@end
