//
//  IDEAEventKitHandler.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <IDEAEventKit/IDEAEventKitProperty.h>

#pragma mark -

#undef  singleton
#define singleton( __class )                                      \
        property (nonatomic, readonly) __class * sharedInstance;  \
        - (__class *)sharedInstance;                              \
        + (__class *)sharedInstance;

#undef  def_singleton
#define def_singleton( __class )                                  \
        dynamic sharedInstance;                                   \
        - (__class *)sharedInstance {                             \
                                                                  \
           return [__class sharedInstance];                       \
        }                                                         \
        + (__class *)sharedInstance {                             \
                                                                  \
           static dispatch_once_t once;                           \
           static __strong id __singleton__ = nil;                \
           dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
           return __singleton__;                                  \
        }

#pragma mark -
