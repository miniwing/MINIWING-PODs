//
//  MMDevice.h
//  MMLanScanDemo
//
//  Created by Michalis Mavris on 08/07/2017.
//  Copyright © 2017 Miksoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMDevice : NSObject

@property (nonatomic, strong)                NSString                            * hostname;
@property (nonatomic, strong)                NSString                            * ipAddress;
@property (nonatomic, strong)                NSString                            * macAddress;
@property (nonatomic, strong)                NSString                            * subnetMask;
@property (nonatomic, strong)                NSString                            * brand;
@property (nonatomic, assign)                BOOL                                  isLocalDevice;

@end

@interface MMDevice ()

- (NSString *)macAddressLabel;

@end

NS_ASSUME_NONNULL_END
