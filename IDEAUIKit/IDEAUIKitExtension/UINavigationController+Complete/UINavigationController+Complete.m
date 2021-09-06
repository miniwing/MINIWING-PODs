//
//  UINavigationController+Complete.m
//  UINavigationController+Complete
//
//  Created by Harry on 2021/3/1.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "UINavigationController+Complete.h"

#import <IDEAKit/IDEAUtils.h>

@implementation UINavigationController (Complete)

- (void)pushViewController:(UIViewController *)aViewController
                  animated:(BOOL)aAnimated
                completion:(nullable void (^)(void))aCompletion {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [CATransaction begin];
   [self pushViewController:aViewController
                   animated:YES];
   
   [CATransaction setCompletionBlock:^{
      
      if (nil != aCompletion) {
         
//         [CATransaction setCompletionBlock:aCompletion];
         dispatch_async_on_main_queue(aCompletion);
         
      } /* End if () */
   }];
   [CATransaction commit];
   
   __CATCH(nErr);
   
   return;
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated
                                              completion:(nullable void (^)(void))aCompletion {
   
   int                            nErr                                     = EFAULT;
   
   UIViewController              *stViewController                         = nil;
   
   __TRY;
   
   [CATransaction begin];
   stViewController  = [self popViewControllerAnimated:YES];

   [CATransaction setCompletionBlock:^{
      
      if (nil != aCompletion) {
         
//         [CATransaction setCompletionBlock:aCompletion];
         dispatch_async_on_main_queue(aCompletion);
         
      } /* End if () */
   }];

   [CATransaction commit];
   
   __CATCH(nErr);
   
   return stViewController;
}

@end
