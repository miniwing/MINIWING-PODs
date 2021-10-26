//
//  IDEAUtils.h
//  IDEALitter
//
//  Created by Harry on 2018/7/6.
//  Copyright © 2018年 Harry. All rights reserved.
//
//  Mail : miniwing.hz@gmail.com
//

#import <Foundation/Foundation.h>
#import <sys/time.h>
#import <pthread.h>

#if __has_include(<YYCategories/YYCategories.h>)
#  import <YYCategories/YYCategories.h>
#elif __has_include("YYCategories/YYCategories.h")
#  import "YYCategories/YYCategories.h"
#elif __has_include("YYCategories.h")
#  import "YYCategories.h"
#endif

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

#if (__has_include(<YYKit/YYKit.h>) || __has_include("YYKit/YYKit.h"))

#else /* YY_KIT */

NS_INLINE void dispatch_async_on_main_queue(void (^block)(void)) {
   
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

NS_INLINE void dispatch_sync_on_main_queue(void (^block)(void)) {
   
   if (pthread_main_np()) {
      
      block();
      
   } /* End if () */
   else {
      
      dispatch_sync(dispatch_get_main_queue(), block);
      
   } /* End else */
   
   return;
}

NS_INLINE void dispatch_async_on_background_queue(void (^block)(void)) {
   
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block);
   
   return;
}

NS_INLINE void dispatch_sync_on_background_queue(void (^block)(void)) {
   
   dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block);
   
   return;
}

#endif /* !YY_KIT */

NS_INLINE void dispatch_async_on_default_queue(void (^block)(void)) {
   
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
   
   return;
}

NS_INLINE void dispatch_sync_on_default_queue(void (^block)(void)) {
   
   dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
   
   return;
}

NS_INLINE void dispatch_after_on_main_queue(NSTimeInterval aDelayInSeconds, void (^block)(void)) {
   
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(aDelayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
   
   return;
}

NS_INLINE void dispatch_after_on_background_queue(NSTimeInterval aDelayInSeconds, void (^block)(void)) {
   
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(aDelayInSeconds * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block);
   
   return;
}

/**
Submits a block for asynchronous execution on a background queue and returns immediately.
*/
NS_INLINE void dispatch_async_on_global_queue(intptr_t identifier, void (^block)(void)) {
   
   dispatch_async(dispatch_get_global_queue(identifier, 0), block);
   
   return;
}

NS_INLINE dispatch_queue_global_t dispatch_get_background_queue(void) {
   
   return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
}

NS_INLINE dispatch_queue_global_t dispatch_get_global_queue_low(void) {
   
   return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
}

NS_INLINE dispatch_queue_global_t dispatch_get_global_queue_high(void) {
   
   return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
}

