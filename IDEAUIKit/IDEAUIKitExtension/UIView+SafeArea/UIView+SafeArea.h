//
//  UIView+SafeArea.h
//  IDEAUIKit
//
//  Created by Harry on 2020/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SafeArea)

+ (UIEdgeInsets)safeArea;
- (UIEdgeInsets)safeArea;

@end

NS_ASSUME_NONNULL_END
