//
//  IDEAPopControllerAnimationContext.h
//  IDEAPopController
//
//  Copyright © 2020 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IDEAPopController/IDEAPopController.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEAPopAnimationContext : NSObject

@property (nonatomic, assign, readonly) IDEAPopState state;
@property (nonatomic, strong, readonly) UIView *containerView;
@property (nonatomic, assign) NSTimeInterval duration;

- (instancetype)initWithState:(IDEAPopState)state containerView:(UIView *)containerView;

@end

@interface IDEAPopControllerAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readonly) IDEAPopState state;
@property (nonatomic, weak, readonly) IDEAPopController *popController;

- (instancetype)initWithState:(IDEAPopState)state popController:(IDEAPopController *)popController NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
