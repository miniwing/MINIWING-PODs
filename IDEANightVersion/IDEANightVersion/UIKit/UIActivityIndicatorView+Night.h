//
//  UIActivityIndicatorView+Night.h
//  IDEANightVersion
//
//  Created by Harry on 2019/12/30.
//  Copyright © 2019 MINIWING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Night.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIActivityIndicatorView (Night)

@property (nonatomic, copy, setter = setColorPicker:) DKColorPicker colorPicker;

@end

NS_ASSUME_NONNULL_END
