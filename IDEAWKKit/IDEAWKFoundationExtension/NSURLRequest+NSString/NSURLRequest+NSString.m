//
//  NSURLRequest+NSString.m
//  IDEAWKKit
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "NSURLRequest+NSString.h"

@implementation NSURLRequest (NSString)

+ (instancetype)requestWithURLString:(NSString *)aURL {
   
   return [NSURLRequest requestWithURL:[NSURL URLWithString:aURL]];
}

+ (instancetype)requestWithURLString:(NSString *)aURL
                         cachePolicy:(NSURLRequestCachePolicy)aCachePolicy
                     timeoutInterval:(NSTimeInterval)aTimeoutInterval {
   
   return [NSURLRequest requestWithURL:[NSURL URLWithString:aURL]
                           cachePolicy:aCachePolicy
                       timeoutInterval:aTimeoutInterval];
}

@end

@implementation NSMutableURLRequest (NSString)

+ (instancetype)requestWithURLString:(NSString *)aURL {
   
   return [NSMutableURLRequest requestWithURL:[NSURL URLWithString:aURL]];
}

+ (instancetype)requestWithURLString:(NSString *)aURL
                         cachePolicy:(NSURLRequestCachePolicy)aCachePolicy
                     timeoutInterval:(NSTimeInterval)aTimeoutInterval {
   
   return [NSMutableURLRequest requestWithURL:[NSURL URLWithString:aURL]
                                  cachePolicy:aCachePolicy
                              timeoutInterval:aTimeoutInterval];
}

@end

