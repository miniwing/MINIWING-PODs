//
//  UINavigationBarX.h
//  IDEAUIKit
//
//  Created by Harry on 2022/3/25.
//
//  Mail: miniwing.hz@gmail.com
//

#import <MaterialComponents/MaterialNavigationBar.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//IB_DESIGNABLE
@interface UINavigationBarX : UIView

@property (nonatomic, weak)   IBOutlet       MDCNavigationBar                    * navigationBar;
@property (nonatomic, weak)   IBOutlet       UILabel                             * subTitleLabel;

@property (nonatomic, weak)   IBOutlet       UIView                              * splitView;

@property (nonatomic, weak)   IBOutlet       NSLayoutConstraint                  * navigationBarXHeight;

@end

@interface UINavigationBarX ()

@property (nonatomic, assign) IBInspectable  CGFloat                               navigationBarTopInset;
@property (nonatomic, assign) IBInspectable  CGFloat                               navigationBarBottomInset;
@property (nonatomic, assign) IBInspectable  CGFloat                               navigationBarLeftInset;
@property (nonatomic, assign) IBInspectable  CGFloat                               navigationBarRightInset;

@property (nonatomic, assign) IBInspectable  CGFloat                               splitViewTopInset;
@property (nonatomic, assign) IBInspectable  CGFloat                               splitViewBottomInset;
@property (nonatomic, assign) IBInspectable  CGFloat                               splitViewLeftInset;
@property (nonatomic, assign) IBInspectable  CGFloat                               splitViewRightInset;

@end

@interface UINavigationBarX ()

- (void)showLine:(BOOL)aShow;
- (void)showLine:(BOOL)aShow animated:(BOOL)aAnimated;

- (void)setSubTitle:(NSString *)aTitle;

@end

NS_ASSUME_NONNULL_END
