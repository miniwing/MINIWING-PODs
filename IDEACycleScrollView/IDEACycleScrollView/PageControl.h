//
//  PageControl.h
//  CycleScrollViewDemo
//
//  Created by QuintGao on 2019/9/21.
//  Copyright © 2019 QuintGao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PageControlStyle) {
   
   PageControlStyleSystem,       // 系统，默认类型
   PageControlStyleCycle,        // 圆形
   PageControlStyleRectangle,    // 长方形
   PageControlStyleSquare,       // 正方形
   PageControlStyleSizeDot       // 大小点
};

@interface PageControl : UIPageControl

/// pageControl类型
@property (nonatomic, assign)                PageControlStyle                      style;

/// 以下属性在style为PageControlStyleSizeDot时有效
/// 默认8 长方形默认16
@property (nonatomic, assign)                CGFloat                               dotWidth;

/// 默认8 长方形默认2
@property (nonatomic, assign)                CGFloat                               dotHeight;

/// 默认8
@property (nonatomic, assign)                CGFloat                               dotMargin;

@end

NS_ASSUME_NONNULL_END
