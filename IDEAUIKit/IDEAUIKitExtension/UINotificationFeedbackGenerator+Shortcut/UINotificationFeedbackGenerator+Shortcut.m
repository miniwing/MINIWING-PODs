//
//  UINotificationFeedbackGenerator+Shortcut.m
//  UINotificationFeedbackGenerator+Shortcut
//
//  Created by Harry on 2021/7/21.
//

#import "UINotificationFeedbackGenerator+Shortcut.h"

@implementation UINotificationFeedbackGenerator (Shortcut)

+ (void)notificationOccurred:(UINotificationFeedbackType)aNotificationType {
   
   int                            nErr                                     = EFAULT;
      
   __TRY;
   
   [[UINotificationFeedbackGenerator notificationFeedbackGenerator] notificationOccurred:aNotificationType];

   __CATCH(nErr);
   
   return;
}

+ (UINotificationFeedbackGenerator *)notificationFeedbackGenerator {
   
   static UINotificationFeedbackGenerator *g_NOTIFICATION_FEEDBACK_GENERATOR  = nil;
   static dispatch_once_t                  onceToken;
   
   dispatch_once(&onceToken, ^{
      
      if (!g_NOTIFICATION_FEEDBACK_GENERATOR) {
         
         g_NOTIFICATION_FEEDBACK_GENERATOR   = [[UINotificationFeedbackGenerator alloc] init];
         [g_NOTIFICATION_FEEDBACK_GENERATOR prepare];
         
      } /* End if () */
   });
   
   return g_NOTIFICATION_FEEDBACK_GENERATOR;
}

@end
