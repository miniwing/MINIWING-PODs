//
//  IDEATabBarController.h
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2021 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEATabBarController : UITabBarController

@end

@interface IDEATabBarController (UIStoryboard)

@property (nonatomic, readonly, class)       NSString                            * storyboard;
@property (nonatomic, readonly, class)       NSString                            * bundle;

@end

@interface IDEATabBarController (Theme)

- (void)onThemeUpdate:(NSNotification *)aSender;

@end

NS_ASSUME_NONNULL_END
