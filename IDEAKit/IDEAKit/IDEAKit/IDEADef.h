//
//  IDEADef.h
//  IDEAKit
//
//  Created by Harry on 14-6-29.
//  Copyright (c) 2014年 Harry. All rights reserved.
//
//  Mail:miniwing.hz@gmail.com
//  TEL :+(852)53054612


#ifndef IdeaDef_H
#define IdeaDef_H

#include <stdlib.h>
#include <strings.h>
#include <stdlib.h>
#include <stdio.h>

#if __has_feature(objc_arc)
#  define __objc_arc__
#endif /* __has_feature(objc_arc) */

#ifndef SUCCESS
#  define SUCCESS                                           (0)
#endif /* SUCCESS */

#if defined(__cplusplus)

#  define BEGIN_DECLS                                       extern "C"     {
#  define END_DECLS                                                        }

#  define BEGIN_NAMESPACE(name)                             namespace name {
#  define END_NAMESPACE(name)                                              }

#  define USE_NAMESPACE(name)                               using namespace name;

#  define __INLINE                                          inline
#  define LOCAL                                             static inline

#else /* __cplusplus */

#  define BEGIN_DECLS
#  define END_DECLS

#  define __INLINE                                          __inline__
#  define LOCAL                                             static __inline__

#endif /* !__cplusplus */


//#ifdef __cplusplus
//#define IDEA_EXTERN                                         extern "C" __attribute__((visibility ("default")))
//#else
//#define IDEA_EXTERN                                         extern __attribute__((visibility ("default")))
//#endif

#define IsInvalid                                           (YES)

#define I_FUNCTION                                          __PRETTY_FUNCTION__

#ifndef __STRING
#  define __STRING(STR)                                     (#STR)
#endif /* __STRING */

/******************************************************************************************************/
/*                                                                                                    */
/******************************************************************************************************/
#pragma mark - const info

#define GOLDEN_RATIO                                        (0.61803398875f)
#define GOLDEN_RATIO_2                                      (0.30901699438f)
#define GOLDEN_RATIO_4                                      (0.15450849719f)

#define MAKE_GOLDEN_RATIO(x)                                ((x) * 0.61803398875f)
#define MAKE_GOLDEN_RATIO_2(x)                              ((x) * 0.30901699438f)
#define MAKE_GOLDEN_RATIO_4(x)                              ((x) * 0.15450849719f)

#define INVERTED_GOLDEN_RATIO(x)                            ((x) * 0.38196601125f)
#define INVERTED_GOLDEN_RATIO_2(x)                          ((x) * 0.19098300563f)
#define INVERTED_GOLDEN_RATIO_4(x)                          ((x) * 0.09549150281f)

#define RADIAN_2_ANGLE(x)                                   ((x) * 180.0f / M_PI)
#define ANGLE_2_RADIAN(x)                                   ((x) * M_PI / 180.0f)

/******************************************************************************************************/

#define IDEA_PIXEL(x)                                       ([[UIScreen mainScreen] scale] > 0.0 ? (x) / [[UIScreen mainScreen] scale] : (x))

/******************************************************************************************************/

#undef  __ON__
#define __ON__                                              (1)

#undef  __OFF__
#define __OFF__                                             (0)

#undef  __AUTO__
#undef  __Debug__

#if (defined(DEBUG) && (DEBUG == 1))
#  define __AUTO__                                          (1)
#  define __Debug__                                         (1)
#else
#  define __AUTO__                                          (0)
#  define __Debug__                                         (0)
#endif /* (defined(DEBUG) && (DEBUG == 1)) */

LOCAL void * MALLOC_EX(size_t aSize) {
   
   void  *pV   = malloc(aSize);
   
   if (NULL != pV) {
      
      memset(pV, 0, aSize);
      
   } /* End if () */
   
   return pV;
}

#ifndef FREE_IF
#  define FREE_IF(p)                                        if(p) {free (p); (p)=NULL;}
#endif /* DELETE_IF */

#ifndef UNUSED
#  define UNUSED( __x )                                     { id __unused_var__ __attribute__((unused)) = (id)(__x); }
#endif

#ifndef ALIAS
#  define ALIAS( __a, __b )                                 __typeof__(__a) __b = __a;
#endif

#ifndef DEPRECATED
#  define DEPRECATED                                        __attribute__((deprecated))
#endif

#ifndef TODO
#  define TODO( X )                                         _Pragma(macro_cstr(message("TODO: " X)))
#endif

/******************************************************************************************************/
/*                                                                                                    */
/******************************************************************************************************/

#ifdef __OBJC__

#define NS_STR(key, comment)                                NSLocalizedString((key), (comment))
#define APP_STR(key)                                        NS_STR((key), nil)

#define WEAK_SELF                                           __weak __typeof__(self)
#define STRONG_SELF                                         __strong __typeof__(self)

#pragma mark __objc_arc__
#  ifdef __objc_arc__
#     define __AUTORELEASE(x)                               (x);
#     define __RELEASE(x)                                   (x) = nil;
#     define __RETAIN(x)                                    (x)
#     define __SUPER_DEALLOC                                objc_removeAssociatedObjects(self);
#     define __dispatch_release(x)                          (x) = nil;
#  else
#     define __RETAIN(x)                                    [(x) retain];
#     define __AUTORELEASE(x)                               [(x) autorelease];
#     define __RELEASE(x)                                   if (nil != (x)) {                               \
                                                               [(x) release];                               \
                                                               (x) = nil;                                   \
                                                            }
#     define __SUPER_DEALLOC                                objc_removeAssociatedObjects(self);[super dealloc];
#     define __dispatch_release(x)                          dispatch_release((x))
#  endif

#define IDEA_ENUM(type, alias)                              typedef NS_ENUM(type, alias)
#define IDEA_OPTIONS(type, alias)                           typedef NS_OPTIONS(type, alias)

#define __cast(type, p)                                     ((type)(p))
#define __bridge_cast(type, p)                              (__bridge type)(p)


#define UI_PERFORM_SELECTOR(SELF, SEL, OBJ, DONE)                                                           \
                                                            [(SELF) performSelectorOnMainThread:(SEL)       \
                                                                                     withObject:(OBJ)       \
                                                                                  waitUntilDone:(DONE)];

#define BG_PERFORM_SELECTOR(SELF, SEL, OBJ)                                                                 \
                                                            [(SELF) performSelectorInBackground:(SEL)       \
                                                            withObject:OBJ];

#define BEGIN_AUTO_RELEASE_POOL                             @autoreleasepool {
#define END_AUTO_RELEASE_POOL                               }


//#ifndef nonnull
//#  define nonnull
//#endif
//
//#ifndef nullable
//#  define nullable
//#endif
//
//#ifndef __nonnull
//#  define __nonnull
//#endif

#ifndef IDEA_DUMMY_CLASS
# define IDEA_DUMMY_CLASS(_name_)                  @interface __DUMMY_CLASS_ ## _name_ : NSObject           \
                                                   @end                                                     \
                                                   @implementation __DUMMY_CLASS_ ## _name_                 \
                                                   @end
#endif

#endif /* __OBJC__ */

#define UI_AVAILABLE_SDK_IOS(_ios)                          ((__IPHONE_##_ios != 0) &&                      \
                                                             (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_##_ios))

/******************************************************************************************************/

typedef unsigned char                                       BYTE;
typedef unsigned short                                      WORD;
typedef unsigned long                                       DWORD;
typedef signed   long                                       LONG;

#define MAKEWORD(a, b)                                      ((WORD)(((BYTE)((a) & 0xff)) | ((WORD)((BYTE)((b) & 0xff))) << 8))
#define MAKELONG(a, b)                                      ((LONG)(((WORD)((a) & 0xffff)) | ((DWORD)((WORD)((b) & 0xffff))) << 16))

#define LOWORD(l)                                           ((WORD)((l) & 0xffff))
#define HIWORD(l)                                           ((WORD)((l) >> 16))

#define LOBYTE(w)                                           ((BYTE)((w) & 0xff))
#define HIBYTE(w)                                           ((BYTE)((w) >> 8))

/*********************************************************************************************
 * HTTP Timeout                                                                              *
 *********************************************************************************************/
#if __Debug__
#  define HTTP_TIME_OUT_INTERVAL                   (10)
#else
#  define HTTP_TIME_OUT_INTERVAL                   (30)
#endif

#endif /* IdeaDef_H */
