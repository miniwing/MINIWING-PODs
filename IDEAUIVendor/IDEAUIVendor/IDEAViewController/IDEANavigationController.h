//
//  IDEANavigationController.h
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2021 Harry. All rights reserved.
//
//

#import <UIKit/UIKit.h>

#if __has_include(<RTRootNavigationController/RTRootNavigationController.h>)
#  import <RTRootNavigationController/RTRootNavigationController.h>
#  define RT_ROOT_NAVIGATIONCONTROLLER                                  (1)
#elif __has_include("RTRootNavigationController/RTRootNavigationController.h")
#  import "RTRootNavigationController/RTRootNavigationController.h"
#  define RT_ROOT_NAVIGATIONCONTROLLER                                  (1)
#elif __has_include("RTRootNavigationController.h")
#  import "RTRootNavigationController.h"
#  define RT_ROOT_NAVIGATIONCONTROLLER                                  (1)
#else
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

@end

@interface IDEANavigationController (Theme)

- (void)onThemeUpdate:(NSNotification *)aSender;

@end

NS_ASSUME_NONNULL_END
