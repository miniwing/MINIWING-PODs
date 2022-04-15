Pod::Spec.new do |spec|
  spec.name         = 'IDEASearchController'
  spec.version      = '0.9.1'
  spec.summary      = 'An elegant search controller which replaces the UISearchController for iOS.'
  spec.homepage     = 'https://github.com/ko1o/PYSearch'
  spec.license      = 'MIT'
  spec.authors      = {'CoderKo1o' => '499491531@qq.com'}
  spec.platform     = :ios, '10.0'
#  spec.source       = {:git => 'https://github.com/ko1o/PYSearch.git', :tag => spec.version}
  spec.source       = { :path => "." }
  
  spec.requires_arc = true
  
  spec.ios.pod_target_xcconfig      = {
                                      'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.SearchController',
                                      'ENABLE_BITCODE'            => 'NO',
                                      'SWIFT_VERSION'             => '5.0',
                                      'EMBEDDED_CONTENT_CONTAINS_SWIFT'       => 'NO',
                                      'ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES' => 'NO',
                                      'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
                                      }
  spec.osx.pod_target_xcconfig      = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.SearchController' }
  spec.watchos.pod_target_xcconfig  = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.SearchController-watchOS' }
  spec.tvos.pod_target_xcconfig     = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.SearchController' }
    
  spec.xcconfig                     = {
    'HEADER_SEARCH_PATHS'               => [
                                            "${PODS_TARGET_SRCROOT}/",
                                            "${PODS_TARGET_SRCROOT}/../",
                                            "${PODS_ROOT}/Headers/Public/YYKit/",
                                            "${PODS_ROOT}/Headers/Public/IDEAKit/",
                                            "${PODS_ROOT}/Headers/Public/IDEAUIKit/",
                                            "${PODS_ROOT}/Headers/Public/IDEAUIVendor/",
                                            "${PODS_ROOT}/Headers/Public/IDEAFONT/",
                                            "${PODS_ROOT}/Headers/Public/IDEAColor/",
                                            "${PODS_ROOT}/Headers/Public/IDEANightVersion"
                                           ]
                                      }

  spec.pod_target_xcconfig          = {
    'GCC_PREPROCESSOR_DEFINITIONS'      => [ ' MODULE=\"IDEASearchController\" ', ' BUNDLE=\"IDEASearchController\" ' ]
                                      }

  spec.dependency  'FoundationExtension'
  spec.dependency  'UIKitExtension'
#  spec.dependency  'MaterialComponents'

  spec.dependency  'IDEAKit'
  spec.dependency  'IDEAUIKit'
  spec.dependency  'IDEAUIVendor'
  spec.dependency  'IDEAColor'
  spec.dependency  'IDEANightVersion'

  spec.source_files         = 'IDEASearchController/**/*.{h,m}'

  spec.resource_bundles     = {
                                'IDEASearch' => [
                                                  'IDEASearchController/**/*.lproj',
                                                  'IDEASearchController/**/*.xcassets'
                                                ]
                              }

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

#  if __has_include(<FoundationExtension/FoundationExtension.h>)
#     define FOUNDATION_EXTENSION                                          (1)
#     import <FoundationExtension/FoundationExtension.h>
#  elif __has_include("FoundationExtension/FoundationExtension.h")
#     define FOUNDATION_EXTENSION                                          (1)
#     import "FoundationExtension/FoundationExtension.h"
#  elif __has_include("FoundationExtension.h")
#     define FOUNDATION_EXTENSION                                          (1)
#     import "FoundationExtension.h"
#  else
#     define FOUNDATION_EXTENSION                                          (0)
#  endif

#  if __has_include(<UIKitExtension/UIKitExtension.h>)
#     define UIKIT_EXTENSION                                               (1)
#     import <UIKitExtension/UIKitExtension.h>
#  elif __has_include("UIKitExtension/UIKitExtension.h")
#     define UIKIT_EXTENSION                                               (1)
#     import "UIKitExtension/UIKitExtension.h"
#  elif __has_include("UIKitExtension.h")
#     define UIKIT_EXTENSION                                               (1)
#     import "UIKitExtension.h"
#  else
#     define UIKIT_EXTENSION                                               (0)
#  endif

#  if __has_include(<IDEANightVersion/DKNightVersion.h>)
#     define IDEA_NIGHT_VERSION_MANAGER                                    (1)
#     import <IDEANightVersion/DKNightVersion.h>
#  elif __has_include("IDEANightVersion/DKNightVersion.h")
#     define IDEA_NIGHT_VERSION_MANAGER                                    (1)
#     import "IDEANightVersion/DKNightVersion.h"
#  elif __has_include("DKNightVersion.h")
#     define IDEA_NIGHT_VERSION_MANAGER                                    (1)
#     import "DKNightVersion.h"
#  else
#     define IDEA_NIGHT_VERSION_MANAGER                                    (0)
#  endif

#  if __has_include(<IDEAUIVendor/IDEAUIVendor.h>)
#     define IDEA_UI_VENDOR                                                (1)
#     import <IDEAUIVendor/IDEAUIVendor.h>
#  elif __has_include("IDEAUIVendor/IDEAUIVendor.h")
#     define IDEA_UI_VENDOR                                                (1)
#     import "IDEAUIVendor/IDEAUIVendor.h"
#  elif __has_include("IDEAUIVendor.h")
#     define IDEA_UI_VENDOR                                                (1)
#     import "IDEAUIVendor.h"
#  else
#     define IDEA_UI_VENDOR                                                (0)
#  endif

#  if __has_include(<IDEAColor/IDEAColor.h>)
#     define IDEA_COLOR                                                    (1)
#     import <IDEAColor/IDEAColor.h>
#  elif __has_include("IDEAColor/IDEAColor.h")
#     define IDEA_COLOR                                                    (1)
#     import "IDEAColor/IDEAColor.h"
#  elif __has_include("IDEAColor.h")
#     define IDEA_COLOR                                                    (1)
#     import "IDEAColor.h"
#  else
#     define IDEA_COLOR                                                    (0)
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

#  if __has_include(<MaterialComponents/MaterialNavigationBar.h>)
#     import <MaterialComponents/MaterialNavigationBar.h>
#     define MATERIAL_NAVIGATION_BAR                                       (1)
#  elif __has_include("MaterialComponents/MaterialNavigationBar.h")
#     import "MaterialComponents/MaterialNavigationBar.h"
#     define MATERIAL_NAVIGATION_BAR                                       (1)
#  else
#     define MATERIAL_NAVIGATION_BAR                                       (0)
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

#if (__has_include(<YYKit/YYKit.h>))
#  import <YYKit/YYKit.h>
#elif (__has_include("YYKit/YYKit.h"))
#  import "YYKit/YYKit.h"
// #elif (__has_include("YYKit.h"))
// #  import "YYKit.h"
#else /* YY_KIT */

#  ifndef weakify
#     if __has_feature(objc_arc)
#        define weakify( x )                                                                       \\
            _Pragma("clang diagnostic push")                                                       \\
            _Pragma("clang diagnostic ignored \\"-Wshadow\\"")                                       \\
            autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x;                             \\
            _Pragma("clang diagnostic pop")
#     else
#        define weakify( x )                                                                       \\
            _Pragma("clang diagnostic push")                                                       \\
            _Pragma("clang diagnostic ignored \\"-Wshadow\\"")                                       \\
            autoreleasepool{} __block __typeof__(x) __block_##x##__ = x;                           \\
            _Pragma("clang diagnostic pop")
#     endif
#  endif /* !weakify */

#  ifndef strongify
#     if __has_feature(objc_arc)
#        define strongify( x )                                                                     \\
            _Pragma("clang diagnostic push")                                                       \\
            _Pragma("clang diagnostic ignored \\"-Wshadow\\"")                                       \\
            try{} @finally{} __typeof__(x) x = __weak_##x##__;                                     \\
            _Pragma("clang diagnostic pop")
#     else
#        define strongify( x )                                                                     \\
            _Pragma("clang diagnostic push")                                                       \\
            _Pragma("clang diagnostic ignored \\"-Wshadow\\"")                                       \\
            try{} @finally{} __typeof__(x) x = __block_##x##__;                                    \\
            _Pragma("clang diagnostic pop")
#     endif
#  endif /* !strongify */

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
 
  switch (_eLevel)
  {
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

NS_INLINE void ____LoggerFatal(NSString *aFormat, ...) {
 
  va_list      args;
  NSString    *szMSG   = nil;
  
  va_start (args, aFormat);
  szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
  va_end (args);
  
  ____Log(__LogLevelFatal, [szMSG UTF8String]);
  
  __RELEASE(szMSG);
  
  return;
}

NS_INLINE void ____LoggerError(NSString *aFormat, ...) {
 
  va_list      args;
  NSString    *szMSG   = nil;
  
  va_start (args, aFormat);
  szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
  va_end (args);
  
  ____Log(__LogLevelError, [szMSG UTF8String]);
  
  __RELEASE(szMSG);
  
  return;
}

NS_INLINE void ____LoggerWarn(NSString *aFormat, ...) {
 
  va_list      args;
  NSString    *szMSG   = nil;
  
  va_start (args, aFormat);
  szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
  va_end (args);
  
  ____Log(__LogLevelWarn, [szMSG UTF8String]);
  
  __RELEASE(szMSG);
  
  return;
}

NS_INLINE void ____LoggerInfo(NSString *aFormat, ...) {
 
  va_list      args;
  NSString    *szMSG   = nil;
  
  va_start (args, aFormat);
  szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
  va_end (args);
  
  ____Log(__LogLevelInfo, [szMSG UTF8String]);
  
  __RELEASE(szMSG);
  
  return;
}

NS_INLINE void ____LoggerDebug(NSString *aFormat, ...) {
 
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

static __inline void ____LoggerFatal(char *_Format, ...) {
 
  va_list      args;
  static char s_MSG[LOG_BUG_SIZE]  = {0};
  
  bzero(s_MSG, sizeof(s_MSG));
  
  va_start (args, _Format);
  vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
  va_end (args);
  
  printf("[%s] %s :: %s\\n", MODULE, "Fatal", s_MSG);
  
  return;
}

static __inline void ____LoggerError(char *_Format, ...) {
 
  va_list      args;
  static char s_MSG[LOG_BUG_SIZE]  = {0};
  
  bzero(s_MSG, sizeof(s_MSG));
  
  va_start (args, _Format);
  vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
  va_end (args);
  
  printf("[%s] %s :: %s\\n", MODULE, "Error", s_MSG);
  
  return;
}

static __inline void ____LoggerWarn(char *_Format, ...) {
 
  va_list      args;
  static char s_MSG[LOG_BUG_SIZE]  = {0};
  
  bzero(s_MSG, sizeof(s_MSG));
  
  va_start (args, _Format);
  vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
  va_end (args);
  
  printf("[%s] %s :: %s\\n", MODULE, "Warning", s_MSG);
  
  return;
}

static __inline void ____LoggerInfo(char *_Format, ...) {
 
  va_list      args;
  static char s_MSG[LOG_BUG_SIZE]  = {0};
  
  bzero(s_MSG, sizeof(s_MSG));
  
  va_start (args, _Format);
  vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
  va_end (args);
  
  printf("[%s] %s :: %s\\n", MODULE, "Info", s_MSG);
  
  return;
}

static __inline void ____LoggerDebug(char *_Format, ...) {
 
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

#import <IDEAKit/IDEAKit.h>
#import <IDEAUIKit/IDEAUIKit.h>

#import "UIFont+IDEASearchController.h"

  EOS
                                                   spec.prefix_header_contents = pch_app_kit
     
end
