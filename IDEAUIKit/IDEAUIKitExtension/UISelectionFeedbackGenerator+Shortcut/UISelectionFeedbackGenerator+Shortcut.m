//
//  UISelectionFeedbackGenerator+Shortcut.m
//  IDEAUIKit
//
//  Created by Harry on 2021/7/21.
//

#import "UISelectionFeedbackGenerator+Shortcut.h"

@implementation UISelectionFeedbackGenerator (Shortcut)

+ (void)selectionChanged {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [[UISelectionFeedbackGenerator selectionFeedbackGenerator] selectionChanged];
   
   __CATCH(nErr);
   
   return;
}

+ (UISelectionFeedbackGenerator *)selectionFeedbackGenerator {
   
   static UISelectionFeedbackGenerator *g_SELECTION_FEEDBACK_GENERATOR  = nil;
   static dispatch_once_t               onceToken;
   
   dispatch_once(&onceToken, ^{
      
      if (!g_SELECTION_FEEDBACK_GENERATOR) {
         
         g_SELECTION_FEEDBACK_GENERATOR   = [[UISelectionFeedbackGenerator alloc] init];
         [g_SELECTION_FEEDBACK_GENERATOR prepare];

      } /* End if () */
   });
   
   return g_SELECTION_FEEDBACK_GENERATOR;
}

@end
