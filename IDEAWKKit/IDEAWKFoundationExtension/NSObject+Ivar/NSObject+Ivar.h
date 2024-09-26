//
//  NSObject+Ivar.h
//  IDEAWKKit
//
//  Created by Harry on 14-8-12.
//  Copyright (c) 2014年 Idea.Mobi. All rights reserved.
//
//  Mail:miniwing.hz@gmail.com
//  TEL :+(852)53054612
//

#import <Foundation/Foundation.h>

@interface NSObject (Ivar)

- (NSArray *)getAllIvar;
- (NSArray<NSString *> *)getAllIvarNames;
- (NSArray *)getAllProperty;

@end

