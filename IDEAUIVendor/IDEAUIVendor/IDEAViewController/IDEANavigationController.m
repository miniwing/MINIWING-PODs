//
//  IDEANavigationController.m
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "IDEANavigationController.h"

@implementation IDEANavigationController

- (void)dealloc {
   
   __LOG_FUNCTION;
   
   // Custom dealloc
   
#if IDEA_NIGHT_VERSION_MANAGER
   [self removeNotificationName:DKNightVersionThemeChangingNotification
                         object:nil];
#endif /* IDEA_NIGHT_VERSION_MANAGER */

   [self removeAllNotification];
   
   __SUPER_DEALLOC;
   
   return;
}

- (void)viewDidLoad {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super viewDidLoad];
   // Do any additional setup after loading the view.
   
#if IDEA_NIGHT_VERSION_MANAGER
#  pragma clang diagnostic push
#  pragma clang diagnostic ignored "-Wundeclared-selector"
   [self addNotificationName:DKNightVersionThemeChangingNotification
                    selector:@selector(onThemeUpdate:)
                      object:nil];
#  pragma clang diagnostic pop
#endif // #if IDEA_NIGHT_VERSION_MANAGER

#if RT_ROOT_NAVIGATIONCONTROLLER
   self.useSystemBackBarButtonItem  = NO;
#endif /* !RT_ROOT_NAVIGATIONCONTROLLER */
   
#if RT_ROOT_NAVIGATIONCONTROLLER
#else /* RT_ROOT_NAVIGATIONCONTROLLER */
   [self.navigationBar setBarTintColor:UIColor.appNavigationBarTintColor];
   [self.navigationBar setBackgroundColor:UIColor.systemBackgroundColor];
   
#  if APP_NAVIGATION_BAR_BACKGROUND_IMAGE
   [self.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColor.systemBackgroundColor]
                            forBarMetrics:UIBarMetricsDefault];
   [self.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColor.systemBackgroundColor]
                            forBarMetrics:UIBarMetricsDefaultPrompt];
   [self.navigationBar setOpaque:APP_NAVIGATION_BAR_BACKGROUND_IMAGE];
   [self.navigationBar setTranslucent:!APP_NAVIGATION_BAR_BACKGROUND_IMAGE];
#  endif /* APP_NAVIGATION_BAR_BACKGROUND_IMAGE */
   //   [self.navigationBar setBackIndicatorImage:[UIImage new]];
   //   [self.navigationBar setBackIndicatorTransitionMaskImage:[UIImage new]];
#endif /* !RT_ROOT_NAVIGATIONCONTROLLER */
   
#if MATERIAL_APP_BAR
   [self setNavigationBarHidden:YES];
#endif /* MATERIAL_APP_BAR */
   
   __CATCH(nErr);
   
   return;
}

#pragma mark - PUSH & POP
- (void)pushViewController:(UIViewController *)aViewController animated:(BOOL)aAnimated {
   
   //   if (self.viewControllers.count > 0)
   //   {
   //      viewController.hidesBottomBarWhenPushed = YES;
   //   }
   
   CGRect   stFrame  = self.tabBarController.tabBar.frame;
   
   [super pushViewController:aViewController animated:aAnimated];
   
   if (aViewController.hidesBottomBarWhenPushed) {
      
      if ([UIDevice isiPhoneX] && self.tabBarController) {
         
//         if (!CGRectEqualToRect(stFrame, CGRectZero) && stFrame.origin.y != CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetHeight(stFrame))
         {
            
            stFrame.origin.y = CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetHeight(stFrame);
            
         } /* End if () */
         
         [self.tabBarController.tabBar setFrame:stFrame];
         
      } /* End if () */
      
      //      [self.tabBarController setTabbarHide:YES animate:YES complete:^(UITabBar * _Nonnull aTabBar, BOOL aComplete)
      //       {
      //          LogDebug((@"self.tabBarController.tabBar : %d", self.tabBarController.tabBar.isHidden));
      //       }];
      
   } /* End if () */
   
   return;
}

#if 0

- (UIViewController *)popViewControllerAnimated:(BOOL)aAnimated {
   
   CGRect             stFrame = self.tabBarController.tabBar.frame;
   UIViewController  *stPOP   = [super popViewControllerAnimated:aAnimated];
   
   if (stPOP.hidesBottomBarWhenPushed) {
      
      if ([UIDevice isiPhoneX] && self.tabBarController) {
         
         [self.tabBarController.tabBar setHidden:YES];
         
         stFrame.origin.y = CGRectGetHeight([UIScreen mainScreen].bounds);
         
         [self.tabBarController.tabBar setFrame:stFrame];
         
      } /* End if () */
      
      //      [self.tabBarController setTabbarHide:NO animate:YES complete:^(UITabBar * _Nonnull aTabBar, BOOL aComplete)
      //       {
      //          LogDebug((@"self.tabBarController.tabBar : %d", self.tabBarController.tabBar.isHidden));
      //       }];
      
   } /* End if () */
   
   return stPOP;
}

#endif

//#pragma mark - childViewController
//- (UIViewController *)childViewControllerForStatusBarStyle
//{
//   return self.topViewController;
//}
//
//- (UIViewController *)childViewControllerForStatusBarHidden
//{
//   return self.topViewController;
//}

//#pragma mark - Navigation
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)aSegue sender:(id)aSender {
//   
//   int                            nErr                                     = EFAULT;
//   
//   __TRY;
//   
//   // Get the new view controller using [segue destinationViewController].
//   // Pass the selected object to the new view controller.
//   LogDebug((@"[IDEANavigationController prepareForSegue:sender:] : Segue.identifier  : %@", aSegue.identifier));
//   LogDebug((@"[IDEANavigationController prepareForSegue:sender:] : Segue.source      : %@", aSegue.sourceViewController));
//   LogDebug((@"[IDEANavigationController prepareForSegue:sender:] : Segue.destination : %@", aSegue.destinationViewController));
//   
//   __CATCH(nErr);
//   
//   return;
//}
//
//#pragma mark - UIStatusBarStyle
//- (UIStatusBarStyle)preferredStatusBarStyle {
//   
//   LogView((@"[%@ preferredStatusBarStyle]", [self class]));
//   
//#if RT_ROOT_NAVIGATIONCONTROLLER
//   if ([self isKindOfClass:[RTRootNavigationController class]]) {
//      
//      if (nil != self.rt_visibleViewController) {
//         
//         return self.rt_visibleViewController.preferredStatusBarStyle;
//         
//      } /* End if () */
//      
//      return self.rt_topViewController.preferredStatusBarStyle;
//      
//   } /* End if () */
//#endif /* RT_ROOT_NAVIGATIONCONTROLLER */
//   
//   if (self.visibleViewController) {
//      
//      return [self.visibleViewController preferredStatusBarStyle];
//      
//   } /* End if () */
//   
//   return [self.topViewController preferredStatusBarStyle];
//}
//
//- (BOOL)prefersStatusBarHidden {
//   
//   LogView((@"[%@ prefersStatusBarHidden]", [self class]));
//   
//#if RT_ROOT_NAVIGATIONCONTROLLER
//   if ([self isKindOfClass:[RTRootNavigationController class]]) {
//      
//      if (nil != self.rt_visibleViewController) {
//         
//         return self.rt_visibleViewController.prefersStatusBarHidden;
//         
//      } /* End if () */
//      
//      return self.rt_topViewController.prefersStatusBarHidden;
//      
//   } /* End if () */
//#endif /* RT_ROOT_NAVIGATIONCONTROLLER */
//   
//   if (self.visibleViewController) {
//      
//      return [self.visibleViewController prefersStatusBarHidden];
//      
//   } /* End if () */
//   
//   return [self.topViewController prefersStatusBarHidden];
//}
//
//- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
//   
//   LogView((@"[%@ preferredStatusBarUpdateAnimation]", [self class]));
//   
//#if RT_ROOT_NAVIGATIONCONTROLLER
//   if ([self isKindOfClass:[RTRootNavigationController class]]) {
//      
//      if (nil != self.rt_visibleViewController) {
//         
//         return self.rt_visibleViewController.preferredStatusBarUpdateAnimation;
//         
//      } /* End if () */
//      
//      return self.rt_topViewController.preferredStatusBarUpdateAnimation;
//      
//   } /* End if () */
//#endif /* RT_ROOT_NAVIGATIONCONTROLLER */
//   
//   if (self.visibleViewController) {
//      
//      return [self.visibleViewController preferredStatusBarUpdateAnimation];
//      
//   } /* End if () */
//   
//   return [self.topViewController preferredStatusBarUpdateAnimation];
//}
//
////- (void)setNeedsStatusBarAppearanceUpdate
////{
////   LogView((@"[%@ setNeedsStatusBarAppearanceUpdate]", [self class]));
////
////   UIViewController        *stViewController          = nil;
////
////#if RT_ROOT_NAVIGATIONCONTROLLER
////   if ([self isKindOfClass:[RTRootNavigationController class]])
////   {
////      if (nil != self.rt_visibleViewController)
////      {
////         stViewController  = self.rt_visibleViewController;
////
////      } /* End if () */
////      else
////      {
////         stViewController  = self.rt_topViewController;
////
////      } /* End else */
////
////   } /* End if () */
////#endif /* RT_ROOT_NAVIGATIONCONTROLLER */
////
////   if (self.visibleViewController)
////   {
////      stViewController  = self.visibleViewController;
////
////   } /* End if () */
////   else if (self.topViewController)
////   {
////      stViewController  = self.topViewController;
////
////   } /* End else if () */
////
////   if ([stViewController respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
////   {
////      [UIView animateWithDuration:UIViewAnimationDefaultDuraton()
////                       animations:^
////       {
////          [stViewController performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
////       }];
////
////   } /* End if () */
////
////   return;
////}
//
//- (BOOL)shouldAutorotate {
//   
//   LogView((@"[%@ shouldAutorotate]", [self class]));
//   
//#if RT_ROOT_NAVIGATIONCONTROLLER
//   if ([self isKindOfClass:[RTRootNavigationController class]]) {
//      
//      if (nil != self.rt_visibleViewController) {
//         
//         return self.rt_visibleViewController.shouldAutorotate;
//         
//      } /* End if () */
//      
//      return self.rt_topViewController.shouldAutorotate;
//      
//   } /* End if () */
//#endif /* RT_ROOT_NAVIGATIONCONTROLLER */
//   
//   if (self.visibleViewController) {
//      
//      return [self.visibleViewController shouldAutorotate];
//      
//   } /* End if () */
//   
//   return self.topViewController.shouldAutorotate;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//   
//   LogView((@"[%@ supportedInterfaceOrientations]", [self class]));
//   
//#if RT_ROOT_NAVIGATIONCONTROLLER
//   if ([self isKindOfClass:[RTRootNavigationController class]]) {
//      
//      if (nil != self.rt_visibleViewController) {
//         
//         return self.rt_visibleViewController.supportedInterfaceOrientations;
//         
//      } /* End if () */
//      
//      return self.rt_topViewController.supportedInterfaceOrientations;
//      
//   } /* End if () */
//#endif /* RT_ROOT_NAVIGATIONCONTROLLER */
//   
//   if (self.visibleViewController) {
//      
//      return [self.visibleViewController supportedInterfaceOrientations];
//      
//   } /* End if () */
//   
//   return self.topViewController.supportedInterfaceOrientations;
//}
//
//// RT_ROOT_NAVIGATIONCONTROLLER
//// RTRootNavigationController.m
///*
// - (UIModalPresentationStyle)modalPresentationStyle {
// 
// return self.contentViewController.modalPresentationStyle;
// }
// */
//
//- (UIModalPresentationStyle)modalPresentationStyle {
//   
//   LogView((@"[%@ modalPresentationStyle]", [self class]));
//   
//#if RT_ROOT_NAVIGATIONCONTROLLER
//   if ([self isKindOfClass:[RTRootNavigationController class]]) {
//      
//      if (nil != self.rt_visibleViewController) {
//         
//         return self.rt_visibleViewController.modalPresentationStyle;
//         
//      } /* End if () */
//      
//      return self.rt_topViewController.modalPresentationStyle;
//      
//   } /* End if () */
//#endif /* RT_ROOT_NAVIGATIONCONTROLLER */
//   
//   if (self.visibleViewController) {
//      
//      return [self.visibleViewController modalPresentationStyle];
//      
//   } /* End if () */
//   
//   return self.topViewController.modalPresentationStyle;
//}

@end

#pragma mark - UIStoryboard
@implementation IDEANavigationController (UIStoryboard)

+ (NSString *)storyboard {
   
   return @"";
}

@end

#pragma mark - UITheme
@implementation IDEANavigationController (Theme)

- (void)onThemeUpdate:(NSNotification *)aNotification {

   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   LogDebug((@"-[IDEANavigationController onThemeUpdate:] : Notification : %@", aNotification));

   __CATCH(nErr);

   return;
}

@end

