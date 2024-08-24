//
//  IDEATableViewController.m
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2024 Harry. All rights reserved.
//

#import "IDEATableViewController.h"

@implementation IDEATableViewController

- (void)dealloc {
   
   __LOG_FUNCTION;
   
   // Custom dealloc
   [self.keyboardDoneBlocks removeAllObjects];

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
   [self.view setBackgroundColorPicker:^UIColor *(DKThemeVersion *aThemeVersion) {
      
      if ([DKThemeVersionNight isEqualToString:aThemeVersion]) {
         
         return [IDEAColor colorWithKey:[IDEAColor systemBackground]];

      } /* End if () */
      
      return [IDEAColor colorWithKey:[IDEAColor systemGroupedBackground]];
   }];
   [self.tableView setBackgroundColorPicker:^UIColor *(DKThemeVersion *aThemeVersion) {
      
      if ([DKThemeVersionNight isEqualToString:aThemeVersion]) {
         
         return [IDEAColor colorWithKey:[IDEAColor systemBackground]];

      } /* End if () */
      
      return [IDEAColor colorWithKey:[IDEAColor systemGroupedBackground]];
   }];
//   [self.tableView setBackgroundColor:UIColor.clearColor];
#endif /* if IDEA_NIGHT_VERSION_MANAGER */
   
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

#pragma mark - (NSMutableDictionary<NSString *, KeyboardDoneBlock> *)keyboardDoneBlocks;
- (NSMutableDictionary<NSString *, KeyboardDoneBlock> *)keyboardDoneBlocks {
   
   if (nil == _keyboardDoneBlocks) {
      
      _keyboardDoneBlocks  = [NSMutableDictionary<NSString *, KeyboardDoneBlock> dictionary];
      
   } /* End if () */
   
   return _keyboardDoneBlocks;
}

//- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures
//{
//   return UIRectEdgeBottom;
//}

@end

#pragma mark - UIStoryboard
@implementation IDEATableViewController (UIStoryboard)

+ (NSString *)storyboard {
   
   return @"";
}

+ (NSString *)bundle {
   
   return @"";
}

@end

#pragma mark - UITheme
@implementation IDEATableViewController (Theme)

- (void)onThemeUpdate:(NSNotification *)aNotification {
   
   int                            nErr                                     = EFAULT;
      
   __TRY;
   
   LogDebug((@"-[IDEATableViewController onThemeUpdate:] : Notification : %@", aNotification));
      
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
//   if ([DKThemeVersionNight isEqualToString:[DKNightVersionManager sharedManager].themeVersion]) {
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
