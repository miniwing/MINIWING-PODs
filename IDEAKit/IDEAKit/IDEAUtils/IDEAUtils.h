//
//  IDEAUtils.h
//  IDEAKit
//
//  Created by Harry on 2018/7/6.
//  Copyright © 2018年 Harry. All rights reserved.
//
//  Mail : miniwing.hz@gmail.com
//

#ifdef __OBJC__
#  import <sys/time.h>
#  import <pthread.h>
#  import <Foundation/Foundation.h>
#else
#  include <sys/time.h>
#  include <pthread.h>
#  include <dispatch/dispatch.h>

#  if !defined(NS_INLINE)
#     if defined(__GNUC__)
#        define NS_INLINE static __inline__ __attribute__((always_inline))
#     elif defined(__MWERKS__) || defined(__cplusplus)
#        define NS_INLINE static inline
#     elif defined(_MSC_VER)
#        define NS_INLINE static __inline
#     endif
#  endif
#endif /* __OBJC__ */

//NS_INLINE NSString * __SAFE_STRING(NSString * aSTRING) {
//
//   if (nil == aSTRING) {
//
//      return @"";
//
//   } /* End if () */
//
//   return aSTRING;
//}
//
//NS_INLINE NSString * __APPEND_PAIRS_FROM_KEY_VALUE(NSString * aSTRING, NSString * aKEY, id aVALUE) {
//
//   if (nil == aSTRING) {
//
//      return aSTRING = [NSString stringWithFormat:@"%@=%@", aKEY, aVALUE];
//
//   } /* End if () */
//
//   return [aSTRING stringByAppendingFormat:@"&%@=%@", aKEY, aVALUE];
//}

#ifdef __OBJC__

NS_INLINE void DISPATCH_ASYNC_ON_MAIN_QUEUE(void (^block)(void)) {
   
   if (pthread_main_np()) {
      
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
         dispatch_async(dispatch_get_main_queue(), block);
      });
      
   } /* End if () */
   else {
      
      dispatch_async(dispatch_get_main_queue(), block);
      
   } /* End else */
   
   return;
}

NS_INLINE void DISPATCH_SYNC_ON_MAIN_QUEUE(void (^block)(void)) {
   
   if (pthread_main_np()) {
      
      block();
      
   } /* End if () */
   else {
      
      dispatch_sync(dispatch_get_main_queue(), block);
      
   } /* End else */
   
   return;
}

NS_INLINE void DISPATCH_ASYNC_ON_BACKGROUND_QUEUE(void (^block)(void)) {
   
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block);
   
   return;
}

NS_INLINE void DISPATCH_SYNC_ON_BACKGROUND_QUEUE(void (^block)(void)) {
   
   dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block);
   
   return;
}

NS_INLINE void DISPATCH_ASYNC_ON_DEFAULT_QUEUE(void (^block)(void)) {
   
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
   
   return;
}

NS_INLINE void DISPATCH_SYNC_ON_DEFAULT_QUEUE(void (^block)(void)) {
   
   dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
   
   return;
}

NS_INLINE void DISPATCH_AFTER_ON_MAIN_QUEUE(NSTimeInterval aDelayInSeconds, void (^block)(void)) {
   
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(aDelayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
   
   return;
}

NS_INLINE void DISPATCH_AFTER_ON_BACKGROUND_QUEUE(NSTimeInterval aDelayInSeconds, void (^block)(void)) {
   
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(aDelayInSeconds * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block);
   
   return;
}

/**
Submits a block for asynchronous execution on a background queue and returns immediately.
*/
NS_INLINE void DISPATCH_ASYNC_ON_GLOBAL_QUEUE(intptr_t identifier, void (^block)(void)) {
   
   dispatch_async(dispatch_get_global_queue(identifier, 0), block);
   
   return;
}

NS_INLINE dispatch_queue_main_t DISPATCH_GET_MAIN_QUEUE(void) {
   
   return dispatch_get_main_queue();
}

NS_INLINE dispatch_queue_global_t DISPATCH_GET_BACKGROUND_QUEUE(void) {
   
   return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
}

NS_INLINE dispatch_queue_global_t DISPATCH_GET_GLOBAL_QUEUE_LOW(void) {
   
   return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
}

NS_INLINE dispatch_queue_global_t DISPATCH_GET_GLOBAL_QUEUE_HIGH(void) {
   
   return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
}

/******************************************************************************************************/

//NS_INLINE NSBundle * IDEA_BUNDLE_FROM(NSString *aBundle, Class aClass) {
//
//  static NSBundle         *g_BUNDLE      = nil;
//  static dispatch_once_t   stOnceToken;
//
//  dispatch_once(&stOnceToken, ^{
//
//     NSBundle *stBundle   = [NSBundle bundleForClass:aClass];
//     NSString *szPath     = [stBundle pathForResource:aBundle ofType:@"bundle"];
//
//     g_BUNDLE = [NSBundle bundleWithPath:szPath];
//  });
//
//  return g_BUNDLE;
//}
//
//NS_INLINE NSString * IDEA_LOCALIZED_STRING(NSString *aBundle, Class aClass, NSString *aKey) {
//
//   return NSLocalizedStringFromTableInBundle(aKey, nil, IDEA_BUNDLE_FROM(aBundle, aClass), nil);
//}
//
//NS_INLINE UIImage * IMAGE_NAMED_IN_BUNDLE(NSString *aBundle, NSString * aName, Class aClass) {
//
//   return [UIImage imageNamed:aName inBundle:IDEA_BUNDLE_FROM(aBundle, aClass) compatibleWithTraitCollection:nil];
//}

NS_INLINE NSBundle * IDEA_BUNDLE_FROM(NSString *aBundle, Class aClass) {
   
   static NSBundle         *g_BUNDLE      = nil;
   static dispatch_once_t   stOnceToken;
   
   dispatch_once(&stOnceToken, ^{
      
      NSBundle *stBundle    = [NSBundle bundleForClass:aClass];
      
      if (nil != aBundle) {
         
         NSString *szPath   = [stBundle pathForResource:aBundle ofType:@"bundle"];
         
         g_BUNDLE  = [NSBundle bundleWithPath:szPath];
         
      } /* End if () */
      else {
         
         g_BUNDLE  = stBundle;
         
      } /* End else */
   });
   
   return g_BUNDLE;
}

NS_INLINE NSString * IDEA_LOCALIZED_STRING(NSString *aBundle, Class aClass, NSString *aKey) {
   
   return NSLocalizedStringWithDefaultValue(aKey, nil, IDEA_BUNDLE_FROM(aBundle, aClass), aKey, aKey);
//   return NSLocalizedStringFromTableInBundle(aKey, nil, IDEA_BUNDLE_FROM(aBundle, aClass), nil);
}

NS_INLINE UIImage * IMAGE_NAMED_IN_BUNDLE(NSString *aBundle, NSString * aName, Class aClass) {
   
   return [UIImage imageNamed:aName inBundle:IDEA_BUNDLE_FROM(aBundle, aClass) compatibleWithTraitCollection:nil];
}

/******************************************************************************************************/

#endif /* __OBJC__ */
