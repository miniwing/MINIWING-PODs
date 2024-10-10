//
//  IDEANavigationController.h
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2024 Harry. All rights reserved.
//
//

#import <UIKit/UIKit.h>

#if __has_include(<RTRootNavigationController/RTRootNavigationController-umbrella.h>)
#  import <RTRootNavigationController/RTRootNavigationController-umbrella.h>
#  define RT_ROOT_NAVIGATIONCONTROLLER                                  (1)
#elif __has_include("RTRootNavigationController/RTRootNavigationController-umbrella.h")
#  import "RTRootNavigationController/RTRootNavigationController-umbrella.h"
#  define RT_ROOT_NAVIGATIONCONTROLLER                                  (1)
#else
#  define rt_topViewController                                          topViewController
#  define rt_visibleViewController                                      visibleViewController
#  define rt_viewControllers                                            viewControllers
#  define rt_navigationController                                       navigationController
#  define RT_ROOT_NAVIGATIONCONTROLLER                                  (0)
#endif

NS_ASSUME_NONNULL_BEGIN

#if RT_ROOT_NAVIGATIONCONTROLLER
@interface IDEANavigationController : RTRootNavigationController
#else /* RT_ROOT_NAVIGATIONCONTROLLER */
@interface IDEANavigationController : UINavigationController
#endif /* !RT_ROOT_NAVIGATIONCONTROLLER */

@end

@interface IDEANavigationController (UIStoryboard)

@property (class, nonatomic, readonly)       NSString                            * storyboard;
@property (class, nonatomic, readonly)       NSString                            * bundle;

@end

@interface IDEANavigationController (Theme)

- (void)onThemeUpdate:(NSNotification *)aSender;

@end

NS_ASSUME_NONNULL_END
