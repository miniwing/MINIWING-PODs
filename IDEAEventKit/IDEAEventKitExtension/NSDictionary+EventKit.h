//
//  NSDictionary+EventKit.h
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

#pragma mark -

@protocol NSDictionaryProtocol <NSObject>
@required
- (id)objectForKey:(id)key;
- (BOOL)hasObjectForKey:(id)key;
@optional
- (id)objectForKeyedSubscript:(id)key;
@end

#pragma mark -

@interface NSDictionary (EventKit) <NSDictionaryProtocol>

- (id)objectForOneOfKeys:(NSArray *)aArray;

- (NSNumber *)numberForOneOfKeys:(NSArray *)aArray;
- (NSString *)stringForOneOfKeys:(NSArray *)aArray;

- (id)objectAtPath:(NSString *)aPath;
- (id)objectAtPath:(NSString *)aPath otherwise:(NSObject *)aOther;

- (id)objectAtPath:(NSString *)aPath separator:(NSString *)aSeparator;
- (id)objectAtPath:(NSString *)aPath otherwise:(NSObject *)aOther separator:(NSString *)aSeparator;

- (id)objectAtPath:(NSString *)aPath withClass:(Class)aClass;
- (id)objectAtPath:(NSString *)aPath withClass:(Class)aClass otherwise:(NSObject *)aOther;

- (BOOL)boolAtPath:(NSString *)aPath;
- (BOOL)boolAtPath:(NSString *)aPath otherwise:(BOOL)aOther;

- (NSNumber *)numberAtPath:(NSString *)aPath;
- (NSNumber *)numberAtPath:(NSString *)aPath otherwise:(NSNumber *)aOther;

- (NSString *)stringAtPath:(NSString *)aPath;
- (NSString *)stringAtPath:(NSString *)aPath otherwise:(NSString *)aOther;

- (NSArray *)arrayAtPath:(NSString *)aPath;
- (NSArray *)arrayAtPath:(NSString *)aPath otherwise:(NSArray *)aOther;

- (NSArray *)arrayAtPath:(NSString *)aPath withClass:(Class)aClass;
- (NSArray *)arrayAtPath:(NSString *)aPath withClass:(Class)aClass otherwise:(NSArray *)aOther;

- (NSMutableArray *)mutableArrayAtPath:(NSString *)aPath;
- (NSMutableArray *)mutableArrayAtPath:(NSString *)aPath otherwise:(NSMutableArray *)aOther;

- (NSDictionary *)dictAtPath:(NSString *)aPath;
- (NSDictionary *)dictAtPath:(NSString *)aPath otherwise:(NSDictionary *)aOther;

- (NSMutableDictionary *)mutableDictAtPath:(NSString *)aPath;
- (NSMutableDictionary *)mutableDictAtPath:(NSString *)aPath otherwise:(NSMutableDictionary *)aOther;

@end
