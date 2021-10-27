//
//  IDEAPopTransitioningDelegate.h
//  IDEAPopController
//
//  Copyright © 2020 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <IDEAPopController/IDEAPopController.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEAPopTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, weak, readonly) IDEAPopController *popController;

- (instancetype)initWithPopController:(IDEAPopController *)popController NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
