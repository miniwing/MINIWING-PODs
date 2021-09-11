//
//  PingOperation.h
//
//  Created by Michael Mavris on 03/11/2016.
//  Copyright © 2016 Miksoft. All rights reserved.
//

#import <IDEALanScan/IDEALanScanPing.h>

NS_ASSUME_NONNULL_BEGIN

@interface PingOperation : NSOperation <IDEALanScanPingDelegate>

- (nullable instancetype)initWithIPToPing:(nonnull NSString *)ip andCompletionHandler:(nullable void (^)(NSError  * _Nullable error, NSString  * _Nonnull ip))result;

@end

NS_ASSUME_NONNULL_END
