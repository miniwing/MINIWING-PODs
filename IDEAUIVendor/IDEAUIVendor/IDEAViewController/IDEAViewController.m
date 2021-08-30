//
//  IDEAViewController.m
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "IDEAViewController.h"

@implementation IDEAViewController

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

- (instancetype)initWithCoder:(NSCoder *)aCoder {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super initWithCoder:aCoder];
   
   if (self) {
      
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
   [self.view setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor systemBackground])];
#  pragma clang diagnostic push
#  pragma clang diagnostic ignored "-Wundeclared-selector"
   [self addNotificationName:DKNightVersionThemeChangingNotification
                    selector:@selector(onThemeUpdate:)
                      object:nil];
#  pragma clang diagnostic pop
#endif // #if IDEA_NIGHT_VERSION_MANAGER
   
#if IDEA_NAVIGATION_BAR
   [self wr_setNavBarTitleColor:[IDEAColor colorWithKey:[IDEAColor appNavigationBarTitle]]];
   [self wr_setNavBarTintColor:[IDEAColor colorWithKey:[IDEAColor appNavigationBarTint]]];
   [self wr_setNavBarBarTintColor:[IDEAColor colorWithKey:[IDEAColor appNavigationBarTint]]];
   [self.navigationController.navigationBar wr_setBackgroundColor:[IDEAColor colorWithKey:[IDEAColor systemBackground]]];
#endif /* IDEA_NAVIGATION_BAR */

#if 0
   [self.navigationController setNavigationBarHidden:NO];
   [self.navigationController.navigationBar setTranslucent:NO];
   [self.navigationController.navigationBar setOpaque:YES];
   [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.2666666667 green:0.4117647059 blue:0.6901960784 alpha:1]];
   [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.2666666667 green:0.4117647059 blue:0.6901960784 alpha:1]];
   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.2666666667 green:0.4117647059 blue:0.6901960784 alpha:1]]
                                                 forBarMetrics:UIBarMetricsDefault];
   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.2666666667 green:0.4117647059 blue:0.6901960784 alpha:1]]
                                                 forBarMetrics:UIBarMetricsCompact];
#endif /* 0 */

   __CATCH(nErr);
   
   return;
}

//- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures
//{
//   return UIRectEdgeBottom;
//}

@end

#pragma mark - UIStoryboard
@implementation IDEAViewController (UIStoryboard)

+ (NSString *)storyboard {
   
   return @"";
}

@end

#pragma mark - UITheme
@implementation IDEAViewController (Theme)

- (void)onThemeUpdate:(NSNotification *)aNotification {
   
   int                            nErr                                     = EFAULT;
      
   __TRY;
   
   LogDebug((@"[IDEAViewController onThemeUpdate:] : Notification : %@", aNotification));
   
//   if (UIUserInterfaceStyleDark == self.traitCollection.userInterfaceStyle) {
//
//      [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleDark];
//
//   } /* End if () */
//   else {
//
//      [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
//
//   } /* End else */

   [UIView animateWithDuration:DKNightVersionAnimationDuration
                    animations:^{
      
      [self setNeedsStatusBarAppearanceUpdate];
   }];
   
   __CATCH(nErr);
   
   return;
}

#pragma mark - UIUserInterfaceStyle
//- (UIUserInterfaceStyle)overrideUserInterfaceStyle {
//   
//   //   if (UIUserInterfaceStyleDark == self.traitCollection.userInterfaceStyle) {
//   //
//   //      return UIUserInterfaceStyleDark;
//   //
//   //   } /* End if () */
//   //   else {
//   //
//   //      return UIUserInterfaceStyleLight;
//   //
//   //   } /* End else */
//   
//   if ([[DKNightVersionManager sharedManager].themeVersion isEqualToString:DKThemeVersionNight]) {
//      
//      return UIUserInterfaceStyleDark;
//      
//   } /* End if () */
//   else { // if ([[DKNightVersionManager sharedManager].themeVersion isEqualToString:DKThemeVersionNormal])
//      
//      return UIUserInterfaceStyleLight;
//      
//   } /* End if () */
//}

@end
