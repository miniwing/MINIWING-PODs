//
//  UIImageView+Night.h
//  DKNightVersion
//
//  Created by Draveness on 15/12/10.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKNightVersionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Night)

- (instancetype)initWithImagePicker:(DKImagePicker)picker;

@property (nonatomic, copy, setter = setImagePicker:) DKImagePicker imagePicker;

@property (nonatomic, copy, setter = setAlphaPicker:) DKAlphaPicker alphaPicker;

@end

NS_ASSUME_NONNULL_END
