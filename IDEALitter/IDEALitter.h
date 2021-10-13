//
//  IDEALitter.h
//  IDEALitter
//
//  Created by Harry on 2021/5/31.
//

#ifndef IDEALitter_h
#define IDEALitter_h

#import <IDEALitter/IDEAUtils.h>
#import <IDEALitter/NSObject+Notification.h>
#import <IDEALitter/UIAlertController+Blocks.h>

#ifdef __OBJC__
#  define __bridge_cast(type, p)                                              (__bridge (type))(p)
#  define __cast(type, p)                                                     (type)(p)

#  ifndef weakify
#     if __has_feature(objc_arc)
#        define weakify( x )                                                  \
                _Pragma("clang diagnostic push")                              \
                _Pragma("clang diagnostic ignored \"-Wshadow\"")              \
                autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x;    \
                _Pragma("clang diagnostic pop")
#     else

#        define weakify( x )                                                  \
                _Pragma("clang diagnostic push")                              \
                _Pragma("clang diagnostic ignored \"-Wshadow\"")              \
                autoreleasepool{} __block __typeof__(x) __block_##x##__ = x;  \
                _Pragma("clang diagnostic pop")
#     endif
#  endif

#  ifndef strongify
#    if __has_feature(objc_arc)
#       define strongify( x )                                                \
               _Pragma("clang diagnostic push")                              \
               _Pragma("clang diagnostic ignored \"-Wshadow\"")              \
               try{} @finally{} __typeof__(x) x = __weak_##x##__;            \
               _Pragma("clang diagnostic pop")
#    else

#       define strongify( x )                                                \
               _Pragma("clang diagnostic push")                              \
               _Pragma("clang diagnostic ignored \"-Wshadow\"")              \
               try{} @finally{} __typeof__(x) x = __block_##x##__;           \
               _Pragma("clang diagnostic pop")
#    endif
#  endif
#endif

#endif /* IDEALitter_h */
