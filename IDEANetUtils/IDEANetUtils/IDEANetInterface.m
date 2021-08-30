//
//  IDEANetInterface.m
//  IDEANetUtils
//
//  Created by Harry on 2021/8/2.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEANetUtils/IDEANetInterface.h"

@interface IDEANetInterface ()

///// `IFF_RUNNING` flag of `ifaddrs->ifa_flags`.
//// open var isRunning: Bool { return running }
//@property (nonatomic, assign, readonly, getter = isRunning)    BOOL                running;
//
///// `IFF_UP` flag of `ifaddrs->ifa_flags`.
//// open var isUp: Bool { return up }
//@property (nonatomic, assign, readonly, getter = isUp)         BOOL                up;
//
///// `IFF_LOOPBACK` flag of `ifaddrs->ifa_flags`.
//// open var isLoopback: Bool { return loopback }
//@property (nonatomic, assign, readonly, getter = isLoopback)   BOOL                loopback;
//
///// `IFF_MULTICAST` flag of `ifaddrs->ifa_flags`.
//// open var supportsMulticast: Bool { return multicastSupported }
//@property (nonatomic, assign, readonly, getter = supportsMulticast)  BOOL          multicastSupported;
//
///// Field `ifaddrs->ifa_name`.
//// public let name : String
//@property (nonatomic, strong)                NSString                            * name;
//
///// Field `ifaddrs->ifa_addr->sa_family`.
//// public let family : Family
//@property (nonatomic, assign)                NetFamily                             family;
//
///// Extracted from `ifaddrs->ifa_addr`, supports both IPv4 and IPv6.
//// public let address : String?
//@property (nonatomic, strong)                NSString                            * address;
//
///// Extracted from `ifaddrs->ifa_netmask`, supports both IPv4 and IPv6.
//// public let netmask : String?
//@property (nonatomic, strong)                NSString                            * netmask;
//
///// Extracted from `ifaddrs->ifa_dstaddr`. Not applicable for IPv6.
//// public let broadcastAddress : String?
//@property (nonatomic, strong)                NSString                            * broadcastAddress;

// fileprivate let running : Bool
@property (nonatomic, assign)                BOOL                                  running;

// fileprivate let up : Bool
@property (nonatomic, assign)                BOOL                                  up;

// fileprivate let loopback : Bool
@property (nonatomic, assign)                BOOL                                  loopback;

// fileprivate let multicastSupported : Bool
@property (nonatomic, assign)                BOOL                                  multicastSupported;

@end

@implementation IDEANetInterface

#pragma mark -
+ (struct sockaddr *)destinationAddress:(struct ifaddrs *)aIfaddrs {
   
   return aIfaddrs->ifa_dstaddr;
}

+ (int32_t)socketLength4:(struct sockaddr *)aAddr {
   
   return aAddr->sa_len;
}

- (NSUUID *)UUID {
   
   return [NSUUID UUID];
}

- (NSString *)toString:(NetFamily)aNetFamily {
   
   switch (aNetFamily) {
      case NetFamilyIPV4:
         return @"IPv4";
      case NetFamilyIPV6:
         return @"IPv6";
      default:
         return @"other";
   }
}

#pragma mark -
+ (instancetype)interfaceWithIfAddrs:(struct ifaddrs *)aIfAddrs {
   
   return [[IDEANetInterface alloc] initWithIfAddrs:aIfAddrs];
}

- (instancetype)initWithIfAddrs:(struct ifaddrs *)aIfAddrs {
   
   int                            nErr                                     = EFAULT;
   
   int32_t                        nFlags                                   = 0;
   BOOL                           bBroadcastValid                          = NO;
   
   NSString                      *szName                                   = nil;
   
   __TRY;
   
   if ((NULL == aIfAddrs) || (0 == strlen(aIfAddrs->ifa_name))) {
      
      nErr  = EINVAL;
      
      break;
      
   } /* End if () */
   
   nFlags            = aIfAddrs->ifa_flags;
   bBroadcastValid   = ((nFlags & IFF_BROADCAST) == IFF_BROADCAST);
   
   szName   = [NSString stringWithCString:aIfAddrs->ifa_name encoding:NSUTF8StringEncoding];
   
   self  = [self initWithName:szName
                       family:[IDEANetInterface extractFamily:aIfAddrs]
                      address:[IDEANetInterface extractAddress:aIfAddrs->ifa_addr]
                      netmask:[IDEANetInterface extractAddress:aIfAddrs->ifa_netmask]
                      running:((nFlags & IFF_RUNNING) == IFF_RUNNING)
                           up:((nFlags & IFF_UP) == IFF_UP)
                     loopback:((nFlags & IFF_LOOPBACK) == IFF_LOOPBACK)
           multicastSupported:((nFlags & IFF_MULTICAST) == IFF_MULTICAST)
             broadcastAddress:((bBroadcastValid && (NULL != aIfAddrs->ifa_dstaddr)) ? [IDEANetInterface extractAddress:aIfAddrs] : nil)];
   
//   if (self) {
//
//      self.init(name: String(cString: data.ifa_name),
//          family: Interface.extractFamily(data),
//          address: Interface.extractAddress(data.ifa_addr),
//          netmask: Interface.extractAddress(data.ifa_netmask),
//          running: ((flags & IFF_RUNNING) == IFF_RUNNING),
//          up: ((flags & IFF_UP) == IFF_UP),
//          loopback: ((flags & IFF_LOOPBACK) == IFF_LOOPBACK),
//          multicastSupported: ((flags & IFF_MULTICAST) == IFF_MULTICAST),
//          broadcastAddress: ((broadcastValid && destinationAddress(data) != nil) ? Interface.extractAddress(destinationAddress(data)) : nil))
//
//   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (instancetype)initWithName:(NSString *)aName
                      family:(NetFamily)aFamily
                     address:(NSString *)aAddress
                     netmask:(NSString *)aNetmask
                     running:(BOOL)aRunning
                          up:(BOOL)aUP
                    loopback:(BOOL)aLoopback
          multicastSupported:(BOOL)aMulticastSupported
            broadcastAddress:(NSString *)aBroadcastAddress {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super init];
   
   if (self) {

      _name       = aName;
      _family     = aFamily;
      _address    = aAddress;
      _netmask    = aNetmask;
      _running    = aRunning;
      _up         = aUP;
      _loopback   = aLoopback;
      _multicastSupported  = aMulticastSupported;
      _broadcastAddress    = aBroadcastAddress;

   } /* End if () */

   __CATCH(nErr);
   
   return self;
}


/// `IFF_RUNNING` flag of `ifaddrs->ifa_flags`.
// open var isRunning: Bool { return running }
- (BOOL)isRunning {
   
   return _running;
}

/// `IFF_UP` flag of `ifaddrs->ifa_flags`.
// open var isUp: Bool { return up }
- (BOOL)isUp {
   
   return _up;
}

/// `IFF_LOOPBACK` flag of `ifaddrs->ifa_flags`.
// open var isLoopback: Bool { return loopback }
- (BOOL)isLoopback {
   
   return _loopback;
}

/// `IFF_MULTICAST` flag of `ifaddrs->ifa_flags`.
// open var supportsMulticast: Bool { return multicastSupported }
- (BOOL)supportsMulticast {
   
   return _multicastSupported;
}

+ (NetFamily)extractFamily:(struct ifaddrs *)aIfAddrs {
   
   int                            nErr                                     = EFAULT;

   NetFamily                      eFamily                                  = NetFamilyOther;
   struct sockaddr               *pstAddr                                  = NULL;

   __TRY;

   if (NULL == aIfAddrs) {
      
      nErr  = EINVAL;
      
      break;
      
   } /* End if () */
   
   pstAddr = aIfAddrs->ifa_addr;
   
    if (pstAddr->sa_family == (uint8_t)AF_INET) {
       
       eFamily = NetFamilyIPV4;
       
    } /* End if () */
    else if (pstAddr->sa_family == (uint8_t)AF_INET6) {
       
       eFamily = NetFamilyIPV6;
       
    } /* End if () */
//    else {
//
//       eFamily = NetFamilyOther;
//
//    } /* End else */
   
   __CATCH(nErr);

   return eFamily;
}

+ (NSString *)extractAddress:(struct sockaddr *)aAddress {
   
   int                            nErr                                     = EFAULT;
   
   NSString                      *szAddress                                = nil;
   
   __TRY;
   
   
   if (NULL == aAddress) {
      
      nErr  = EINVAL;
      
      break;
      
   } /* End if () */
      
   if ((sa_family_t)AF_INET == aAddress->sa_family) {
      
      szAddress   = [IDEANetInterface extractAddressIPV4:aAddress];
      
   } /* End if () */
   else if ((sa_family_t)AF_INET6 == aAddress->sa_family) {
      
      szAddress   = [IDEANetInterface extractAddressIPV6:aAddress];
      
   } /* End if () */
   else {
      
   } /* End else */
   
   __CATCH(nErr);
   
   return szAddress;
}

+ (NSString *)extractAddressIPV4:(struct sockaddr *)aAddress {
   
   int                            nErr                                     = EFAULT;
   
   NSString                      *szAddress                                = nil;
   char                           acHostName[NI_MAXHOST]                   = {0};

   __TRY;

//   return address.withMemoryRebound(to: sockaddr.self, capacity: 1) { addr in
//       var address : String? = nil
//       var hostname = [CChar](repeating: 0, count: Int(2049))
//       if (getnameinfo(&addr.pointee, socklen_t(socketLength4(addr.pointee)), &hostname,
//                       socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0) {
//           address = String(cString: hostname)
//       }
//       else {
//           //            var error = String.fromCString(gai_strerror(errno))!
//           //            println("ERROR: \(error)")
//       }
//       return address
//
//   }
   
   nErr  = getnameinfo(aAddress,
                       (socklen_t)aAddress->sa_len,
                       acHostName, sizeof(acHostName),
                       NULL,
                       0,
                       NI_NUMERICHOST);
   if (noErr != nErr) {
      
      break;
      
   } /* End if () */

   szAddress   = [NSString stringWithCString:acHostName encoding:NSUTF8StringEncoding];

   __CATCH(nErr);
   
   return szAddress;
}

+ (NSString *)extractAddressIPV6:(struct sockaddr *)aAddress {
   
   int                            nErr                                     = EFAULT;
   
   NSString                      *szAddress                                = nil;
   char                          *pcAddress                                = nil;
   
//   struct sockaddr               *stAddress                                = aAddress;
   struct sockaddr_in6           *stAddress6                               = aAddress;
   int8_t                         aIP[INET6_ADDRSTRLEN]                    = {0};

   __TRY;

//   var addr = address.pointee
//   var ip : [Int8] = [Int8](repeating: Int8(0), count: Int(INET6_ADDRSTRLEN))
   
//   szAddress   = [IDEANetInterface inetNtoP:aAddress ip: &aIP];
   
   pcAddress   = inet_ntop(AF_INET6, &stAddress6->sin6_addr, aIP, sizeof(aIP));
   if ((NULL == pcAddress) || (0 == strlen(pcAddress))) {
      
      nErr  = ENOSPC;
      
      break;
      
   } /* End if () */
   
//   szAddress   = [NSString stringWithUTF8String:aIP];
   szAddress   = [NSString stringWithCString:aIP encoding:NSUTF8StringEncoding];
   
   __CATCH(nErr);
   
   return szAddress;
}

//+ (NSString *)inetNtoP:(struct sockaddr *)aAddr ip:(int8_t *)aIP {
//
////   return addr.withMemoryRebound(to: sockaddr_in6.self, capacity: 1) { addr6 in
////      let conversion:UnsafePointer<CChar> = inet_ntop(AF_INET6, &addr6.pointee.sin6_addr, ip, socklen_t(INET6_ADDRSTRLEN))
////      return String(cString: conversion)
////   }
//
//   return nil;
//}

+ (NSString *)familyToString:(NetFamily)aNetFamily {
   
//   /// IPv4.
//   NetFamilyIPV4  = 0,
//
//   /// IPv6.
//   NetFamilyIPV6  = 1,
//
//   /// Used in case of errors.
//   NetFamilyOther = 2
   if (NetFamilyIPV4 == aNetFamily) {
      
      return @"IPv4";
      
   } /* End if () */

   if (NetFamilyIPV6 == aNetFamily) {
      
      return @"IPv6";
      
   } /* End if () */

//   if (NetFamilyIPV4 == aNetFamily) {
//
//      return @"IPv4";
//
//   } /* End if () */
   
   return @"N/A";
}

@end
