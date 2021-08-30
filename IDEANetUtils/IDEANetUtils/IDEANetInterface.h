//
//  IDEANetInterface.h
//  IDEANetUtils
//
//  Created by Harry on 2021/8/2.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NetFamily) {
   
   /// IPv4.
   NetFamilyIPV4  = 0,
   
   /// IPv6.
   NetFamilyIPV6  = 1,
   
   /// Used in case of errors.
   NetFamilyOther = 2
};

@interface IDEANetInterface : NSObject

/// Field `ifaddrs->ifa_name`.
// public let name : String
@property (nonatomic, copy)                  NSString                            * name;

/// Field `ifaddrs->ifa_addr->sa_family`.
// public let family : Family
@property (nonatomic, assign)                NetFamily                             family;

/// Extracted from `ifaddrs->ifa_addr`, supports both IPv4 and IPv6.
// public let address : String?
@property (nonatomic, copy)                  NSString                            * address;

/// Extracted from `ifaddrs->ifa_netmask`, supports both IPv4 and IPv6.
// public let netmask : String?
@property (nonatomic, copy)                  NSString                            * netmask;

/// Extracted from `ifaddrs->ifa_dstaddr`. Not applicable for IPv6.
// public let broadcastAddress : String?
@property (nonatomic, copy)                  NSString                            * broadcastAddress;

@end

@interface IDEANetInterface ()

+ (instancetype)interfaceWithIfAddrs:(struct ifaddrs *)aIfAddrs;

@end

@interface IDEANetInterface ()

/// `IFF_RUNNING` flag of `ifaddrs->ifa_flags`.
// open var isRunning: Bool { return running }
- (BOOL)isRunning;

/// `IFF_UP` flag of `ifaddrs->ifa_flags`.
// open var isUp: Bool { return up }
- (BOOL)isUp;

/// `IFF_LOOPBACK` flag of `ifaddrs->ifa_flags`.
// open var isLoopback: Bool { return loopback }
- (BOOL)isLoopback;

/// `IFF_MULTICAST` flag of `ifaddrs->ifa_flags`.
// open var supportsMulticast: Bool { return multicastSupported }
- (BOOL)supportsMulticast;

+ (NSString *)familyToString:(NetFamily)aNetFamily;

@end

NS_ASSUME_NONNULL_END
