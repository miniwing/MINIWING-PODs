//
//  UIUnitFieldTextRange.h
//  UIUnitField
//
//  Created by Harry on 2019/9/18.
//  Copyright © 2019 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIUnitFieldTextPosition.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIUnitFieldTextRange : UITextRange <NSCopying>

@property (nonatomic, readonly) UIUnitFieldTextPosition *start;
@property (nonatomic, readonly) UIUnitFieldTextPosition *end;

@property (nonatomic, readonly) NSRange range;

+ (nullable instancetype)rangeWithStart:(UIUnitFieldTextPosition *)start end:(UIUnitFieldTextPosition *)end;

+ (nullable instancetype)rangeWithRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
