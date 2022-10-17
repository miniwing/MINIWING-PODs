//
//  IDEATabBarController.m
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "IDEATabBarController.h"

@interface IDEATabBarController ()

@end

@implementation IDEATabBarController

- (void)dealloc {
   
   __LOG_FUNCTION;
   
   // Custom dealloc
#if IDEA_NIGHT_VERSION_MANAGER
   [self removeNotificationName:DKNightVersionThemeChangingNotification
                         object:nil];
#endif /* IDEA_NIGHT_VERSION_MANAGER */

   [self removeAllNotifications];

   __SUPER_DEALLOC;
   
   return;
}

- (instancetype)initWithCoder:(NSCoder *)aCoder {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super initWithCoder:aCoder];
   
   if (self) {

#if IDEA_NIGHT_VERSION_MANAGER
#  pragma clang diagnostic push
#  pragma clang diagnostic ignored "-Wundeclared-selector"
   [self addNotificationName:DKNightVersionThemeChangingNotification
                    selector:@selector(onThemeUpdate:)
                      object:nil];
#  pragma clang diagnostic pop
#endif /* IDEA_NIGHT_VERSION_MANAGER */

   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (void)viewDidLoad {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super viewDidLoad];
   
   // Do any additional setup after loading the view.
#if IDEA_NIGHT_VERSION_MANAGER
   [self.tabBar setTintColorPicker:DKColorPickerWithKey([IDEAColor appTabbarTint])];
   [self.tabBar setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor appTabbarBackground])];
   [self.tabBar setBarTintColorPicker:DKColorPickerWithKey([IDEAColor appTabbarBackground])];
   
   [self.tabBar setBackgroundImage:[UIImage new]];
   [self.tabBar setShadowImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
      
      return [UIImage imageWithColor:[IDEAColor colorWithKey:[IDEAColor separator]] size:CGSizeMake(1, 0.5)];
   }];
#else /* IDEA_NIGHT_VERSION_MANAGER */
   [self.tabBar setTintColor:UIColor.appTabbarTintColor];
   [self.tabBar setBackgroundColor:UIColor.appTabbarBackgroundColor];
   [self.tabBar setBarTintColor:UIColor.appTabbarBackgroundColor];
   
   [self.tabBar setBackgroundImage:[UIImage new]];
   [self.tabBar setShadowImage:[UIImage imageWithColor:[IDEAColor colorWithKey:[IDEAColor separator]] size:CGSizeMake(1, 0.5)]];
#endif /* !IDEA_NIGHT_VERSION_MANAGER */
   
   __CATCH(nErr);
   
   return;
}

- (void)didReceiveMemoryWarning {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
   
   __CATCH(nErr);
   
   return;
}

- (void)viewWillAppear:(BOOL)aAnimated {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super viewWillAppear:aAnimated];
   
   __CATCH(nErr);
   
   return;
}

- (void)viewDidAppear:(BOOL)aAnimated {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super viewDidAppear:aAnimated];
   
   __CATCH(nErr);
   
   return;
}

- (void)viewWillDisappear:(BOOL)aAnimated {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super viewWillDisappear:aAnimated];
   
   __CATCH(nErr);
   
   return;
}

- (void)viewDidDisappear:(BOOL)aAnimated {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super viewDidDisappear:aAnimated];
   
   __CATCH(nErr);
   
   return;
}

#pragma mark - UIStoryboardSegue
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)aSegue sender:(id)aSender {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   // Get the new view controller using [aSegue destinationViewController].
   // Pass the selected object to the new view controller.
   
   __CATCH(nErr);
   
   return;
}

//#pragma mark - UIStatusBar
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//   LogDebug((@"-[%@ preferredStatusBarStyle]", [self class]));
//
//   return UIStatusBarStyleLightContent;
//}
//
//- (BOOL)prefersStatusBarHidden
//{
//   LogDebug((@"-[%@ prefersStatusBarHidden]", [self class]));
//
//   return NO;
//}
//
//- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
//{
//   LogDebug((@"-[%@ preferredStatusBarUpdateAnimation]", [self class]));
//
//   return UIStatusBarAnimationFade;
//}
//
//- (BOOL)shouldAutorotate
//{
//   LogDebug((@"-[%@ shouldAutorotate]", [self class]));
//
//   return NO;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//   LogDebug((@"-[%@ supportedInterfaceOrientations]", [self class]));
//
//   return UIInterfaceOrientationMaskPortrait;
//}
//
//// Controls the application's preferred home indicator auto-hiding when this view controller is shown.
//- (BOOL)prefersHomeIndicatorAutoHidden
//{
//   LogDebug((@"-[%@ prefersHomeIndicatorAutoHidden]", [self class]));
//
//   return YES;
//}
//
//- (UIModalPresentationStyle)modalPresentationStyle
//{
//   LogDebug((@"-[%@ modalPresentationStyle]", [self class]));
//
//   return UIModalPresentationFullScreen;
//}

@end

#pragma mark - UIStoryboard
@implementation IDEATabBarController (UIStoryboard)

+ (NSString *)storyboard {
   
   return @"";
}

+ (NSString *)bundle {
   
   return @"";
}

@end

#pragma mark - UITheme
@implementation IDEATabBarController (Theme)

- (void)onThemeUpdate:(NSNotification *)aNotification {
   
   int                            nErr                                     = EFAULT;
      
   __TRY;
   
   LogDebug((@"-[IDEATabBarController onThemeUpdate:] : Notification : %@", aNotification));
   
   [UIView animateWithDuration:DKNightVersionAnimationDuration
                    animations:^{
      
      [self setNeedsStatusBarAppearanceUpdate];
   }];
   
   __CATCH(nErr);
   
   return;
}

@end
