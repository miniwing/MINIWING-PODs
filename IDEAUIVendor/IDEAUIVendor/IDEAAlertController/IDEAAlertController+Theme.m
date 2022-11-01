//
//  IDEAAlertController+Theme.m
//  IDEAUIVendor
//
//  Created by Harry on 2022/6/21.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAAlertController+Theme.h"

#pragma mark - UITheme
@implementation IDEAAlertController (Theme)

- (void)onThemeUpdate:(NSNotification *)aNotification {

   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   LogDebug((@"-[IDEAAlertController onThemeUpdate:] : Notification : %@", aNotification));

   [self setNeedsStatusBarAppearanceUpdate];

   __CATCH(nErr);

   return;
}

#pragma mark - UIStatusBar
- (UIUserInterfaceStyle)overrideUserInterfaceStyle {
   
   LogView((@"-[%@ preferredStatusBarStyle]", [self class]));
   
   if ([[DKNightVersionManager sharedManager].themeVersion isEqualToString:DKThemeVersionNight]) {

      return UIUserInterfaceStyleDark;
      
   } /* End if () */
   else { // if ([[DKNightVersionManager sharedManager].themeVersion isEqualToString:DKThemeVersionNormal])
      
      return UIUserInterfaceStyleLight;

   } /* End if () */
}

- (UIStatusBarStyle)preferredStatusBarStyle {

   LogView((@"-[%@ preferredStatusBarStyle]", [self class]));
   
   if ([[DKNightVersionManager sharedManager].themeVersion isEqualToString:DKThemeVersionNight]) {

      return UIStatusBarStyleLightContent;
      
   } /* End if () */
   else { // if ([[DKNightVersionManager sharedManager].themeVersion isEqualToString:DKThemeVersionNormal])

      if (@available(iOS 13, *)) {

         // 系统版本高于 13.0
         return UIStatusBarStyleDarkContent;
         
      } /* End if () */
      
      return UIStatusBarStyleDefault;

   } /* End if () */
}

- (BOOL)prefersStatusBarHidden {

   LogView((@"-[%@ prefersStatusBarHidden]", [self class]));

   return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {

   LogView((@"-[%@ preferredStatusBarUpdateAnimation]", [self class]));

   return UIStatusBarAnimationFade;
}

- (BOOL)shouldAutorotate {

   LogView((@"-[%@ shouldAutorotate]", [self class]));

   return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {

   LogView((@"-[%@ supportedInterfaceOrientations]", [self class]));

   return UIInterfaceOrientationMaskPortrait;
}

// Controls the application's preferred home indicator auto-hiding when this view controller is shown.
- (BOOL)prefersHomeIndicatorAutoHidden {

   LogView((@"-[%@ prefersHomeIndicatorAutoHidden]", [self class]));

   return YES;
}

- (UIModalPresentationStyle)modalPresentationStyle {
   
   LogView((@"-[%@ modalPresentationStyle]", [self class]));

   return UIModalPresentationFullScreen;
}

@end
