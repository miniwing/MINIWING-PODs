Pod::Spec.new do |spec|
  spec.name                 = "IDEAKit"
  spec.version              = "1.0.1"
  spec.summary              = "IDEAKit"
  spec.description          = "IDEAKit"
  spec.homepage             = "https://github.com/miniwing"
  spec.license              = "MIT"
  spec.author               = { "Harry" => "miniwing.hz@gmail.com" }
#  spec.platform             = :ios, ENV['ios.deployment_target']
  
#  spec.requires_arc = true
#  spec.non_arc_files  = ['Classes/Frameworks/PGSQLKit/*.{h,m}']
  
  spec.source                       = { :path => "." }

#  spec.swift_versions               = ["4.2", "5.0"]

  spec.ios.deployment_target        = ENV['ios.deployment_target']
  spec.watchos.deployment_target    = ENV['watchos.deployment_target']
  spec.tvos.deployment_target       = ENV['tvos.deployment_target']
  spec.osx.deployment_target        = ENV['osx.deployment_target']

  spec.ios.pod_target_xcconfig      = {
                                        'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEAKit',
                                        'ENABLE_BITCODE'            => ENV['ENABLE_BITCODE'],
                                        'SWIFT_VERSION'             => ENV['SWIFT_VERSION'],
                                        'EMBEDDED_CONTENT_CONTAINS_SWIFT'       => 'NO',
                                        'ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES' => 'NO',
                                        'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
                                      }
  spec.osx.pod_target_xcconfig      = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEAKit' }
  spec.watchos.pod_target_xcconfig  = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEAKit-watchOS' }
  spec.tvos.pod_target_xcconfig     = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEAKit' }
    
  spec.frameworks                   = ['Foundation', 'UIKit', 'CoreGraphics', 'QuartzCore', 'CoreFoundation']
    
  spec.xcconfig                     = {
    'HEADER_SEARCH_PATHS'               => [
#                                            "${PODS_TARGET_SRCROOT}/",
#                                            "${PODS_TARGET_SRCROOT}/../",
#                                            "${PODS_ROOT}/Headers/Public/**"
#                                            "${PODS_ROOT}/AFNetworking/**",
#                                            "${PODS_ROOT}/MaterialComponents/**",
#                                            "${PODS_ROOT}/Headers/Public/MaterialComponents",
#                                            "${PODS_ROOT}/Headers/Public/FoundationExtension/",
#                                            "${PODS_ROOT}/Headers/Public/UIKitExtension/",
#                                            "${PODS_ROOT}/Headers/Public/YYKit/",
#                                            "${PODS_ROOT}/Headers/Public/AFNetworking",
#                                            "${PODS_ROOT}/Headers/Public/IDEAKit/",
#                                            "${PODS_ROOT}/Headers/Public/IDEAColor",
                                            ],
  'FRAMEWORK_SEARCH_PATHS'              =>  [
#                                              "${PODS_CONFIGURATION_BUILD_DIR}/MaterialComponents",
#                                              "${PODS_CONFIGURATION_BUILD_DIR}/FoundationExtension",
#                                              "${PODS_CONFIGURATION_BUILD_DIR}/UIKitExtension",
#                                              "${PODS_CONFIGURATION_BUILD_DIR}/AFNetworking",
#                                              "${PODS_CONFIGURATION_BUILD_DIR}/YYKit",
                                            ]
                                      }

  spec.pod_target_xcconfig          = {
    'GCC_PREPROCESSOR_DEFINITIONS'  => [ ' MODULE=\"IDEAKit\" ' ]
  }

  if ENV['IDEA_FOUNDATION_EXTENSION'] == 'YES'
    spec.dependency 'FoundationExtension'
  end # IDEA_FOUNDATION_EXTENSION

  if ENV['IDEA_UIKIT_EXTENSION'] == 'YES'
    spec.dependency 'UIKitExtension'
  end # IDEA_UIKIT_EXTENSION

  if ENV['IDEA_AFNETWORKING'] == 'YES'
    spec.dependency 'AFNetworking'
#    spec.dependency 'AFNetworking/Serialization'
#    spec.dependency 'AFNetworking/Security'
#    spec.dependency 'AFNetworking/Reachability'
#    spec.dependency 'AFNetworking/NSURLSession'
  end # IDEA_AFNETWORKING

  if ENV['IDEA_YYKIT'] == 'YES'
    spec.dependency 'YYKit'
  end # IDEA_YYKIT

  if ENV['OpenSSL'] == 'YES'
    spec.dependency 'OpenSSL-Universal'
  end # OpenSSL

  if ENV['SSZipArchive'] == 'YES'
    spec.dependency 'SSZipArchive'
  end # SSZipArchive
  
  if ENV['PromisesObjC'] == 'YES'
    spec.dependency 'PromisesObjC'
  end # PromisesObjC

  spec.public_header_files        = 'IDEAKit/**/*.{h}',
                                    'IDEAExtension/**/*.{h}',
                                    'IDEAFoundationExtension/**/*.{h}'

#  spec.private_header_files       = 'IDEAKit/**/*.{h}',
#                                    'IDEAExtension/**/*.{h}'
  spec.source_files               = 'IDEAKit/**/*.{h,m,mm,c,cpp}',
                                    'IDEAExtension/**/*.{h,m,mm,c,cpp}',
                                    'IDEAFoundationExtension/**/*.{h,m,mm,c,cpp}'

#  spec.vendored_libraries   = 'libXG-SDK.a'
#  spec.vendored_frameworks  = 'libXG-SDK.a'

#  spec.subspec 'Debug' do |sub|
#    sub.ios.deployment_target   = '10.0'
#    sub.ios.source_files        = 'IDEAKit/IDEAKit/**/*.{h,m,mm}'
#    sub.ios.public_header_files = 'IDEAKit/IDEAKit/**/*.{h}'
#    sub.ios.header_dir          = 'IDEAKit'
#    sub.ios.preserve_paths      = 'ios/lib/libcrypto.a', 'ios/lib/libssl.a'
#    sub.ios.vendored_libraries  = 'ios/lib/libcrypto.a', 'ios/lib/libssl.a'
#  end

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
#else /* __OBJC__ */
#endif /* !__OBJC__ */

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

#ifdef __OBJC__

#  if __has_include(<FoundationExtension/FoundationExtension-umbrella.h>)
#     import <FoundationExtension/FoundationExtension.h>
#     define FOUNDATION_EXTENSION                                          (1)
#  elif __has_include("FoundationExtension/FoundationExtension-umbrella.h")
#     import "FoundationExtension/FoundationExtension.h"
#     define FOUNDATION_EXTENSION                                          (1)
#  else
#     define FOUNDATION_EXTENSION                                          (0)
#  endif

#  if __has_include(<UIKitExtension/UIKitExtension-umbrella.h>)
#     import <UIKitExtension/UIKitExtension.h>
#     define UIKIT_EXTENSION                                               (1)
#  elif __has_include("UIKitExtension/UIKitExtension-umbrella.h")
#     import "UIKitExtension/UIKitExtension.h"
#     define UIKIT_EXTENSION                                               (1)
#  else
#     define UIKIT_EXTENSION                                               (0)
#  endif

#  if __has_include(<RegexKitLite/RegexKitLite.h>)
#     import <RegexKitLite/RegexKitLite.h>
#     define REGEX_KITLITE                                                 (1)
#  elif __has_include("RegexKitLite/RegexKitLite.h")
#     import "RegexKitLite/RegexKitLite.h"
#     define REGEX_KITLITE                                                 (1)
#  else
#     define REGEX_KITLITE                                                 (0)
#  endif

#  if __has_include(<SSZipArchive/SSZipArchive-umbrella.h>)
#     import <SSZipArchive/SSZipArchive-umbrella.h>
#     define SS_ZIP_ARCHIVE                                                (1)
#  elif __has_include("SSZipArchive/SSZipArchive-umbrella.h")
#     import "SSZipArchive/SSZipArchive-umbrella.h"
#     define SS_ZIP_ARCHIVE                                                (1)
#  else
#     define SS_ZIP_ARCHIVE                                                (0)
#  endif

#endif /* __OBJC__ */

/******************************************************************************************************/

#if (__has_include(<YYKit/YYKit-umbrella.h>))
#  import <YYKit/YYKit-umbrella.h>
#     define YY_KIT                                                        (1)
#elif (__has_include("YYKit/YYKit-umbrella.h"))
#  import "YYKit/YYKit-umbrella.h"
#     define YY_KIT                                                        (1)
#elif (__has_include("YYKit-umbrella.h"))
#  import "YYKit-umbrella.h"
#     define YY_KIT                                                        (1)
#else /* YY_KIT */
#     define YY_KIT                                                        (0)
#  ifndef weakify
#     if __has_feature(objc_arc)
#        define weakify( x )                                               \\
            _Pragma("clang diagnostic push")                               \\
            _Pragma("clang diagnostic ignored \\"-Wshadow\\"")               \\
            autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x;     \\
            _Pragma("clang diagnostic pop")
#     else
#        define weakify( x )                                               \\
            _Pragma("clang diagnostic push")                               \\
            _Pragma("clang diagnostic ignored \\"-Wshadow\\"")               \\
            autoreleasepool{} __block __typeof__(x) __block_##x##__ = x;   \\
            _Pragma("clang diagnostic pop")
#     endif
#  endif /* !weakify */

#  ifndef strongify
#     if __has_feature(objc_arc)
#        define strongify( x )                                             \\
            _Pragma("clang diagnostic push")                               \\
            _Pragma("clang diagnostic ignored \\"-Wshadow\\"")               \\
            try{} @finally{} __typeof__(x) x = __weak_##x##__;             \\
            _Pragma("clang diagnostic pop")
#     else
#        define strongify( x )                                             \\
            _Pragma("clang diagnostic push")                               \\
            _Pragma("clang diagnostic ignored \\"-Wshadow\\"")               \\
            try{} @finally{} __typeof__(x) x = __block_##x##__;            \\
            _Pragma("clang diagnostic pop")
#     endif
#  endif /* !strongify */
#endif

/******************************************************************************************************/

#if __has_include(<OpenSSL/OpenSSL.h>)
#  import <OpenSSL/OpenSSL.h>
#elif __has_include("OpenSSL/OpenSSL.h")
#  import "OpenSSL/OpenSSL.h"
#elif __has_include("OpenSSL.h")
#  import "OpenSSL.h"
#endif

#import <IDEAKit/IDEADef.h>
#import <IDEAKit/IDEADebug.h>
#import <IDEAKit/IDEALog.h>

#import <IDEAKit/IDEAKit.h>

  EOS
  spec.prefix_header_contents = pch_app_kit

end
