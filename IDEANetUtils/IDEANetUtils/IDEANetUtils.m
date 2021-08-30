//
//  NetInterface.m
//  IDEANetUtils
//
//  Created by Harry on 2021/8/2.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEANetUtils/IDEANetUtils.h"

@interface IDEANetUtils ()

@end

@implementation IDEANetUtils

+ (NSArray<IDEANetInterface *> *)allInterfaces {
   
   int                            nErr                                     = EFAULT;
   
   NSMutableArray<IDEANetInterface *>  *stInterfaces                       = nil;
   struct ifaddrs                *pstIfaddrs                               = NULL;
   struct sockaddr               *pstAddr                                  = NULL;
   
   __TRY;
   
   stInterfaces   = [NSMutableArray<IDEANetInterface *> array];
   
   nErr  = getifaddrs(&pstIfaddrs);
   if (noErr != nErr) {
      
      break;
      
   } /* End if () */
   
   for (struct ifaddrs *pstIfAddrTemp = pstIfaddrs; NULL != pstIfAddrTemp; pstIfAddrTemp = pstIfAddrTemp->ifa_next) {
      
      pstAddr  = pstIfAddrTemp->ifa_addr;
      
      if ((AF_INET == pstAddr->sa_family) || (AF_INET6 == pstAddr->sa_family)) {
         
         [stInterfaces addObject:[IDEANetInterface interfaceWithIfAddrs:pstIfAddrTemp]];
         
//         interfaces.append(Interface(data: (ifaddrPtr?.pointee)!))
         
      } /* End if () */
      
   } /* End for () */
   
   __CATCH(nErr);
   
   if (NULL != pstIfaddrs) {
      
      freeifaddrs(pstIfaddrs);
      
   } /* End if () */
   
   return stInterfaces;
}

@end
