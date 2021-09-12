//
//  LANProperties.m
//
//  Created by Michalis Mavris on 05/08/16.
//  Copyright © 2016 Miksoft. All rights reserved.
//

#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <netdb.h>

#import "NetworkCalculator.h"
#import "LANProperties.h"
#import "MMDevice.h"

@implementation LANProperties

#pragma mark - Public methods
+ (MMDevice *)localIPAddress {
   
   MMDevice    *stLocalDevice = [[MMDevice alloc] init];
   
   stLocalDevice.ipAddress       = @"error";
   
   struct ifaddrs *stInterfaces  = NULL;
   struct ifaddrs *stTempAddr    = NULL;
   
   int             success       = 0;
   
   // retrieve the current interfaces - returns 0 on success
   success = getifaddrs(&stInterfaces);
   
   if (success == 0) {
      
      stTempAddr = stInterfaces;
      
      while (stTempAddr != NULL) {
         
         // check if interface is en0 which is the wifi connection on the iPhone
         if (stTempAddr->ifa_addr->sa_family == AF_INET) {
            
            if([[NSString stringWithUTF8String:stTempAddr->ifa_name] isEqualToString:@"en0"]) {
               
               stLocalDevice.ipAddress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)stTempAddr->ifa_addr)->sin_addr)];
               stLocalDevice.subnetMask= [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)stTempAddr->ifa_netmask)->sin_addr)];
               stLocalDevice.hostname  = [self getHostFromIPAddress:stLocalDevice.ipAddress];
               
            } /* End if () */
            
         } /* End if () */
         
         stTempAddr = stTempAddr->ifa_next;
         
      } /* End while () */
      
   } /* End if () */
   
   freeifaddrs(stInterfaces);
   
   //In case we failed to fetch IP address
   if ([stLocalDevice.ipAddress isEqualToString:@"error"]) {
      
      return nil;
   }
   
   //Mark the device as the local IP
   stLocalDevice.isLocalDevice = YES;
   
   return stLocalDevice;
}

+ (NSString *)fetchSSIDInfo {
   
   NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
   
   NSDictionary *info;
   
   for (NSString *ifnam in ifs) {
      
      info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
      
      if (info && [info count]) {
         
         return [info objectForKey:@"SSID"];
         break;
      }
   }
   
   return @"No WiFi Available";
}
//Getting all the hosts to ping and returns them as array
+ (NSArray *)getAllHostsForIP:(NSString *)aIP andSubnet:(NSString *)aSubnetMask {
   
   return [NetworkCalculator getAllHostsForIP:aIP andSubnet:aSubnetMask];
}

//Not working
#pragma mark - Get Host from IP
+ (NSString *)getHostFromIPAddress:(NSString *)aIP {
   
   struct addrinfo   *stResult   = NULL;
   struct addrinfo    stHints    = {0};
   
   bzero(&stHints, sizeof(stHints));
//   memset(&stHints, 0, sizeof(stHints));
   
   stHints.ai_flags     = AI_NUMERICHOST;
   stHints.ai_family    = PF_UNSPEC;
   stHints.ai_socktype  = SOCK_STREAM;
   stHints.ai_protocol  = 0;
   
   int nErrorStatus = getaddrinfo([aIP cStringUsingEncoding:NSASCIIStringEncoding], NULL, &stHints, &stResult);
   
   if (nErrorStatus != 0) {
      
      return nil;
   }
   
   CFDataRef addressRef = CFDataCreate(NULL, (UInt8 *)stResult->ai_addr, stResult->ai_addrlen);
   if (addressRef == nil) {
      return nil;
   }
   freeaddrinfo(stResult);
   
   CFHostRef hostRef = CFHostCreateWithAddress(kCFAllocatorDefault, addressRef);
   if (hostRef == nil) {
      return nil;
   }
   CFRelease(addressRef);
   
   BOOL succeeded = CFHostStartInfoResolution(hostRef, kCFHostNames, NULL);
   if (!succeeded) {
      return nil;
   }
   
   NSMutableArray *hostnames = [NSMutableArray array];
   
   CFArrayRef hostnamesRef = CFHostGetNames(hostRef, NULL);
   for (int currentIndex = 0; currentIndex < [(__bridge NSArray *)hostnamesRef count]; currentIndex++) {
      [hostnames addObject:[(__bridge NSArray *)hostnamesRef objectAtIndex:currentIndex]];
   }
   
   return hostnames[0];
}

@end
