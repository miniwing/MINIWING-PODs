//
//  IDEAWKIdentifier.h
//  IDEAWKKit
//
//  Created by Harry on 2019/9/30.
//  Copyright © 2019 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEAWKIdentifier : NSObject

+ (NSString *)scheme;
+ (NSString *)schemePrefix;

+ (NSString *)appId;

+ (NSString *)identifier;
+ (NSString *)identifierGroup;
+ (NSString *)identifierWidget;

+ (NSString *)appURL;

@end

NS_ASSUME_NONNULL_END
