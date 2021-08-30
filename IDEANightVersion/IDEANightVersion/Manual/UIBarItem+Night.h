//
//  UIBarItem+Night.h
//  UIBarItem+Night
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and 
//  test it. And finally open a pull request.

#import <UIKit/UIKit.h>
#import "NSObject+Night.h"

@interface UIBarItem (Night)

@property (nonatomic, copy, setter = setImagePicker:) DKImagePicker imagePicker;
//@property (nonatomic, copy, setter = setSelectedImagePicker:) DKImagePicker selectedImagePicker;

- (void)setTitleTextAttributesPicker:(DKAttributesPicker)picker forState:(UIControlState)state;

@end
