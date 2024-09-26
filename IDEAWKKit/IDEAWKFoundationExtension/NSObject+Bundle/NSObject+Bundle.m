//
//  NSObject+Bundle.m
//  IDEAWKKit
//
//  Created by Harry on 14-8-12.
//  Copyright (c) 2014年 Idea.Mobi. All rights reserved.
//

#import "NSObject+Bundle.h"

@implementation NSObject (Bundle)

+ (BOOL)currentBundle {
   
   return [NSBundle bundleForClass:[self class]];
}

- (BOOL)currentBundle {
   
   return [NSBundle bundleForClass:[self class]];
}

@end

