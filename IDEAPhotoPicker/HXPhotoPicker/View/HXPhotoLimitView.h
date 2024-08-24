//
//  HXPhotoLimitView.h
//  HXPhotoPickerExample
//
//  Created by Slience on 2021/9/6.
//  Copyright © 2021 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXPhotoLimitView : UIView
@property (strong, nonatomic) UIVisualEffectView *bgView;
@property (strong, nonatomic) UILabel *textLb;
@property (strong, nonatomic) UIButton *settingButton;
@property (strong, nonatomic) UIButton *closeButton;
@end

@interface HXPhotoLimitView ()
- (void)setTextColor:(UIColor *)color;
- (void)setSettingColor:(UIColor *)color;
- (void)setCloseColor:(UIColor *)color;
- (void)setBlurEffectStyle:(UIBlurEffectStyle)style;
@end

NS_ASSUME_NONNULL_END
