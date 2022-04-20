//
//  UIView+Layout.h
//  UITableExcel_Example
//
//  Created by Mr.Yao on 2019/12/13.
//  Copyright © 2019 flyOfUI. All rights reserved.
//


#import <UIKit/UIKit.h>

@class UIColumnMode;


NS_ASSUME_NONNULL_BEGIN


@interface UIDrawLabel : UILabel
@property (strong, nonatomic) UIColor *borderColor;
@property (assign, nonatomic) CGFloat  borderWidth;
@end



@interface UIDrawButton : UIButton
@property (strong, nonatomic) UIColor *borderColor;
@property (assign, nonatomic) CGFloat  borderWidth;
@end


@interface UIView (Layout)

@property (nonatomic, strong) UIColumnMode * mode;

- (NSLayoutConstraint *)addConstraint:(NSLayoutAttribute)attribute equalTo:(nullable UIView *)to offset:(CGFloat)offset;
- (NSLayoutConstraint *)addConstraint:(NSLayoutAttribute)attribute equalTo:(nullable UIView *)to toAttribute:(NSLayoutAttribute)toAttribute offset:(CGFloat)offset;
- (void)addLayoutConstraint:(NSLayoutConstraint *)constraint;

@end

@interface UIView (UI_Draw)

@property (nonatomic, strong ,nullable) CALayer *yw_Layer;

- (void)__drawStroke:(CGRect)rect
         strokeColor:(UIColor *)strokeColor
           fillColor:(UIColor *)fillColor
           lineWidth:(CGFloat)lineWidth;

@end




@interface NSIndexPath (Colunmn)
@property (nonatomic, assign) NSInteger colunmn;

@end



NS_ASSUME_NONNULL_END
