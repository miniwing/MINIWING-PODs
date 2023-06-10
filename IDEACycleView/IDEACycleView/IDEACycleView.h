//
//  IDEACycleView.h
//  IDEACycleView
//
//  Created by uDoctor on 2019/12/4.
//  Copyright © 2019 UD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDEAPageControl.h"

NS_ASSUME_NONNULL_BEGIN

@class IDEACycleView;

@protocol IDEACycleViewDelegate <NSObject>

@optional
- (void)oBCycleView:(IDEACycleView *)cycleView itemIndex:(NSInteger)index;

@end

@interface IDEACycleView : UIView


/**
 推荐实例化

 @param frame frame
 @param pageControl 配置好的指示器
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame pageControl:(IDEAPageControl *)pageControl;
/**
 * 网络图片 url string 数组
 */
@property (nonatomic, copy) NSArray<UIView *> * views;

/**
 * item 点击的代理回调
 */
@property (nonatomic, weak) id<IDEACycleViewDelegate> delegate;


/**
 * 是否自动轮播，默认是自动轮播
 */
@property (nonatomic, assign) BOOL autoScroll;


/**
 * 自定义轮播时间，默认 5秒
 */
@property (nonatomic, assign) NSTimeInterval timeInterval;

/**
 每个item的间距，不要写太大，不然不好看
 */
@property (nonatomic, assign) CGFloat space;

@end

NS_ASSUME_NONNULL_END
