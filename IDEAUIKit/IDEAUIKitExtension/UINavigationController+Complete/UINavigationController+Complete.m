//
//  UINavigationController+Complete.m
//  UINavigationController+Complete
//
//  Created by Harry on 2021/3/1.
//  Copyright © 2024 Harry. All rights reserved.
//

#import "UINavigationController+Complete.h"

#import <IDEAKit/IDEAUtils.h>

@implementation UINavigationController (Complete)

- (void)pushViewController:(UIViewController *)aViewController
                  animated:(BOOL)aAnimated
                completion:(nullable void (^)(void))aCompletion {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;

//   [CATransaction begin];
//
//   [self pushViewController:aViewController
//                   animated:aAnimated];
//
//   [CATransaction setCompletionBlock:^{
//
//      if (nil != aCompletion) {
//
////         [CATransaction setCompletionBlock:aCompletion];
//         dispatch_async_on_main_queue(aCompletion);
//
//      } /* End if () */
//   }];
//   [CATransaction commit];

   [self pushViewController:aViewController
                   animated:aAnimated];

   if (aAnimated) {
      
      [self.transitionCoordinator animateAlongsideTransition:nil
                                                  completion:^(id<UIViewControllerTransitionCoordinatorContext> aContext) {

         if (nil != aCompletion) {

            aCompletion();
            
         } /* End if () */
      }];

   } /* End if () */
   else {
      
      if (nil != aCompletion) {
         
         dispatch_async_on_main_queue(aCompletion);
         
      } /* End if () */

   } /* End else */
      
   __CATCH(nErr);
   
   return;
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)aAnimated
                                              completion:(nullable void (^)(void))aCompletion {
   
   int                            nErr                                     = EFAULT;
   
   UIViewController              *stViewController                         = nil;
   
   __TRY;
   
//   [CATransaction begin];
//   stViewController  = [self popViewControllerAnimated:aAnimated];
//
//   [CATransaction setCompletionBlock:^{
//
//      if (nil != aCompletion) {
//
////         [CATransaction setCompletionBlock:aCompletion];
//         dispatch_async_on_main_queue(aCompletion);
//
//      } /* End if () */
//   }];
//
//   [CATransaction commit];

   stViewController  = [self popViewControllerAnimated:aAnimated];

   if (aAnimated) {
      
      [self.transitionCoordinator animateAlongsideTransition:nil
                                                  completion:^(id<UIViewControllerTransitionCoordinatorContext> aContext) {

         if (nil != aCompletion) {
            
            aCompletion();
            
         } /* End if () */
      }];

   } /* End if () */
   else {
      
      if (nil != aCompletion) {
         
         dispatch_async_on_main_queue(aCompletion);
         
      } /* End if () */
      
   } /* End else */
   
   __CATCH(nErr);
   
   return stViewController;
}

@end
