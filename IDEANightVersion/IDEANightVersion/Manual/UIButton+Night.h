//
//  UIButton+Night.h
//  DKNightVersion
//
//  Created by Draveness on 15/12/9.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Night.h"

@interface UIButton (Night)

- (void)setTitleColorPicker:(DKColorPicker)picker forState:(UIControlState)state;

- (void)setBackgroundImagePicker:(DKImagePicker)picker forState:(UIControlState)state;

- (void)setImagePicker:(DKImagePicker)picker forState:(UIControlState)state;

@end
