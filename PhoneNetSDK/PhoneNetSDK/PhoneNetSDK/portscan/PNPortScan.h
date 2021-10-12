//
//  PNPortScan.h
//  PhoneNetSDK
//
//  Created by mediaios on 2019/2/28.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhoneNetSDKHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface PNPortScan : NSObject

+ (instancetype)shareInstance;
- (void)portScan:(NSString *)host beginPort:(NSUInteger)beginPort endPort:(NSUInteger)endPort completeHandler:(NetPortScanHandler)handler;
- (BOOL)isDoingScanPort;
- (void)stopPortScan;

/// HARRY
- (void)portScan:(NSString *)aHost
       beginPort:(NSUInteger)aBeginPort
         endPort:(NSUInteger)aEndPort
     scanHandler:(NetPortScanHandler)aScanHandler
 completeHandler:(CompletionHandler)aCompleteHandler;

@end

NS_ASSUME_NONNULL_END
