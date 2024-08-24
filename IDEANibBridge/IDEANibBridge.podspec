Pod::Spec.new do |spec|
  spec.name                 = "IDEANibBridge"
  spec.version              = "2.3.1"
  spec.summary              = "IDEANibBridge"
  spec.description          = "IDEANibBridge"
  spec.homepage             = "https://github.com/sunnyxx/XXNibBridge.git"
  spec.license              = { :type => "MIT", :file => "LICENSE" }
  spec.author               = { "Harry" => "miniwing.hz@gmail.com" }
#  spec.platform             = :ios, "12.0"
  
  spec.tvos.deployment_target       = '12.0'
  spec.ios.deployment_target        = '12.0'

  spec.osx.deployment_target        = '10.15'
  spec.watchos.deployment_target    = '5.0'

  spec.ios.pod_target_xcconfig      = {
                                        'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEANibBridge',
                                        'ENABLE_BITCODE'            => 'NO',
                                        'SWIFT_VERSION'             => '5.0',
                                        'EMBEDDED_CONTENT_CONTAINS_SWIFT'       => 'NO',
                                        'ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES' => 'NO',
                                        'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
                                      }
  spec.osx.pod_target_xcconfig      = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEANibBridge' }
  spec.watchos.pod_target_xcconfig  = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEANibBridge-watchOS' }
  spec.tvos.pod_target_xcconfig     = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEANibBridge' }

  spec.pod_target_xcconfig          = {
    'GCC_PREPROCESSOR_DEFINITIONS'  => [
                                          ' MODULE=\"IDEANibBridge\" '
                                        ]
                                      }

#  spec.requires_arc   = true
#  spec.non_arc_files  = ['Classes/Frameworks/PGSQLKit/*.{h,m}']

  spec.frameworks           = ['Foundation', 'CoreGraphics']
  spec.source               = { :path => "." }

  spec.xcconfig             = {
    'HEADER_SEARCH_PATHS'   => ''
  }

  spec.xcconfig   = {
    'HEADER_SEARCH_PATHS'   => [
                                "${PODS_TARGET_SRCROOT}/",
                                "${PODS_TARGET_SRCROOT}/../",
                                "${PODS_ROOT}/Headers/Public/IDEAKit",
#                                "${PODS_ROOT}/Headers/Public/IDEAUIKit",
                                "${PODS_ROOT}/Headers/Public/FoundationExtension",
                                "${PODS_ROOT}/Headers/Public/UIKitExtension",
                                "${PODS_ROOT}/Headers/Public/YYKit"
                               ]
                    }

#  spec.dependency 'FoundationExtension'
#  spec.dependency 'UIKitExtension'
#  spec.dependency 'YYKit'

#  spec.dependency 'AFNetworking'
#  spec.dependency 'RegexKitLite'
#  spec.dependency 'XXNibBridge'
  
#  spec.dependency 'SDWebImageWebPCoder'
  
  spec.public_header_files  = 'XXNibBridge/*.{h}'
  spec.source_files         = 'XXNibBridge/*.{h,m}'
  
#  spec.resource             = 'IDEAORB/Images/*.png'
#  spec.resource             = 'IDEAORB/StarRateView.xcassets'
#  spec.resource_bundle      = 'IDEAORB/StarRateView.xcassets'

#  spec.resource_bundles     =
#  {
#    "IDEAORB" =>
#    [
#    'IDEAORB/StarRateView.xcassets',
#    ]
#  }

#  spec.vendored_libraries    = 'libXG-SDK.a'

  pch_app_kit = <<-EOS

/******************************************************************************************************/

#if (defined(DEBUG) && (1==DEBUG))
#  pragma clang diagnostic ignored                 "-Wgnu"
#  pragma clang diagnostic ignored                 "-Wcomma"
#  pragma clang diagnostic ignored                 "-Wformat"
#  pragma clang diagnostic ignored                 "-Wswitch"
#  pragma clang diagnostic ignored                 "-Wvarargs"
#  pragma clang diagnostic ignored                 "-Wvarargs"
#  pragma clang diagnostic ignored                 "-Wnonnull"
#  pragma clang diagnostic ignored                 "-Wcomment"
#  pragma clang diagnostic ignored                 "-Wprotocol"
#  pragma clang diagnostic ignored                 "-Wpointer-sign"
#  pragma clang diagnostic ignored                 "-Wdangling-else"
#  pragma clang diagnostic ignored                 "-Wunused-result"
#  pragma clang diagnostic ignored                 "-Wpch-date-time"
#  pragma clang diagnostic ignored                 "-Wuninitialized"
#  pragma clang diagnostic ignored                 "-Wdocumentation"
#  pragma clang diagnostic ignored                 "-Wpch-date-time"
#  pragma clang diagnostic ignored                 "-Wambiguous-macro"
#  pragma clang diagnostic ignored                 "-Wenum-conversion"
#  pragma clang diagnostic ignored                 "-Wunused-variable"
#  pragma clang diagnostic ignored                 "-Wunused-function"
#  pragma clang diagnostic ignored                 "-Wmissing-noescape"
#  pragma clang diagnostic ignored                 "-Wwritable-strings"
#  pragma clang diagnostic ignored                 "-Wunreachable-code"
#  pragma clang diagnostic ignored                 "-Wshorten-64-to-32"
#  pragma clang diagnostic ignored                 "-Wwritable-strings"
#  pragma clang diagnostic ignored                 "-Wstrict-prototypes"
#  pragma clang diagnostic ignored                 "-Wobjc-method-access"
#  pragma clang diagnostic ignored                 "-Wdocumentation-html"
#  pragma clang diagnostic ignored                 "-Wobjc-method-access"
#  pragma clang diagnostic ignored                 "-Wincomplete-umbrella"
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
#  pragma clang diagnostic ignored                 "-Warc-performSelector-leaks"
#  pragma clang diagnostic ignored                 "-Wconditional-uninitialized"
#  pragma clang diagnostic ignored                 "-Wincompatible-property-type"
#  pragma clang diagnostic ignored                 "-Wincompatible-pointer-types"
#  pragma clang diagnostic ignored                 "-Wunguarded-availability-new"
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

/******************************************************************************************************/

#import <Availability.h>

#ifndef __IPHONE_12_0
#  warning "This project uses features only available in iOS SDK 12.0 and later."
#endif /* __IPHONE_12_0 */

#import <stdlib.h>
#import <stdio.h>
#import <string.h>

#import <pthread/pthread.h>

#import <objc/message.h>
#import <objc/runtime.h>

#ifdef __OBJC__
#  import <UIKit/UIKit.h>
#  import <Foundation/Foundation.h>
#  import <QuartzCore/QuartzCore.h>
#  import <QuartzCore/CAAnimation.h>
#  import <MessageUI/MessageUI.h>
#else /* __OBJC__ */
#endif /* !__OBJC__ */

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

#ifdef __OBJC__

typedef NS_ENUM(NSInteger, __LogLevel) {

   __LogLevelFatal   = 0,
   __LogLevelError,
   __LogLevelWarn,
   __LogLevelInfo,
   __LogLevelDebug
};

NS_INLINE const char* ____LogLevelToString(__LogLevel _eLevel) {
   
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

NS_INLINE void ____Log(__LogLevel _eLevel, const NSString *_aMsg) {
   
   if (LOG_BUG_SIZE >= _aMsg.length) {
      
      printf("[%s] %s :: %s\\n", MODULE, ____LogLevelToString(_eLevel), [_aMsg UTF8String]);
      
   }
   else {

      printf("####################################################################################\\n");
      printf("[%s] %s :: ", MODULE, ____LogLevelToString(_eLevel));

      // 在数组范围内，则循环分段
      while (LOG_BUG_SIZE < _aMsg.length) {
         
         // 按字节长度截取字符串
         NSString *szSubStr   = [_aMsg substringToIndex:LOG_BUG_SIZE]; // cutStr(bytes, maxByteNum);
         
         // 打印日志
         printf("%s\\n", [szSubStr UTF8String]);
         
         // 截取出尚未打印字节数组
         _aMsg = [_aMsg substringFromIndex:LOG_BUG_SIZE];
         
      } /* End while () */

      // 打印剩余部分
      printf("%s\\n", [_aMsg UTF8String]);
      printf("####################################################################################\\n");

   } /* End else */

//   printf("[%s] %s :: %s\\n", MODULE, ____LogLevelToString(_eLevel), _cpszMsg);
      
   return;
}

NS_INLINE void ____LoggerFatal(NSString *aFormat, ...) {
   
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   ____Log(__LogLevelFatal, szMSG);
   
   __RELEASE(szMSG);
   
   return;
}

NS_INLINE void ____LoggerError(NSString *aFormat, ...) {
   
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   ____Log(__LogLevelError, szMSG);
   
   __RELEASE(szMSG);
   
   return;
}

NS_INLINE void ____LoggerWarn(NSString *aFormat, ...) {
   
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   ____Log(__LogLevelWarn, szMSG);
   
   __RELEASE(szMSG);
   
   return;
}

NS_INLINE void ____LoggerInfo(NSString *aFormat, ...) {
   
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   ____Log(__LogLevelInfo, szMSG);
   
   __RELEASE(szMSG);
   
   return;
}

NS_INLINE void ____LoggerDebug(NSString *aFormat, ...) {
   
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   ____Log(__LogLevelDebug, szMSG);
   
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
#define __DebugView__                              (__OFF__)

#define __DebugKeyboard__                          (__OFF__)

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

NS_INLINE NSString * __APP_BUNDLE_NAME() {
   return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

NS_INLINE NSString * __APP_BUNDLE_ID() {
   return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

NS_INLINE NSString * __APP_VERSION() {
   return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

NS_INLINE NSString * __APP_BUILD_VERSION() {
   return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

/******************************************************************************************************/

  EOS
  spec.prefix_header_contents = pch_app_kit

end
