//
//  NSString+RegularExpression.h
//  Pods
//
//  Created by Harry on 2021/7/28.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (RegularExpression)

- (NSArray<NSString *> *)IPV4s;

- (NSArray<NSString *> *)DOMAINs;

@end

NS_ASSUME_NONNULL_END
