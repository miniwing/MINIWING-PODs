//
//  NSLayoutConstraint+Extension.h
//  IDEAKit
//
//  Created by Harry on 2021/6/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (Extension)

+ (NSLayoutConstraint *)constraintWithIdentifier:(NSString *)aIdentifier fromView:(UIView *)aView;
+ (NSArray<NSLayoutConstraint *> *)constraintsWithIdentifier:(NSString *)aIdentifier fromView:(UIView *)aView;

@end

NS_ASSUME_NONNULL_END
