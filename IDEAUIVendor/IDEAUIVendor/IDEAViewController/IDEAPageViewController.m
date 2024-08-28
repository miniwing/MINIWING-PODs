//
//  IDEAPageViewController.m
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2024 Harry. All rights reserved.
//

#import "IDEAPageViewController.h"

@interface IDEAPageViewController ()

@end

@implementation IDEAPageViewController

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
         
         return [IDEAColor colorWithKey:IDEAColor.systemBackground];

      } /* End if () */
      
      return [IDEAColor colorWithKey:IDEAColor.systemGroupedBackground];
   }];
#endif /* if IDEA_NIGHT_VERSION_MANAGER */
   
#if IDEA_NAVIGATION_BAR
   [self wr_setNavBarTitleColor:[IDEAColor colorWithKey:IDEAColor.appNavigationBarTitle]];
   [self wr_setNavBarTintColor:[IDEAColor colorWithKey:IDEAColor.appNavigationBarTint]];
   [self wr_setNavBarBarTintColor:[IDEAColor colorWithKey:IDEAColor.appNavigationBarTint]];
   [self.navigationController.navigationBar wr_setBackgroundColor:[IDEAColor colorWithKey:IDEAColor.systemBackground]];
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

@end

#pragma mark - UIStoryboard
@implementation IDEAPageViewController (UIStoryboard)

+ (NSString *)storyboard {
   
   return @"";
}

@end

#pragma mark - UITheme
@implementation IDEAPageViewController (Theme)

#pragma mark - UITheme
- (void)onThemeUpdate:(NSNotification *)aNotification {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   LogDebug((@"-[IDEAPageViewController onThemeUpdate:] : Notification : %@", aNotification));
   
#if IDEA_NAVIGATION_BAR
   [self wr_setNavBarTintColor:[APPColor colorWithKey:[APPColor appNavigationBarBackground]]];
   [self wr_setNavBarBarTintColor:[APPColor colorWithKey:[APPColor appNavigationBarTint]]];
   [self wr_setNavBarTitleColor:[APPColor colorWithKey:[APPColor appNavigationBarTitle]]];
   [self wr_setSystemNavBarTitleColor:[APPColor colorWithKey:[APPColor appNavigationBarTitle]]];
   [self.navigationController.navigationBar wr_setBackgroundColor:[APPColor colorWithKey:[APPColor appNavigationBarBackground]]];
#endif /* IDEA_NAVIGATION_BAR */
   
   [self setNeedsStatusBarAppearanceUpdate];

   __CATCH(nErr);
   
   return;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
      
   return UIStatusBarAnimationFade;
}

@end

