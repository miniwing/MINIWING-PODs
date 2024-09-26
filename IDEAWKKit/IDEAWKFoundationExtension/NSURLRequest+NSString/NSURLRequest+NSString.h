//
//  NSURLRequest+NSString.h
//  IDEAWKKit
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail:miniwing.hz@gmail.com
//  TEL :+(852)53054612
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (NSString)

+ (instancetype)requestWithURLString:(NSString *)aURL;
+ (instancetype)requestWithURLString:(NSString *)aURL cachePolicy:(NSURLRequestCachePolicy)aCachePolicy timeoutInterval:(NSTimeInterval)aTimeoutInterval;

@end

@interface NSMutableURLRequest (NSString)

+ (instancetype)requestWithURLString:(NSString *)aURL;
+ (instancetype)requestWithURLString:(NSString *)aURL cachePolicy:(NSURLRequestCachePolicy)aCachePolicy timeoutInterval:(NSTimeInterval)aTimeoutInterval;

@end

