//
//  IDEANavAnimatedTransitioning.h
//  IDEAPopController
//
//  Copyright © 2020 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <IDEAPopController/IDEAPopController.h>

@class IDEANavAnimatedTransitioning;

NS_ASSUME_NONNULL_BEGIN



@interface IDEANavAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) IDEAPopState state;

- (instancetype)initWithState:(IDEAPopState)state NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
