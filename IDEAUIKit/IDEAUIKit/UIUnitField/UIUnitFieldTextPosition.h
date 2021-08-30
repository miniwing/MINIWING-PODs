//
//  UIUnitFieldTextPosition.h
//  UIUnitField
//
//  Created by Harry on 2019/9/18.
//  Copyright © 2019 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIUnitFieldTextPosition : UITextPosition <NSCopying>

@property (nonatomic, readonly) NSInteger offset;

+ (instancetype)positionWithOffset:(NSInteger)offset;

@end

NS_ASSUME_NONNULL_END
