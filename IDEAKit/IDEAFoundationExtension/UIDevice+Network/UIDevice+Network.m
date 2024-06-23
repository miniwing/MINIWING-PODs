//
//  UIDevice+Network.m
//  IDEAKit
//
//  Created by Harry on 2021/7/31.
//  Copyright © 2024 Harry. All rights reserved.
//

#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

#import "UIDevice+Network.h"

@implementation UIDevice (Network)

+ (NSDictionary<NSString *, NSString *> *)radioTechnology {
   
   static NSDictionary<NSString *, NSString *>  *g_RADIO_TECHNOLOGY  = nil;
   static dispatch_once_t                        onceToken;
   dispatch_once(&onceToken, ^{
      g_RADIO_TECHNOLOGY   = @{
         @"CTRadioAccessTechnologyCDMA1x"  : @"CDMA1x" ,
         @"CTRadioAccessTechnologyEdge"    : @"Edge"   ,
         @"CTRadioAccessTechnologyGPRS"    : @"GPRS"   ,
         @"CTRadioAccessTechnologyHSDPA"   : @"HSDPA"  ,
         @"CTRadioAccessTechnologyHSUPA"   : @"HSUPA"  ,
         @"CTRadioAccessTechnologyLTE"     : @"LTE"    ,
         @"CTRadioAccessTechnologyWCDMA"   : @"WCDMA"  ,
         @"CTRadioAccessTechnologyeHRPD"   : @"eHRDP"  ,
         @"N/A"                            : @"N/A"
      };
   });
   return g_RADIO_TECHNOLOGY;
}

+ (NSString *)radioTechnologyFor:(NSString *)aKey {

   return [UIDevice radioTechnology][aKey];
}

+ (NSString *)networkName:(Network)aNetwork {
   
//   NetworkWifi       = 0,
//   NetworkCellular   = 1

   if (NetworkWifi == aNetwork) {
      
      return @"en0";
      
   } /* End if () */
   
   return @"pdp_ip0";
}

+ (NSString *)ipv4:(Network)aNetwork {
   
   return [UIDevice addressForFamily:AF_INET network:aNetwork];
}

+ (NSString *)ipv6:(Network)aNetwork {
   
   return [UIDevice addressForFamily:AF_INET6 network:aNetwork];
}

+ (NSString *)addressForFamily:(int32_t)aFamily network:(Network)aNetwork {
   
   int                            nErr                                     = EFAULT;
   
   NSString                      *szAddress                                = nil;
   
   NSString                      *szNetwork                                = nil;
   struct ifaddrs                *pstIfaddrs                               = NULL;
   char                           acHostName[NI_MAXHOST]                   = {0};
   
   __TRY;

   nErr  = getifaddrs(&pstIfaddrs);
   if (noErr != nErr) {
      
      break;
      
   } /* End if () */
   
   szNetwork   = [UIDevice networkName:aNetwork];
   LogDebug((@"+[UIDevice addressForFamily:network:] : networkName : %@", szNetwork));

   for (struct ifaddrs *pstIfAddrTemp = pstIfaddrs; NULL != pstIfAddrTemp; pstIfAddrTemp = pstIfAddrTemp->ifa_next) {
      
//      if(pstIfAddrTemp->ifa_addr->sa_family == (uint8_t)aFamily) {
//
//         pvAddrTemp = &((struct sockaddr_in *)pstIfAddrTemp->ifa_addr)->sin_addr;
//
//      } /* End if () */
//      else {
//
//         pvAddrTemp = &((struct sockaddr_in6 *)pstIfAddrTemp->ifa_addr)->sin6_addr;
//
//      } /* End else */

      LogDebug((@"+[UIDevice addressForFamily:network:] : ifa_name  : %s", pstIfAddrTemp->ifa_name));
      LogDebug((@"+[UIDevice addressForFamily:network:] : sa_family : %d", pstIfAddrTemp->ifa_addr->sa_family));

      if (pstIfAddrTemp->ifa_addr->sa_family == (uint8_t)aFamily) {
         
         LogDebug((@"+[UIDevice addressForFamily:network:] : ifa_name : %@", @(pstIfAddrTemp->ifa_name)));

         if ([szNetwork isEqualToString:@(pstIfAddrTemp->ifa_name)]) {
            
            nErr  = getnameinfo(pstIfAddrTemp->ifa_addr,
                        pstIfAddrTemp->ifa_addr->sa_len,
                        acHostName,
                        sizeof(acHostName),
                        NULL,
                        0,
                        NI_NUMERICHOST);
            if (noErr != nErr) {
               
               continue;
               
            } /* End if () */
            
            szAddress   = [NSString stringWithUTF8String:acHostName];

            if (NO == kStringIsEmpty(szAddress)) {
               
               break;
               
            } /* End if () */
            
            continue;

         } /* End if () */
         
      } /* End if () */

   } /* End for () */
   
   __CATCH(nErr);
   
   if (nil != pstIfaddrs) {
      
      freeifaddrs(pstIfaddrs);
      
   } /* End if () */
   
   return szAddress;
}

@end
