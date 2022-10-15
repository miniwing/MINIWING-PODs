//
//  IDEAPresentationController.m
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2021 Harry. All rights reserved.
//

#import <UIKitExtension/UIKitExtension.h>

#import "IDEAPresentationController.h"

@interface IDEAPresentationController ()

@property (nonatomic, strong)                UIView                              * backgroundView;
@property (nonatomic, strong)                UITapGestureRecognizer              * tapGestureRecognizer;

@end

@implementation IDEAPresentationController

- (void)dealloc {
   
   __LOG_FUNCTION;
   
   // Custom dealloc
   [self removeAllNotifications];
   
   __SUPER_DEALLOC;
   
   return;
}

- (instancetype)initWithPresentedViewController:(UIViewController *)aPresentedViewController
                       presentingViewController:(UIViewController *)aPresentingViewController {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super initWithPresentedViewController:aPresentedViewController presentingViewController:aPresentingViewController];
   
   if (self) {
      
      if ([self backgroundTouchToClose]) {
         
         [self addNotificationName:[IDEAPresentationController BACKGROUND_TOUCH_NOTIFICATIN]
                          selector:@selector(__ON_BACKGROUND_TOUCH_NOTIFICATIN:)
                            object:nil];

      } /* End if () */
            
   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (void)presentationTransitionWillBegin {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [self.backgroundView setAlpha:0];
   [self.backgroundView setFrame:self.presentedView.frame];
   [self.containerView addSubview:self.backgroundView];
   
   [UIView animateWithDuration:UIAViewAnimationDefaultDuraton
                    animations:^{

      [self.backgroundView setAlpha:1];
   }];
   
   __CATCH(nErr);
   
   return;
}

- (void)presentationTransitionDidEnd:(BOOL)aCompleted {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;

   [self.containerView addGestureRecognizer:self.tapGestureRecognizer];
   
   __CATCH(nErr);
   
   return;
}

- (void)dismissalTransitionWillBegin {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [UIView animateWithDuration:UIAViewAnimationDefaultDuraton
                    animations:^{
      
      [self.backgroundView setAlpha:0];
   }];
   
   __CATCH(nErr);
   
   return;
}

- (void)dismissalTransitionDidEnd:(BOOL)aCompleted {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   if (aCompleted) {
      
      [self.backgroundView removeFromSuperview];
      
      [self.containerView removeGestureRecognizer:self.tapGestureRecognizer];

   } /* End if () */
   
   __CATCH(nErr);
   
   return;
}

- (CGRect)frameOfPresentedViewInContainerView {
         
//   if ([self.presentedViewController respondsToSelector:@selector(frameOfPresented)]) {
//
////      NSMethodSignature *stSignature   = [self.presentedViewController methodSignatureForSelector:stSelector];
////      NSInvocation      *stInvocation  = [NSInvocation invocationWithMethodSignature:stSignature];
////
////      [stInvocation setTarget:self.presentedViewController];
////      [stInvocation setSelector:stSelector];
////
////      NSObject *stResult   = nil;
////
////      [stInvocation invoke];
////
////      [stInvocation getReturnValue:&stResult];
////
////      id  stReturnValue = nil;
////      //signature.methodReturnLength == 0 说明给方法没有返回值
////      if (0 < stSignature.methodReturnLength) {
////
////         //获取返回值
////         [stInvocation getReturnValue:&stReturnValue];
////
////      } /* End if () */
//
////      NSValue  *stValue = [self.presentedViewController performSelector:@selector(frameOfPresented)];
////      CGRect    stFrame = [self.presentedViewController frameOfPresented];
////      LogDebug((@"[IDEAPresentationController frameOfPresentedViewInContainerView] : Result : %@", stValue));
//
//      return [self.presentedViewController frameOfPresented];
//
//   } /* End if () */
   
   if ([self.presentedViewController respondsToSelector:@selector(frameOfPresented)]) {
            
      return [self.presentedViewController frameOfPresented];
      
   } /* End if () */
   
   return CGRectZero;
}

- (BOOL)backgroundTouchToClose {
   
   return [self.presentedViewController backgroundTouchToClose];
}

- (UIView *)backgroundView {
   
   if (nil == _backgroundView) {
      
      _backgroundView   = [[UIView alloc] init];
      
#if IDEA_NIGHT_VERSION_MANAGER
//      [_backgroundView setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor translucentBackground])];
#else /* IDEA_NIGHT_VERSION_MANAGER */
//      [_backgroundView setBackgroundColor:[UIColor.blackColor colorWithAlphaComponent:0.5]];
#endif /* !IDEA_NIGHT_VERSION_MANAGER */

      [_backgroundView setBackgroundColor:[UIColor.blackColor colorWithAlphaComponent:0.5]];

//      [_backgroundView addGestureRecognizer:self.tapGestureRecognizer];
      
   } /* End if () */
   
   return _backgroundView;;
}

- (UITapGestureRecognizer *)tapGestureRecognizer {
   
   if (nil == _tapGestureRecognizer) {
      
      _tapGestureRecognizer   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundTouch:)];
      
   } /* End if () */
   
   return _tapGestureRecognizer;;
}

- (void)onBackgroundTouch:(UITapGestureRecognizer *)aSender {
   
   [self postNotificationName:[IDEAPresentationController BACKGROUND_TOUCH_NOTIFICATIN] object:nil];
   
   return;
}

- (void)__ON_BACKGROUND_TOUCH_NOTIFICATIN:(NSNotification *)aSender {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [self.presentedViewController dismissViewControllerAnimated:YES
                                                    completion:nil];
   
   __CATCH(nErr);
   
   return;
}

+ (NSString *)BACKGROUND_TOUCH_NOTIFICATIN {
   
   return [[self class] notificationName:@"BACKGROUND.TOUCH"];
}

@end

#pragma mark - UIStoryboard
@implementation IDEAPresentationController (UIStoryboard)

+ (NSString *)storyboard {
   
   return @"";
}

@end

@implementation UIViewController (PopUp)

- (void)popUp:(UIViewController *)aViewController {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [aViewController setModalPresentationStyle:UIModalPresentationCustom];
   [aViewController setTransitioningDelegate:self];
      
   [self presentViewController:aViewController
                      animated:YES
                    completion:^{

      LogDebug((@"[UIViewController(PopUp) popUp:] : TransitioningDelegate : %@", aViewController.transitioningDelegate));
   }];
   
   __CATCH(nErr);
   
   return;
}

- (void)popUp:(UIViewController *)aViewController animated: (BOOL)aAnimated completion:(void (^ __nullable)(void))aCompletion {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [aViewController setModalPresentationStyle:UIModalPresentationCustom];
   [aViewController setTransitioningDelegate:self];
   
   [self presentViewController:aViewController
                      animated:aAnimated
                    completion:aCompletion];
   
   __CATCH(nErr);
   
   return;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)aPresentedViewController
                                                      presentingViewController:(UIViewController *)aPresentingViewController
                                                          sourceViewController:(UIViewController *)aSourceViewController {
   
   return [[IDEAPresentationController alloc] initWithPresentedViewController:aPresentedViewController
                                                     presentingViewController:aPresentingViewController];
}

#pragma mark - <IDEAPresentationControllerDelegate>
- (CGRect)frameOfPresented {
   
   if (nil != self.navigationController) {
      
      if (nil != self.navigationController.visibleViewController) {
         
         return CGRectMake(15, self.navigationController.visibleViewController.view.height - 400, self.navigationController.visibleViewController.view.width - 15 * 2, 400);

      } /* End if () */
      
      if (nil != self.navigationController.topViewController) {
         
         return CGRectMake(15, self.navigationController.topViewController.view.height - 400, self.navigationController.topViewController.view.width - 15 * 2, 400);

      } /* End if () */
      
   } /* End if () */
   
   return CGRectMake(15, self.view.height - 400, self.view.width - 15 * 2, 400);
}

- (BOOL)backgroundTouchToClose {
      
   return YES;
}

@end
