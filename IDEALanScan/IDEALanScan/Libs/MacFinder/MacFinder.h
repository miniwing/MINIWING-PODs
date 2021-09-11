//
//  MacFinder.h
//  MacFinder
//
//  Created by Michael Mavris on 08/06/16.
//  Copyright © 2016 Miksoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <IDEALanScan/route.h>
#include <IDEALanScan/if_ether.h>

NS_ASSUME_NONNULL_BEGIN

@interface MacFinder : NSObject;

+ (NSString*)ip2mac: (NSString*)aIP;

@end

NS_ASSUME_NONNULL_END
