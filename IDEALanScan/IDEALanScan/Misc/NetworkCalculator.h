//
//  NetworkCalculator.h
//  MMLanScanDemo
//
//  Created by Michalis Mavris on 12/08/16.
//  Copyright © 2016 Miksoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkCalculator : NSObject

+ (NSArray *)getAllHostsForIP:(NSString *)ipAddress andSubnet:(NSString *)subnetMask;

@end

NS_ASSUME_NONNULL_END
