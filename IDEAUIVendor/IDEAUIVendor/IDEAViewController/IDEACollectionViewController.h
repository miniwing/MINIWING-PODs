//
//  IDEACollectionViewController.h
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2024 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEACollectionViewController : UICollectionViewController

@end

typedef void (^KeyboardDoneBlock)(void);

@interface IDEACollectionViewController ()

@property (nonatomic, strong)                NSMutableDictionary<NSString *, KeyboardDoneBlock> * keyboardDoneBlocks;

@end

@interface IDEACollectionViewController (UIStoryboard)

@property (class, nonatomic, readonly)       NSString                            * storyboard;

@end

@interface IDEACollectionViewController (Theme)

- (void)onThemeUpdate:(NSNotification *)aSender;

@end

NS_ASSUME_NONNULL_END
