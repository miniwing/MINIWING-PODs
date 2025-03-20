//
//  NSString+RegularExpression.h
//  IDEAKit
//
//  Created by Harry on 2021/7/28.
//  Copyright © 2024 MINIWING. All rights reserved.
//
//  MAIL: miniwing.hz@gmail.com
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Network)

- (NSArray<NSString *> *)IPV4s;

- (NSArray<NSString *> *)DOMAINs;

@end

NS_ASSUME_NONNULL_END
