//
//  IDEAViewController.h
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2021 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEAViewController : UIViewController

#if MATERIAL_APP_BAR

#endif /* MATERIAL_APP_BAR */

@end

@interface IDEAViewController (UIStoryboard)

@property (class, nonatomic, readonly)       NSString                            * storyboard;

@end

@interface IDEAViewController (Theme)

- (void)onThemeUpdate:(NSNotification *)aSender;

@end

NS_ASSUME_NONNULL_END
