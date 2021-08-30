//
//  UIUnitFieldTextRange.m
//  UIUnitField
//
//  Created by Harry on 2019/9/18.
//  Copyright © 2019 Harry. All rights reserved.
//

#import "UIUnitFieldTextRange.h"

@implementation UIUnitFieldTextRange
@dynamic range;
@synthesize start = _start, end = _end;


+ (instancetype)rangeWithRange:(NSRange)range {
    if (range.location == NSNotFound)
        return nil;
    
    UIUnitFieldTextPosition *start = [UIUnitFieldTextPosition positionWithOffset:range.location];
    UIUnitFieldTextPosition *end = [UIUnitFieldTextPosition positionWithOffset:range.location + range.length];
    return [self rangeWithStart:start end:end];
}

+ (instancetype)rangeWithStart:(UIUnitFieldTextPosition *)start end:(UIUnitFieldTextPosition *)end {
    if (!start || !end) return nil;
    assert(start.offset <= end.offset);
    UIUnitFieldTextRange *range = [[self alloc] init];
    range->_start = start;
    range->_end = end;
    return range;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [UIUnitFieldTextRange rangeWithStart:_start end:_end];
}

- (NSRange)range {
    return NSMakeRange(_start.offset, _end.offset - _start.offset);
}

@end
