//
//  UIDevice+Device.m
//  IDEAKit
//
//  Created by PacteraLF on 2017/6/12.
//  Copyright © 2017年 PacteraLF. All rights reserved.
//

#import "IDEAKit/UIDevice+Device.h"
#import <sys/utsname.h>
#import <sys/utsname.h>
#import <mach/mach.h>
#import <sys/sysctl.h>
#import <sys/stat.h>

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

@implementation UIDevice (Device)

+ (NSString *)getOSVersion {
   
   return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)getOSModel{
   
   return [[UIDevice currentDevice] model];
}

+ (NSString *)getOSName {
   
   return [[UIDevice currentDevice] name];
}

+ (NSString *)getSystemBuildVersion {
   
   NSString *szVersion  = [[NSProcessInfo processInfo] operatingSystemVersionString];// Version 12.1 (Build 16B5084a)
   NSArray  *stVersions = [szVersion componentsSeparatedByString:@" "];
   if (stVersions.count > 2) {
       NSString *tempStr = [stVersions objectAtIndex:3];
       NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"()"];
       NSString *build = [tempStr stringByTrimmingCharactersInSet:set];
       return build;
   }
   
   return @"";
}

+ (BOOL)isIPhone {
   
   return [UIDevice getDeviceType] == CurrentDeviceTypeIPhone;
}

+ (BOOL)isIPad {
   
   return [UIDevice getDeviceType] == CurrentDeviceTypeIPad;
}

+ (BOOL)isIPod {
   
   return [UIDevice getDeviceType] == CurrentDeviceTypeIPod;
}


+ (CurrentDeviceType)getDeviceType {
   
   NSString    *type    = [UIDevice getDeviceTypeString];
   
   BOOL deviceIsSupport = [UIDevice getOSVersion].doubleValue >= 8.0;
   BOOL isPhone         = deviceIsSupport ? ([type containsString:@"iPhone"])    : ([type rangeOfString:@"iPhone"].location != NSNotFound);
   BOOL isSimulator     = deviceIsSupport ? ([type containsString:@"Simulator"]) : ([type rangeOfString:@"Simulator"].location != NSNotFound);
   BOOL isPad           = deviceIsSupport ? ([type containsString:@"iPad"])      : ([type rangeOfString:@"iPad"].location != NSNotFound);
   BOOL isPod           = deviceIsSupport ? ([type containsString:@"iPod"])      : ([type rangeOfString:@"iPod"].location != NSNotFound);
   
   if (isPhone && !isSimulator) {
      
      return CurrentDeviceTypeIPhone;
   }
   else {
      
      if (isPhone && isSimulator) {
         
         return CurrentDeviceTypeIPhoneSimulator;
      }
      else {
         
         if (isPad) {
            
            return CurrentDeviceTypeIPad;
         }
         else {
            
            if (isPod) {
               
               return CurrentDeviceTypeIPod;
            }
            else {
               
               return CurrentDeviceTypeNone;
            }
         }
      }
   }
}

+ (NSString *)getDeviceTypeString {
   
   struct utsname  systemInfo = {0};
   
   uname(&systemInfo);
   
   NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
   
   if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
   if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
   if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
   if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
   if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
   if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
   if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
   if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
   if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
   if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
   if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
   if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
   if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
   if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
   if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
   if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
   if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
   if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
   if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
   if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
   if ([platform isEqualToString:@"iPod1,1"])  return @"iPod Touch 1G";
   if ([platform isEqualToString:@"iPod2,1"])  return @"iPod Touch 2G";
   if ([platform isEqualToString:@"iPod3,1"])  return @"iPod Touch 3G";
   if ([platform isEqualToString:@"iPod4,1"])  return @"iPod Touch 4G";
   if ([platform isEqualToString:@"iPod5,1"])  return @"iPod Touch 5G";
   if ([platform isEqualToString:@"iPad1,1"])  return @"iPad 1G";
   if ([platform isEqualToString:@"iPad2,1"])  return @"iPad 2";
   if ([platform isEqualToString:@"iPad2,2"])  return @"iPad 2";
   if ([platform isEqualToString:@"iPad2,3"])  return @"iPad 2";
   if ([platform isEqualToString:@"iPad2,4"])  return @"iPad 2";
   if ([platform isEqualToString:@"iPad2,5"])  return @"iPad Mini 1G";
   if ([platform isEqualToString:@"iPad2,6"])  return @"iPad Mini 1G";
   if ([platform isEqualToString:@"iPad2,7"])  return @"iPad Mini 1G";
   if ([platform isEqualToString:@"iPad3,1"])  return @"iPad 3";
   if ([platform isEqualToString:@"iPad3,2"])  return @"iPad 3";
   if ([platform isEqualToString:@"iPad3,3"])  return @"iPad 3";
   if ([platform isEqualToString:@"iPad3,4"])  return @"iPad 4";
   if ([platform isEqualToString:@"iPad3,5"])  return @"iPad 4";
   if ([platform isEqualToString:@"iPad3,6"])  return @"iPad 4";
   if ([platform isEqualToString:@"iPad4,1"])  return @"iPad Air";
   if ([platform isEqualToString:@"iPad4,2"])  return @"iPad Air";
   if ([platform isEqualToString:@"iPad4,3"])  return @"iPad Air";
   if ([platform isEqualToString:@"iPad4,4"])  return @"iPad Mini 2G";
   if ([platform isEqualToString:@"iPad4,5"])  return @"iPad Mini 2G";
   if ([platform isEqualToString:@"iPad4,6"])  return @"iPad Mini 2G";
   if ([platform isEqualToString:@"i386"])     return @"iPhone Simulator";
   if ([platform isEqualToString:@"x86_64"])   return @"iPhone Simulator";
   return platform;
}

+ (NSString *)getCPUType {
   
   host_basic_info_data_t   hostInfo   = {0};
   mach_msg_type_number_t   infoCount  = HOST_BASIC_INFO_COUNT;
   
   //   infoCount = HOST_BASIC_INFO_COUNT;
   
   host_info(mach_host_self(), HOST_BASIC_INFO, (host_info_t)&hostInfo, &infoCount);
   
   switch (hostInfo.cpu_type) {
      case CPU_TYPE_ARM:
         return @"CPU_TYPE_ARM";
         //      break;
         
      case CPU_TYPE_ARM64:
         return @"CPU_TYPE_ARM64";
         //      break;
         
      case CPU_TYPE_X86:
         return @"CPU_TYPE_X86";
         //      break;
         
      case CPU_TYPE_X86_64:
         return @"CPU_TYPE_X86_64";
         //      break;
         
      default:
         return @"";
         //      break;
   }
}

#pragma mark - 获取运行内存
+ (double)getMemoryMB {
   
   vm_statistics_data_t     stVMStats  = {0};
   mach_msg_type_number_t   infoCount  = HOST_VM_INFO_COUNT;
   kern_return_t            kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&stVMStats, &infoCount);
   
   if (kernReturn != KERN_SUCCESS) {
      
      return NSNotFound;
   }
   
   double mem = (vm_page_size * stVMStats.free_count) + (stVMStats.inactive_count * vm_page_size);
   
   return mem / 1024.0 / 1024.0;
}

//+ (BOOL)isPad {
//    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
//        case UIUserInterfaceIdiomPad:
//            return YES;
//            break;
//        default:
//            return NO;
//            break;
//    }
//}

+ (BOOL)isiPhoneX {
   
   if(@available(iOS 11.0, *)) {
      
      if ([UIApplication respondsToSelector:@selector(sharedApplication)]) {
         
         UIApplication  *stApplication = [UIApplication performSelector:@selector(sharedApplication)];
         
         return stApplication.delegate.window.safeAreaInsets.bottom > 0;
         
      } /* End if () */
      
      return NO;
   }
   else {
      return NO;
   }
}

@end
