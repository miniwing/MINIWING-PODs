#
# Be sure to run `pod lib lint IDEAPopController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
  spec.name             = 'IDEAPopController'
  spec.version          = '1.0.6'
  spec.summary          = 'IDEAPopController pop up in ViewController with some animations.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  spec.description                  = <<-DESC
                                      Use ViewController to present IDEAPopController like pop up style.
                                      Support multiple Animations.
                                      DESC

  spec.homepage                     = 'https://github.com/miniwing'
#  spec.license                      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author                       = { 'Harry' => 'miniwing@gmail.com' }
  spec.source                       = { :path => "." }

  spec.ios.deployment_target        = '10.0'
  spec.watchos.deployment_target    = '4.3'
    
  spec.osx.deployment_target        = '10.10'
  spec.tvos.deployment_target       = '10.0'

  spec.ios.pod_target_xcconfig      = {
                                        'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEAPopController',
                                        'ENABLE_BITCODE'            => 'NO',
                                        'SWIFT_VERSION'             => '5.0',
                                        'EMBEDDED_CONTENT_CONTAINS_SWIFT'       => 'NO',
                                        'ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES' => 'NO',
                                        'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
                                      }
  spec.osx.pod_target_xcconfig      = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEAPopController' }
  spec.watchos.pod_target_xcconfig  = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEAPopController-watchOS' }
  spec.tvos.pod_target_xcconfig     = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEAPopController' }
  
  spec.frameworks                   = ['Foundation', 'UIKit', 'CoreGraphics', 'QuartzCore', 'CoreFoundation']
    
  spec.xcconfig                     = {
    'HEADER_SEARCH_PATHS'               => [
                                            "${PODS_TARGET_SRCROOT}/",
                                            "${PODS_TARGET_SRCROOT}/../",
                                            "${PODS_ROOT}/MaterialComponents/**",
                                            "${PODS_ROOT}/IDEAKit/**",
                                            "${PODS_ROOT}/IDEAUIKit/**",
                                            "${PODS_ROOT}/IDEAColor/**",
                                            "${PODS_ROOT}/Headers/Public/MaterialComponents",
                                            "${PODS_ROOT}/Headers/Public/FoundationExtension/",
                                            "${PODS_ROOT}/Headers/Public/UIKitExtension/",
                                            "${PODS_ROOT}/Headers/Public/YYKit/",
                                            "${PODS_ROOT}/Headers/Public/AFNetworking",
                                            "${PODS_ROOT}/Headers/Public/IDEAKit/",
                                            "${PODS_ROOT}/Headers/Public/IDEAColor",
                                            ],
  'FRAMEWORK_SEARCH_PATHS'              =>  [
                                              "${PODS_CONFIGURATION_BUILD_DIR}/MaterialComponents",
                                              "${PODS_CONFIGURATION_BUILD_DIR}/FoundationExtension",
                                              "${PODS_CONFIGURATION_BUILD_DIR}/UIKitExtension",
                                              "${PODS_CONFIGURATION_BUILD_DIR}/AFNetworking",
                                              "${PODS_CONFIGURATION_BUILD_DIR}/YYKit",
                                              "${PODS_CONFIGURATION_BUILD_DIR}/IDEAKit",
                                              "${PODS_CONFIGURATION_BUILD_DIR}/IDEAUIKit",
                                              "${PODS_CONFIGURATION_BUILD_DIR}/IDEAColor",
                                            ]
                                      }

  spec.pod_target_xcconfig          = {
    'GCC_PREPROCESSOR_DEFINITIONS'      => [ ' MODULE=\"IDEAPopController\" ' ]
                                      }

#  spec.dependency 'YYKit'

  spec.public_header_files        = 'IDEAPopUp.h',
                                    'IDEAPopController/**/*.{h}',
                                    'IDEAPopController/Animator/**/*.{h}',
                                    'IDEAPopController/Controller/**/*.{h}',
                                    'IDEAPopController/TransitioningDelegate/**/*.{h}',

  spec.source_files               = 'IDEAPopUp.h',
                                    'IDEAPopController/**/*.{h,m,mm,c,cpp}'

   pch_app_kit = <<-EOS
#ifdef DEBUG
#  pragma clang diagnostic ignored                 "-Wgnu"
#  pragma clang diagnostic ignored                 "-Wcomma"
#  pragma clang diagnostic ignored                 "-Wformat"
#  pragma clang diagnostic ignored                 "-Wswitch"
#  pragma clang diagnostic ignored                 "-Wvarargs"
#  pragma clang diagnostic ignored                 "-Wnonnull"
#  pragma clang diagnostic ignored                 "-Wpointer-sign"
#  pragma clang diagnostic ignored                 "-Wdangling-else"
#  pragma clang diagnostic ignored                 "-Wunused-result"
#  pragma clang diagnostic ignored                 "-Wuninitialized"
#  pragma clang diagnostic ignored                 "-Wdocumentation"
#  pragma clang diagnostic ignored                 "-Wpch-date-time"
#  pragma clang diagnostic ignored                 "-Wenum-conversion"
#  pragma clang diagnostic ignored                 "-Wunused-variable"
#  pragma clang diagnostic ignored                 "-Wunused-function"
#  pragma clang diagnostic ignored                 "-Wmissing-noescape"
#  pragma clang diagnostic ignored                 "-Wwritable-strings"
#  pragma clang diagnostic ignored                 "-Wunreachable-code"
#  pragma clang diagnostic ignored                 "-Wshorten-64-to-32"
#  pragma clang diagnostic ignored                 "-Wwritable-strings"
#  pragma clang diagnostic ignored                 "-Wstrict-prototypes"
#  pragma clang diagnostic ignored                 "-Wdocumentation-html"
#  pragma clang diagnostic ignored                 "-Wobjc-method-access"
#  pragma clang diagnostic ignored                 "-Wundeclared-selector"
#  pragma clang diagnostic ignored                 "-Wimplicit-retain-self"
#  pragma clang diagnostic ignored                 "-Wunguarded-availability"
#  pragma clang diagnostic ignored                 "-Wunknown-warning-option"
#  pragma clang diagnostic ignored                 "-Wlogical-op-parentheses"
#  pragma clang diagnostic ignored                 "-Wlogical-not-parentheses"
#  pragma clang diagnostic ignored                 "-Wdeprecated-declarations"
#  pragma clang diagnostic ignored                 "-Wnullability-completeness"
#  pragma clang diagnostic ignored                 "-Wobjc-missing-super-calls"
#  pragma clang diagnostic ignored                 "-Wnonportable-include-path"
#  pragma clang diagnostic ignored                 "-Wconditional-uninitialized"
#  pragma clang diagnostic ignored                 "-Wincompatible-pointer-types"
#  pragma clang diagnostic ignored                 "-Wdeprecated-implementations"
#  pragma clang diagnostic ignored                 "-Wmismatched-parameter-types"
#  pragma clang diagnostic ignored                 "-Wobjc-redundant-literal-use"
#  pragma clang diagnostic ignored                 "-Wno-nullability-completeness"
#  pragma clang diagnostic ignored                 "-Wblock-capture-autoreleasing"
#  pragma clang diagnostic ignored                 "-Wtautological-pointer-compare"
#  pragma clang diagnostic ignored                 "-Wimplicit-function-declaration"
#  pragma clang diagnostic ignored                 "-Wquoted-include-in-framework-header"
#  pragma clang diagnostic ignored                 "-Wnullability-completeness-on-arrays"
#endif /* DEBUG */

#import <Availability.h>

#ifndef __IPHONE_10_0
#  warning "This project uses features only available in iOS SDK 10.0 and later."
#endif

#import <objc/message.h>
#import <objc/runtime.h>

#ifdef __OBJC__

#  import <UIKit/UIKit.h>
#  import <Foundation/Foundation.h>
#  import <QuartzCore/QuartzCore.h>
#  import <QuartzCore/CAAnimation.h>
#  import <MessageUI/MessageUI.h>

#endif /* __OBJC__ */

#import <objc/message.h>
#import <objc/runtime.h>

#ifdef __OBJC__

#  if __has_include(<RTRootNavigationController/RTRootNavigationController.h>)
#     import <RTRootNavigationController/RTRootNavigationController.h>
#     define RT_ROOT_NAVIGATIONCONTROLLER                                  (1)
#  elif __has_include("RTRootNavigationController/RTRootNavigationController.h")
#     import "RTRootNavigationController/RTRootNavigationController.h"
#     define RT_ROOT_NAVIGATIONCONTROLLER                                  (1)
#  elif __has_include("RTRootNavigationController.h")
#     import "RTRootNavigationController.h"
#     define RT_ROOT_NAVIGATIONCONTROLLER                                  (1)
#  else
#     define RT_ROOT_NAVIGATIONCONTROLLER                                  (0)
#  endif

//#  if (__has_include(<MaterialComponents/MaterialAppBar.h>))
//#     import <MaterialComponents/MDCAvailability.h>
//#     import <MaterialComponents/MaterialAppBar.h>
//#     define MATERIAL_APP_BAR                                              (1)
//#  elif (__has_include("MaterialComponents/MaterialAppBar.h"))
//#     import "MaterialComponents/MDCAvailability.h"
//#     import "MaterialComponents/MaterialAppBar.h"
//#     define MATERIAL_APP_BAR                                              (1)
//#  elif (__has_include("MaterialAppBar.h"))
//#     import "MDCAvailability.h"
//#     import "MaterialAppBar.h"
//#     define MATERIAL_APP_BAR                                              (1)
//#  else
//#     define MATERIAL_APP_BAR                                              (0)
//#  endif

#  if __has_include(<IDEANightVersion/DKNightVersion.h>)
#     import <IDEANightVersion/DKNightVersion.h>
#     define IDEA_NIGHT_VERSION_MANAGER                                    (1)
#  elif __has_include("IDEANightVersion/DKNightVersion.h")
#     import "IDEANightVersion/DKNightVersion.h"
#     define IDEA_NIGHT_VERSION_MANAGER                                    (1)
#  elif __has_include("DKNightVersion.h")
#     import "DKNightVersion.h"
#     define IDEA_NIGHT_VERSION_MANAGER                                    (1)
#  else
#     define IDEA_NIGHT_VERSION_MANAGER                                    (0)
#  endif

#  if __has_include(<IDEAFONT/IDEAFONT.h>)
#     define IDEA_FONT                                                     (1)
#     import <IDEAFONT/IDEAFONT.h>
#  elif __has_include("IDEAFONT/IDEAFONT.h")
#     define IDEA_FONT                                                     (1)
#     import "IDEAFONT/IDEAFONT.h"
#  elif __has_include("IDEAFONT.h")
#     define IDEA_FONT                                                     (1)
#     import "IDEAFONT.h"
#  else
#     define IDEA_FONT                                                     (0)
#  endif

#  if __has_include(<YYKit/YYKit.h>)
#     import <YYKit/YYKit.h>
#     define YY_KIT                                                        (1)
#  elif __has_include("YYKit/YYKit.h")
#     import "YYKit/YYKit.h"
#     define YY_KIT                                                        (1)
#  elif __has_include("YYKit.h")
#     import "YYKit.h"
#     define YY_KIT                                                        (1)
#  else
#     define YY_KIT                                                        (0)
#  endif

#endif /* __OBJC__ */

/******************************************************************************************************/

#if __has_feature(objc_arc)
#  define __AUTORELEASE(x)                         (x);
#  define __RELEASE(x)                             (x) = nil;
#  define __RETAIN(x)                              (x)
#  define __SUPER_DEALLOC                          objc_removeAssociatedObjects(self);
#  define __dispatch_release(x)                    (x) = nil;
#else
#  define __RETAIN(x)                              [(x) retain];
#  define __AUTORELEASE(x)                         [(x) autorelease];
#  define __RELEASE(x)                             if (nil != (x)) {                               \\
                                                      [(x) release];                               \\
                                                      (x) = nil;                                   \\
                                                   }
#  define __SUPER_DEALLOC                          objc_removeAssociatedObjects(self);[super dealloc];
#  define __dispatch_release(x)                    dispatch_release((x))
#endif

/******************************************************************************************************/

#define __ON__                                     (1)
#define __OFF__                                    (0)

#if (defined(DEBUG) && (1==DEBUG))
#  define __AUTO__                                 (1)
#  define __Debug__                                (1)
#else
#  define __AUTO__                                 (0)
#  define __Debug__                                (0)
#endif

/******************************************************************************************************/

#define LOG_BUG_SIZE                               (1024 * 1)

enum {
  
  __LogLevelFatal   = 0,
  __LogLevelError,
  __LogLevelWarn,
  __LogLevelInfo,
  __LogLevelDebug

};

#ifdef __OBJC__

NS_INLINE const char* ____LogLevelToString(int _eLevel) {
  
   switch (_eLevel) {
     
      case __LogLevelFatal:
         return ("Fatal");
      case __LogLevelError:
         return ("Error");
      case __LogLevelWarn:
         return (" Warn");
      case __LogLevelInfo:
         return (" Info");
      case __LogLevelDebug:
         return ("Debug");
      default:
         break;
         
   } /* End switch (); */
   
   return ("Unknown");
}

NS_INLINE void ____Log(int _eLevel, const char *_cpszMsg) {
  
  printf("[%s] %s :: %s\\n", MODULE, ____LogLevelToString(_eLevel), _cpszMsg);
   
   return;
}

NS_INLINE void __LoggerFatal(NSString *aFormat, ...) {
  
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   ____Log(__LogLevelFatal, [szMSG UTF8String]);
   
   __RELEASE(szMSG);
   
   return;
}

NS_INLINE void __LoggerError(NSString *aFormat, ...) {
  
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   ____Log(__LogLevelError, [szMSG UTF8String]);
   
   __RELEASE(szMSG);
   
   return;
}

NS_INLINE void __LoggerWarn(NSString *aFormat, ...) {
  
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   ____Log(__LogLevelWarn, [szMSG UTF8String]);
   
   __RELEASE(szMSG);
   
   return;
}

NS_INLINE void __LoggerInfo(NSString *aFormat, ...) {
  
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   ____Log(__LogLevelInfo, [szMSG UTF8String]);
   
   __RELEASE(szMSG);
   
   return;
}

NS_INLINE void __LoggerDebug(NSString *aFormat, ...) {
  
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   ____Log(__LogLevelDebug, [szMSG UTF8String]);
   
   __RELEASE(szMSG);
   
   return;
}

#else

__BEGIN_DECLS

static __inline void __LoggerFatal(char *_Format, ...) {
  
   va_list      args;
   static char s_MSG[LOG_BUG_SIZE]  = {0};
   
   bzero(s_MSG, sizeof(s_MSG));
   
   va_start (args, _Format);
   vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
   va_end (args);
   
   printf("[%s] %s :: %s\\n", MODULE, "Fatal", s_MSG);
   
   return;
}

static __inline void __LoggerError(char *_Format, ...) {
  
   va_list      args;
   static char s_MSG[LOG_BUG_SIZE]  = {0};
   
   bzero(s_MSG, sizeof(s_MSG));
   
   va_start (args, _Format);
   vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
   va_end (args);
   
   printf("[%s] %s :: %s\\n", MODULE, "Error", s_MSG);
   
   return;
}

static __inline void __LoggerWarn(char *_Format, ...) {
  
   va_list      args;
   static char s_MSG[LOG_BUG_SIZE]  = {0};
   
   bzero(s_MSG, sizeof(s_MSG));
   
   va_start (args, _Format);
   vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
   va_end (args);
   
   printf("[%s] %s :: %s\\n", MODULE, "Warning", s_MSG);
   
   return;
}

static __inline void __LoggerInfo(char *_Format, ...) {
  
   va_list      args;
   static char s_MSG[LOG_BUG_SIZE]  = {0};
   
   bzero(s_MSG, sizeof(s_MSG));
   
   va_start (args, _Format);
   vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
   va_end (args);
   
   printf("[%s] %s :: %s\\n", MODULE, "Info", s_MSG);
   
   return;
}

static __inline void __LoggerDebug(char *_Format, ...) {
  
   va_list      args;
   static char s_MSG[LOG_BUG_SIZE]  = {0};
   
   bzero(s_MSG, sizeof(s_MSG));
   
   va_start (args, _Format);
   vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
   va_end (args);
   
   printf("[%s] %s :: %s\\n", MODULE, "Debug", s_MSG);
   
   return;
}

__END_DECLS

#endif /* !__OBJC__ */

/******************************************************************************************************/

#define IsInvalid                                  (YES)

#define I_FUNCTION                                 __PRETTY_FUNCTION__

#ifndef __STRING
#  define __STRING(STR)                            (#STR)
#endif /* __STRING */

#ifndef FREE_IF
#  define FREE_IF(p)                               if(p) {free (p); (p)=NULL;}
#endif /* DELETE_IF */

/******************************************************************************************************/

#define __DebugFunc__                              (__AUTO__)
#define __DebugDebug__                             (__AUTO__)
#define __DebugWarn__                              (__AUTO__)
#define __DebugError__                             (__AUTO__)
#define __DebugColor__                             (__AUTO__)
#define __DebugView__                              (__AUTO__)

/******************************************************************************************************/

#if __DebugDebug__
#  define LogDebug(x)                              ____LoggerDebug x
#else
#  define LogDebug(x)
#endif

#if __DebugWarn__
#  define LogWarn(x)                               ____LoggerWarn x
#else
#  define LogWarn(x)
#endif

#if __DebugError__
#  define LogError(x)                              ____LoggerError x
#else
#  define LogError(x)
#endif

#if __DebugFunc__
#  define LogFunc(x)                               ____LoggerInfo x
#else
#  define LogFunc(x)
#endif

#if __DebugView__
#  define LogView(x)                               ____LoggerInfo x
#else
#  define LogView(x)
#endif

/******************************************************************************************************/

#define  __Function_Start()                        LogFunc(((@"%s - Enter!") , I_FUNCTION));
#define  __Function_End(_Return)                                                                                              \\
                                                   {                                                                          \\
                                                      if (noErr == (_Return))                                                 \\
                                                      {                                                                       \\
                                                         LogFunc(((@"%s - Leave with Success!"), I_FUNCTION));                \\
                                                      } /*End if () */                                                        \\
                                                      else                                                                    \\
                                                      {                                                                       \\
                                                         LogFunc(((@"%s - Leave with Error : %d(0x%08x)!"), I_FUNCTION, (int)_Return, (int)_Return));\\
                                                      } /*End else () */                                                      \\
                                                   }

#if (__DebugFunc__)
#  define FunctionStart                            __Function_Start
#  define FunctionEnd                              __Function_End
#else /* (__DebugFunc__) */
#  define FunctionStart()
#  define FunctionEnd(x)
#endif /* (!__DebugFunc__) */

#define __TRY                                      FunctionStart();                                                           \\
                                                   do {

#define __CATCH(nErr)                                 nErr = noErr;                                                           \\
                                                   } while (0);                                                               \\
                                                   FunctionEnd(nErr);

#define __LOG_FUNCTION                             LogFunc((@"%s :", __PRETTY_FUNCTION__))

#define __LOG_RECT(rc)                             LogDebug((@"%s : RECT : (%d, %d, %d, %d)", __STRING(rc), (int)((rc).origin.x), (int)((rc).origin.y), (int)((rc).size.width), (int)((rc).size.height)))
#define __LOG_SIZE(sz)                             LogDebug((@"%s : SIZE : (%d, %d)", __STRING(sz), (int)((sz).width), (int)((sz).height)))
#define __LOG_POINT(pt)                            LogDebug((@"%s : POINT: (%d, %d)", __STRING(pt), (int)((pt).x), (int)((pt).y)))

/******************************************************************************************************/

#ifndef __DUMMY_CLASS
# define __DUMMY_CLASS(_name_)                     @interface __DUMMY_CLASS_ ## _name_ : NSObject                             \\
                                                   @end                                                                       \\
                                                   @implementation __DUMMY_CLASS_ ## _name_                                   \\
                                                   @end
#endif

/******************************************************************************************************/

#define __AVAILABLE_SDK_IOS(_ios)                  ((__IPHONE_##_ios != 0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_##_ios))

/******************************************************************************************************/

// #import <IDEAKit/IDEAKit.h>
// #import <IDEAKit/UIDevice+Device.h>
// #import <IDEAKit/NSObject+Notification.h>

// #import <IDEAColor/IDEAColor.h>
// #import <IDEAColor/UIColor+System.h>
// #import <IDEAColor/UIColor+Dynamic.h>

// #import <IDEAUIKit/IDEAUIKit.h>

  EOS
  spec.prefix_header_contents = pch_app_kit

end
