//
//  UINavigationController+Complete.h
//  UINavigationController+Complete
//
//  Created by Harry on 2021/3/1.
//  Copyright © 2024 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (Complete)

- (void)pushViewController:(UIViewController *)aViewController
                  animated:(BOOL)aAnimated
                completion:(nullable void (^)(void))aCompletion;

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated
                                              completion:(nullable void (^)(void))aCompletion;

@end

NS_ASSUME_NONNULL_END
