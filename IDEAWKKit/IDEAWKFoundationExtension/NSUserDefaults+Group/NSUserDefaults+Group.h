//
//  NSUserDefaults+Group.h
//  IDEAWKKit
//
//  Created by Harry on 2019/9/30.
//  Copyright © 2019 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (Extension)

+ (void)setInteger:(NSInteger)aValue forKey:(NSString *)aDefaultName;
+ (void)setFloat:(float)aValue forKey:(NSString *)aDefaultName;
+ (void)setDouble:(double)aValue forKey:(NSString *)aDefaultName;
+ (void)setBool:(BOOL)aValue forKey:(NSString *)aDefaultName;
+ (void)setURL:(nullable NSURL *)aURL forKey:(NSString *)aDefaultName;
+ (void)setObject:(nullable id)aValue forKey:(NSString *)aDefaultName;

+ (void)removeObjectForKey:(NSString *)aDefaultName;

+ (nullable id)objectForKey:(NSString *)aDefaultName;
+ (nullable NSString *)stringForKey:(NSString *)aDefaultName;
+ (nullable NSArray *)arrayForKey:(NSString *)aDefaultName;
+ (nullable NSDictionary<NSString *, id> *)dictionaryForKey:(NSString *)aDefaultName;
+ (nullable NSData *)dataForKey:(NSString *)aDefaultName;
+ (nullable NSArray<NSString *> *)stringArrayForKey:(NSString *)aDefaultName;
+ (NSInteger)integerForKey:(NSString *)aDefaultName;
+ (float)floatForKey:(NSString *)aDefaultName;
+ (double)doubleForKey:(NSString *)aDefaultName;
+ (BOOL)boolForKey:(NSString *)aDefaultName;
+ (nullable NSURL *)URLForKey:(NSString *)aDefaultName;

@end

@interface NSUserDefaults (Group)

+ (void)setInteger:(NSInteger)aValue forKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (void)setFloat:(float)aValue forKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (void)setDouble:(double)aValue forKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (void)setBool:(BOOL)aValue forKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (void)setURL:(nullable NSURL *)aURL forKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (void)setObject:(nullable id)aValue forKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;

+ (void)removeObjectForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;

+ (nullable id)objectForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (nullable NSString *)stringForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (nullable NSArray *)arrayForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (nullable NSDictionary<NSString *, id> *)dictionaryForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (nullable NSData *)dataForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (nullable NSArray<NSString *> *)stringArrayForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (NSInteger)integerForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (float)floatForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (double)doubleForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (BOOL)boolForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;
+ (nullable NSURL *)URLForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite;

@end

NS_ASSUME_NONNULL_END
