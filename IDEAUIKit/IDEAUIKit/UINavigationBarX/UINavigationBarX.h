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

@end

@interface UINavigationBarX ()

@property (nonatomic, assign) IBInspectable  CGFloat                               navigationBarTopInset;
@property (nonatomic, assign) IBInspectable  CGFloat                               navigationBarBottomInset;
@property (nonatomic, assign) IBInspectable  CGFloat                               navigationBarLeftInset;
@property (nonatomic, assign) IBInspectable  CGFloat                               navigationBarRightInset;

@end

NS_ASSUME_NONNULL_END
