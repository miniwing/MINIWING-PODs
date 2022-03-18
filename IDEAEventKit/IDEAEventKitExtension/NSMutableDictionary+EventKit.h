//
//  NSMutableDictionary+EventKit.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <Foundation/Foundation.h>
#import <IDEAEventKit/IDEAEventKitProperty.h>

#import "NSDictionary+EventKit.h"

#pragma mark -

@protocol NSMutableDictionaryProtocol <NSObject>
@required
- (void)setObject:(id)aObject forKey:(id)key;
- (void)removeObjectForKey:(id)key;
- (void)removeAllObjects;
@optional
- (void)setObject:(id)obj forKeyedSubscript:(id)key;
@end

#pragma mark -

@interface NSMutableDictionary (EventKit) <NSDictionaryProtocol, NSMutableDictionaryProtocol>

+ (NSMutableDictionary *)nonRetainingDictionary;
+ (NSMutableDictionary *)keyValues:(id)aFirst, ...;

- (BOOL)setObject:(NSObject *)aObject atPath:(NSString *)aPath;
- (BOOL)setObject:(NSObject *)aObject atPath:(NSString *)aPath separator:(NSString *)aSeparator;
- (BOOL)setKeyValues:(id)aFirst, ...;

- (id)objectForOneOfKeys:(NSArray *)array remove:(BOOL)flag;

- (NSNumber *)numberForOneOfKeys:(NSArray *)array remove:(BOOL)flag;
- (NSString *)stringForOneOfKeys:(NSArray *)array remove:(BOOL)flag;

@end
