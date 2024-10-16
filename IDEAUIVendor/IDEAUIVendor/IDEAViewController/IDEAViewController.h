//
//  IDEAViewController.h
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2024 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEAViewController : UIViewController

@end

typedef void (^KeyboardDoneBlock)(void);

@interface IDEAViewController ()

@property (nonatomic, strong)                NSMutableDictionary<NSString *, KeyboardDoneBlock> * keyboardDoneBlocks;

@end

@interface IDEAViewController (UIStoryboard)

@property (class, nonatomic, readonly)       NSString                            * storyboard;
@property (class, nonatomic, readonly)       NSString                            * bundle;

@end

@interface IDEAViewController (UINavigationBarX)

- (CGSize)intrinsicNavigationBarSize;

@end

@interface IDEAViewController (Theme)

- (void)onThemeUpdate:(NSNotification *)aSender;

@end

NS_ASSUME_NONNULL_END
