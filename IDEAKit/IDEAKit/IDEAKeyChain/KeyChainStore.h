//
//  KeyChainStore.h
//  ContentProvider
//
//  Created by Harry on 2022/3/29.
//
//  Mail: miniwing.hz@gmail.com
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyChainStore : NSObject

@end

@interface KeyChainStore ()

+ (void)removeUUIDWithBundleID:(NSString *)aBundleID;
+ (void)saveUUID:(NSString *)aUUID withBundleID:(NSString *)aBundleID;
+ (NSString *)queryUUIDWithBundleID:(NSString *)aBundleID;

@end

NS_ASSUME_NONNULL_END
