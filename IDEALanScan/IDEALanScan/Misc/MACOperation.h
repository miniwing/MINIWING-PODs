//
//  PingOperation.h
//
//  Created by Michael Mavris on 03/11/2016.
//  Copyright © 2016 Miksoft. All rights reserved.
//

#import <IDEALanScan/IDEALanScanPing.h>

@class MMDevice;

NS_ASSUME_NONNULL_BEGIN

@interface MACOperation: NSOperation {
    BOOL _isFinished;
    BOOL _isExecuting;
}

-(nullable instancetype)initWithIPToRetrieveMAC:(nonnull NSString*)ip andBrandDictionary:(nullable NSDictionary*)brandDictionary andCompletionHandler:(nullable void (^)(NSError  * _Nullable error, NSString  * _Nonnull ip,MMDevice * _Nonnull device))result;
@end

NS_ASSUME_NONNULL_END
