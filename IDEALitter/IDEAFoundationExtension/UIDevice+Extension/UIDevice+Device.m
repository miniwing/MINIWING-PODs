//
//  UIDevice+Device.m
//  IDEALitter
//
//  Created by Harry on 2021/5/31.
//

#import <sys/utsname.h>
#import <sys/utsname.h>
#import <mach/mach.h>
#import <sys/sysctl.h>
#import <sys/stat.h>

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

#import "UIDevice+Device.h"

#if __has_include(<YYCategories/YYCategories.h>)
#  import <YYCategories/YYCategories.h>
#elif __has_include("YYCategories/YYCategories.h")
#  import "YYCategories/YYCategories.h"
#elif __has_include("YYCategories.h")
#  import "YYCategories.h"
#endif // (__has_include(<YYCategories/YYCategories.h>) || __has_include("YYCategories/YYCategories.h") || __has_include("YYCategories.h"))

@implementation UIDevice (Device)

/**
 获取当前的APP的运行的手机系统版本号
 e.g. @"9.3.5"
 */
+ (NSString *)getOSVersion {
   static NSString         *version;
   static dispatch_once_t   onceToken;
   dispatch_once(&onceToken, ^{
      version  = [[UIDevice currentDevice] systemVersion];
   });
   return version;
}

+ (NSString *)getOSModel {
   static NSString         *szModel;
   static dispatch_once_t   onceToken;
   dispatch_once(&onceToken, ^{
      szModel  = [[UIDevice currentDevice] model];
   });
   return szModel;
}

+ (NSString *)getOSName {
   static NSString         *szName;
   static dispatch_once_t   onceToken;
   dispatch_once(&onceToken, ^{
      szName   = [[UIDevice currentDevice] name];
   });
   return szName;
}

+ (BOOL)isPhone {
#if (__has_include(<YYCategories/YYCategories.h>) || __has_include("YYCategories/YYCategories.h") || __has_include("YYCategories.h"))
   return [UIDevice currentDevice].isPhone;
#else // (__has_include(<YYCategories/YYCategories.h>) || __has_include("YYCategories/YYCategories.h") || __has_include("YYCategories.h"))
   static dispatch_once_t one;
   static BOOL phone;
   dispatch_once(&one, ^{
      phone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
   });
   return phone;
#endif // !((__has_include(<YYCategories/YYCategories.h>) || __has_include("YYCategories/YYCategories.h") || __has_include("YYCategories.h")))
}

+ (BOOL)isPad {
   static dispatch_once_t one;
   static BOOL pad;
   dispatch_once(&one, ^{
      pad   = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
   });
   return pad;
}

+ (BOOL)isIPod {
   return [UIDevice getDeviceType] == CurrentDeviceTypeIPod;
}

+ (CurrentDeviceType)getDeviceType {

   static CurrentDeviceType    eDeviceType;
   static dispatch_once_t      onceToken;
   dispatch_once(&onceToken, ^{

      struct utsname systemInfo;
      uname(&systemInfo);

      NSString *type = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];

      BOOL deviceIsSupport = [UIDevice getOSVersion].doubleValue >= 8.0;
      BOOL isPhone        = deviceIsSupport ? ([type containsString:@"iPhone"])       : ([type rangeOfString:@"iPhone"].location != NSNotFound);
      BOOL isPad          = deviceIsSupport ? ([type containsString:@"iPad"])         : ([type rangeOfString:@"iPad"].location != NSNotFound);
      BOOL isPod          = deviceIsSupport ? ([type containsString:@"iPod"])         : ([type rangeOfString:@"iPod"].location != NSNotFound);

      BOOL isSimulator    = deviceIsSupport ? ([type containsString:@"i386"] || [type containsString:@"x86_64"])  : ([type rangeOfString:@"Simulator"].location != NSNotFound);

      if (isPhone && !isSimulator) {
         eDeviceType = CurrentDeviceTypeIPhone;
      }
      else {
         if (isPhone && isSimulator) {
            eDeviceType = CurrentDeviceTypeIPhoneSimulator;
         }
         else {
            if (isPad) {
               eDeviceType = CurrentDeviceTypeIPad;
            }
            else {
               if (isPod) {
                  eDeviceType = CurrentDeviceTypeIPod;
               }
               else {
                  eDeviceType = CurrentDeviceTypeNone;
               }
            }
         }
      }

   });

   return eDeviceType;
}

//+ (NSString *)getDeviceTypeString {
//
//   static NSString            *szDevice;
//   static dispatch_once_t      onceToken;
//   dispatch_once(&onceToken, ^{
//
//      struct utsname systemInfo;
//      uname(&systemInfo);
//      NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
//      if ([platform isEqualToString:@"iPhone1,1"]) szDevice = @"iPhone 2G";
//      if ([platform isEqualToString:@"iPhone1,2"]) szDevice = @"iPhone 3G";
//      if ([platform isEqualToString:@"iPhone2,1"]) szDevice = @"iPhone 3GS";
//      if ([platform isEqualToString:@"iPhone3,1"]) szDevice = @"iPhone 4";
//      if ([platform isEqualToString:@"iPhone3,2"]) szDevice = @"iPhone 4";
//      if ([platform isEqualToString:@"iPhone3,3"]) szDevice = @"iPhone 4";
//      if ([platform isEqualToString:@"iPhone4,1"]) szDevice = @"iPhone 4S";
//      if ([platform isEqualToString:@"iPhone5,1"]) szDevice = @"iPhone 5";
//      if ([platform isEqualToString:@"iPhone5,2"]) szDevice = @"iPhone 5";
//      if ([platform isEqualToString:@"iPhone5,3"]) szDevice = @"iPhone 5c";
//      if ([platform isEqualToString:@"iPhone5,4"]) szDevice = @"iPhone 5c";
//      if ([platform isEqualToString:@"iPhone6,1"]) szDevice = @"iPhone 5s";
//      if ([platform isEqualToString:@"iPhone6,2"]) szDevice = @"iPhone 5s";
//      if ([platform isEqualToString:@"iPhone7,1"]) szDevice = @"iPhone 6 Plus";
//      if ([platform isEqualToString:@"iPhone7,2"]) szDevice = @"iPhone 6";
//      if ([platform isEqualToString:@"iPhone8,1"]) szDevice = @"iPhone 6s";
//      if ([platform isEqualToString:@"iPhone8,2"]) szDevice = @"iPhone 6s Plus";
//      if ([platform isEqualToString:@"iPhone8,4"]) szDevice = @"iPhone SE";
//      if ([platform isEqualToString:@"iPhone9,1"]) szDevice = @"iPhone 7";
//      if ([platform isEqualToString:@"iPhone9,2"]) szDevice = @"iPhone 7 Plus";
//      if ([platform isEqualToString:@"iPod1,1"])  szDevice = @"iPod Touch 1G";
//      if ([platform isEqualToString:@"iPod2,1"])  szDevice = @"iPod Touch 2G";
//      if ([platform isEqualToString:@"iPod3,1"])  szDevice = @"iPod Touch 3G";
//      if ([platform isEqualToString:@"iPod4,1"])  szDevice = @"iPod Touch 4G";
//      if ([platform isEqualToString:@"iPod5,1"])  szDevice = @"iPod Touch 5G";
//      if ([platform isEqualToString:@"iPad1,1"])  szDevice = @"iPad 1G";
//      if ([platform isEqualToString:@"iPad2,1"])  szDevice = @"iPad 2";
//      if ([platform isEqualToString:@"iPad2,2"])  szDevice = @"iPad 2";
//      if ([platform isEqualToString:@"iPad2,3"])  szDevice = @"iPad 2";
//      if ([platform isEqualToString:@"iPad2,4"])  szDevice = @"iPad 2";
//      if ([platform isEqualToString:@"iPad2,5"])  szDevice = @"iPad Mini 1G";
//      if ([platform isEqualToString:@"iPad2,6"])  szDevice = @"iPad Mini 1G";
//      if ([platform isEqualToString:@"iPad2,7"])  szDevice = @"iPad Mini 1G";
//      if ([platform isEqualToString:@"iPad3,1"])  szDevice = @"iPad 3";
//      if ([platform isEqualToString:@"iPad3,2"])  szDevice = @"iPad 3";
//      if ([platform isEqualToString:@"iPad3,3"])  szDevice = @"iPad 3";
//      if ([platform isEqualToString:@"iPad3,4"])  szDevice = @"iPad 4";
//      if ([platform isEqualToString:@"iPad3,5"])  szDevice = @"iPad 4";
//      if ([platform isEqualToString:@"iPad3,6"])  szDevice = @"iPad 4";
//      if ([platform isEqualToString:@"iPad4,1"])  szDevice = @"iPad Air";
//      if ([platform isEqualToString:@"iPad4,2"])  szDevice = @"iPad Air";
//      if ([platform isEqualToString:@"iPad4,3"])  szDevice = @"iPad Air";
//      if ([platform isEqualToString:@"iPad4,4"])  szDevice = @"iPad Mini 2G";
//      if ([platform isEqualToString:@"iPad4,5"])  szDevice = @"iPad Mini 2G";
//      if ([platform isEqualToString:@"iPad4,6"])  szDevice = @"iPad Mini 2G";
//      if ([platform isEqualToString:@"i386"])     szDevice = @"iPhone Simulator";
//      if ([platform isEqualToString:@"x86_64"])   szDevice = @"iPhone Simulator";
//   });
//
//   return szDevice;
//}

+ (NSString *)getCPUType {
   
   host_basic_info_data_t hostInfo;
   mach_msg_type_number_t infoCount;
   
   infoCount = HOST_BASIC_INFO_COUNT;
   host_info(mach_host_self(), HOST_BASIC_INFO, (host_info_t)&hostInfo, &infoCount);
   
   switch (hostInfo.cpu_type) {
      case CPU_TYPE_ARM:
         return @"CPU_TYPE_ARM";
         break;
         
      case CPU_TYPE_ARM64:
         return @"CPU_TYPE_ARM64";
         break;
         
      case CPU_TYPE_X86:
         return @"CPU_TYPE_X86";
         break;
         
      case CPU_TYPE_X86_64:
         return @"CPU_TYPE_X86_64";
         break;
         
      default:
         return @"";
         break;
   }
}

#pragma mark - 获取运行内存
+ (double)getMemoryMB
{
   vm_statistics_data_t vmStats;
   mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
   kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
   
   if (kernReturn != KERN_SUCCESS)
   {
      return NSNotFound;
   }
   double mem = (vm_page_size * vmStats.free_count) + (vmStats.inactive_count * vm_page_size);
   
   return mem/1024.0/1024.0;
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
