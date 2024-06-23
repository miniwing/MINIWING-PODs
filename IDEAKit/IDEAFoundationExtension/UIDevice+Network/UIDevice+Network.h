//
//  UIDevice+Network.h
//  NetworkArch
//
//  Created by Harry on 2021/7/31.
//  Copyright © 2024 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IDEA_ENUM(NSInteger, Network) {
   
   NetworkWifi       = 0,
   NetworkCellular   = 1
};

@interface UIDevice (Network)

+ (NSString *)radioTechnologyFor:(NSString *)aKey;
+ (NSString *)networkName:(Network)aNetwork;

+ (NSString *)ipv4:(Network)aNetwork;
+ (NSString *)ipv6:(Network)aNetwork;

@end

NS_ASSUME_NONNULL_END
