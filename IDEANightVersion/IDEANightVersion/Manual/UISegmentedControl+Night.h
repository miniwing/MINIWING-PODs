//
//  UISegmentedControl+Night.h
//  DKNightVersion
//
//  Created by Draveness on 15/12/9.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Night.h"

@interface UISegmentedControl (Night)

- (void)setTitleTextAttributesPicker:(DKAttributesPicker)picker forState:(UIControlState)state;

@end
