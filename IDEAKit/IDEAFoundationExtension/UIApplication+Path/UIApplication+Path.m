//
//  UIApplication+Path.m
//  IDEAKit
//
//  Created by Harry on 2021/4/29.
//

#import "UIApplication+Path.h"

@implementation UIApplication (Path)

+ (NSURL *)groupURL:(NSString *)aGroupIdentifier {
   return [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:aGroupIdentifier];
}

+ (NSString *)groupPath:(NSString *)aGroupIdentifier {
   return [self groupURL:aGroupIdentifier].path;
}

@end
