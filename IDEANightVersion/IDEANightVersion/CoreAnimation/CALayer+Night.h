//
//  CALayer+Night.h
//  DKNightVersion
//
//  Created by Draveness on 16/1/29.
//  Copyright © 2016年 DeltaX. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NSObject+Night.h"

@interface CALayer (Night)

@property (nonatomic, copy) DKColorPicker shadowColorPicker;
@property (nonatomic, copy) DKColorPicker borderColorPicker;
@property (nonatomic, copy) DKColorPicker backgroundColorPicker;

@end
