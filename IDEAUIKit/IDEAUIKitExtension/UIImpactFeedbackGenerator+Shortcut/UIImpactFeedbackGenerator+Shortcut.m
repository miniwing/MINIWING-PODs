//
//  UIImpactFeedbackGenerator+Shortcut.m
//  UIImpactFeedbackGenerator+Shortcut
//
//  Created by Harry on 2021/7/21.
//

#import "UIImpactFeedbackGenerator+Shortcut.h"

@implementation UIImpactFeedbackGenerator (Shortcut)

/// call when your UI element impacts something else
+ (void)impactOccurredWithStyle:(UIImpactFeedbackStyle)aStyle {
   
   int                            nErr                                     = EFAULT;
   
   UIImpactFeedbackGenerator     *stImpactFeedbackGenerator                = nil;
   
   __TRY;

   stImpactFeedbackGenerator = [[UIImpactFeedbackGenerator cache] objectForKey:@(aStyle)];
   
   if (nil == stImpactFeedbackGenerator) {
      
      stImpactFeedbackGenerator  = [[UIImpactFeedbackGenerator alloc] initWithStyle:aStyle];
      
      [[UIImpactFeedbackGenerator cache] setObject:stImpactFeedbackGenerator
                                            forKey:@(aStyle)];

      [stImpactFeedbackGenerator prepare];

   } /* End if () */
      
   [stImpactFeedbackGenerator impactOccurred];

   __CATCH(nErr);
   
   return;
}

#ifdef __IPHONE_13_0
/// call when your UI element impacts something else with a specific intensity [0.0, 1.0]
+ (void)impactOccurredWithStyle:(UIImpactFeedbackStyle)aStyle Intensity:(CGFloat)aIntensity {
   
   int                            nErr                                     = EFAULT;
   
   UIImpactFeedbackGenerator     *stImpactFeedbackGenerator                = nil;
   
   __TRY;
         
   stImpactFeedbackGenerator = [[UIImpactFeedbackGenerator cache] objectForKey:@(aStyle)];
   
   if (nil == stImpactFeedbackGenerator) {
      
      stImpactFeedbackGenerator  = [[UIImpactFeedbackGenerator alloc] initWithStyle:aStyle];
      
      [[UIImpactFeedbackGenerator cache] setObject:stImpactFeedbackGenerator
                                            forKey:@(aStyle)];

      [stImpactFeedbackGenerator prepare];

   } /* End if () */

   [stImpactFeedbackGenerator impactOccurredWithIntensity:aIntensity];

   __CATCH(nErr);
   
   return;
}
#endif /* __IPHONE_13_0 */

+ (NSCache *)cache {
   
   static NSCache          *g_CACHE    = nil;
   static dispatch_once_t   onceToken;
   
   dispatch_once(&onceToken, ^{
      
      if (!g_CACHE) {
         
         g_CACHE  = [[NSCache alloc] init];
         
      } /* End if () */
   });
   
   return g_CACHE;
}

@end
