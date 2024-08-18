//
//  IDEAAlertController+Theme.m
//  IDEAUIVendor
//
//  Created by Harry on 2022/6/21.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <IDEAKit/IDEAKit.h>

#import "IDEAAlertController+Inner.h"
#import "IDEAAlertController+Theme.h"

#pragma mark - UITheme
@implementation IDEAAlertController (Theme)

- (void)onThemeUpdate:(NSNotification *)aNotification {

   int                            nErr                                     = EFAULT;

   UIView                        *stContentView                            = nil;

   UIColor                       *stBackgroundColor                        = UIColor.whiteColor;
   
   __block UIVisualEffectView    *stVisualEffectView                       = nil;
   UIBlurEffectStyle              eBlurEffectStyle                         = UIBlurEffectStyleLight;
   UIUserInterfaceStyle           eUserInterfaceStyle                      = UIUserInterfaceStyleLight;

   NSAttributedString            *stTitle                                  = nil;
   NSAttributedString            *stMessage                                = nil;
   NSMutableDictionary<NSString *, id> *stTitleAttributes                  = [NSMutableDictionary dictionary];
   
   __TRY;
   
   LogDebug((@"-[IDEAAlertController onThemeUpdate:] : Notification : %@", aNotification));

//   if ([DKThemeVersionNight isEqualToString:[DKNightVersionManager sharedManager].themeVersion]) {
//      
//      eBlurEffectStyle     = UIBlurEffectStyleDark;
//      eUserInterfaceStyle  = UIUserInterfaceStyleDark;
//      
//      stBackgroundColor    = UIColor.blackColor;
//
//   } /* End if () */
//
//   [stTitleAttributes setObject:[IDEAColor colorWithKey:[IDEAColor label]]
//                         forKey:NSForegroundColorAttributeName];
//   [stTitleAttributes setObject:[IDEAColor colorWithKey:[IDEAColor label]]
//                         forKey:UITextAttributeTextColor];
//
//   stTitle     = [NSAttributedString attributedStringWithString:self.title
//                                                     attributes:stTitleAttributes];
//   
//   stMessage   = [NSAttributedString attributedStringWithString:self.message
//                                                     attributes:stTitleAttributes];
//
//   [self setValue:stTitle forKey:@"attributedTitle"];
//   [self setValue:stMessage forKey:@"attributedMessage"];
//
//   @try {
//      
//      stContentView  = [self.view valueForKey:@"_contentView"];
//
//   } /* End try */
//   @catch (NSException *_Exception) {
//
//   } /* End catch (NSException) */
//   @finally {
//      
//      if (nil != stContentView) {
//         
//         [stContentView setCornerRadius:16
//                          clipsToBounds:YES];
//         [stContentView setBackgroundColor:stBackgroundColor];
//         
//      } /* End if () */
//      
//   } /* End finally */
//
////   stVisualEffectView  = [UIVisualEffectView appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class, IDEAAlertController.class]];
//   stVisualEffectView  = [UIVisualEffectView appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]];
//   LogDebug((@"-[IDEAAlertController onThemeUpdate:] : UIVisualEffectView : %@", stVisualEffectView));
//
//   if (@available(iOS 13, *)) {
//      
//      self.overrideUserInterfaceStyle  = eUserInterfaceStyle;
//
//   } /* End if () */
//
//   [stVisualEffectView setBackgroundColor:stBackgroundColor];
//   [stVisualEffectView.contentView setBackgroundColor:stBackgroundColor];
//   [stVisualEffectView setEffect:[UIBlurEffect effectWithStyle:eBlurEffectStyle]];
//   
//   [stVisualEffectView.contentView setHidden:YES];
//   [stVisualEffectView setHidden:YES];
//   
//   [stVisualEffectView.contentView setHidden:NO];
//   [stVisualEffectView setHidden:NO];
//
//   if (self.themeBlock) {
//      
//      self.themeBlock(self, self.actions);
//
//   } /* End if () */
//   
////   for (UIView *stViewEx in stVisualEffectView.subviews) {
////      
////      [stViewEx setHidden:YES];
////
////   } /* End for () */
////   
////   DISPATCH_ASYNC_ON_MAIN_QUEUE(^{
////
////      for (UIView *stViewEx in stVisualEffectView.subviews) {
////         
////         [stViewEx setHidden:NO];
////
////      } /* End for () */
////
////      return;
////   });
//
//   [self.view setNeedsDisplay];
   [self setNeedsStatusBarAppearanceUpdate];

   __CATCH(nErr);

   return;
}

#pragma mark - UIStatusBar
- (UIUserInterfaceStyle)overrideUserInterfaceStyle {
   
   LogView((@"-[%@ preferredStatusBarStyle]", [self class]));
   
   if ([DKThemeVersionNight isEqualToString:[DKNightVersionManager sharedManager].themeVersion]) {

      return UIUserInterfaceStyleDark;
      
   } /* End if () */
   else { // if ([[DKNightVersionManager sharedManager].themeVersion isEqualToString:DKThemeVersionNormal])
      
      return UIUserInterfaceStyleLight;

   } /* End if () */
}

- (UIStatusBarStyle)preferredStatusBarStyle {

   LogView((@"-[%@ preferredStatusBarStyle]", [self class]));
   
   if ([DKThemeVersionNight isEqualToString:[DKNightVersionManager sharedManager].themeVersion]) {

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

   return UIInterfaceOrientationMaskAll;
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
