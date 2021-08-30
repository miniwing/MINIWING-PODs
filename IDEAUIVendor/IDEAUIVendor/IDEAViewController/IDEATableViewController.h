//
//  IDEATableViewController.h
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2021 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEATableViewController : UITableViewController

@end

@interface IDEATableViewController (UIStoryboard)

@property (class, nonatomic, readonly)       NSString                            * storyboard;

@end

@interface IDEATableViewController (Theme)

- (void)onThemeUpdate:(NSNotification *)aNotification;

@end

NS_ASSUME_NONNULL_END
