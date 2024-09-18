//
//  CycleScrollViewCell.h
//  CycleScrollViewDemo
//
//  Created by QuintGao on 2019/9/15.
//  Copyright © 2019 QuintGao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CycleScrollViewCell;

typedef void(^didClickBlock)(NSInteger index);

@interface CycleScrollViewCell : UIView

/// 图片视图
@property (nonatomic, strong)                UIImageView                         * imageView;

/// 遮罩视图，用于处理透明度渐变
@property (nonatomic, strong)                UIView                              * coverView;

/// cell点击回调
@property (nonatomic, copy)                  didClickBlock                         onDidClick;

@end

@interface CycleScrollViewCell ()

- (void)setupCellFrame:(CGRect)frame;

@end
