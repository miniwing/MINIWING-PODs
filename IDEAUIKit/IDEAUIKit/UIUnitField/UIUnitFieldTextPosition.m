//
//  UIUnitFieldTextPosition.m
//  UIUnitField
//
//  Created by Harry on 2019/9/18.
//  Copyright © 2019 MINIWING. All rights reserved.
//

#import "UIUnitFieldTextPosition.h"

@implementation UIUnitFieldTextPosition

+ (instancetype)positionWithOffset:(NSInteger)offset {
    UIUnitFieldTextPosition *position = [[self alloc] init];
    position->_offset = offset;
    return position;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [UIUnitFieldTextPosition positionWithOffset:self.offset];
}

@end
