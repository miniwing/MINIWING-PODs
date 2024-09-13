//
//  UIWindow+SafeArea.h
//  UIWindow+SafeArea
//
//  Created by Harry on 2020/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (SafeArea)

//+ (UIEdgeInsets)safeArea;
//- (UIEdgeInsets)safeArea;

@property (class, nonatomic, readonly)       UIEdgeInsets                          safeArea;

@property (class, nonatomic, readonly)       CGFloat                               topSafeAreaInset;
@property (class, nonatomic, readonly)       CGFloat                               bottomSafeAreaInset;

@end

NS_ASSUME_NONNULL_END
