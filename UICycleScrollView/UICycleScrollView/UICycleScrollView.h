//
//  UICycleScrollView.h
//  Idea
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail:iidioter@gmail.com
//  TEL :+(86)18668032582
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CycleScrollDirection) {
   
   CycleScrollHorizontal = 0,
   CycleScrollVertical,
};

#define Not_Auto                                   (0.0f)
#define ANIMATION_DURATION                         (5.0f)
//#define SLIDE_ANIMATION_DURATION                   UIAViewAnimationDefaultDuration
#define SLIDE_ANIMATION_DURATION                   [UIView animationDefaultDuration]

//IB_DESIGNABLE
@interface UICycleScrollView : UIView

@property (nonatomic, strong) IBOutlet       UIScrollView                     * scrollView;
@property (nonatomic, strong) IBOutlet       UIPageControl                    * pageControl;

@end

@interface UICycleScrollView ()

@property (nonatomic, assign) IBInspectable  NSTimeInterval                     animationDuration;
@property (nonatomic, assign) IBInspectable  NSTimeInterval                     slideAnimationDuration;
@property (nonatomic, assign) IBInspectable  CycleScrollDirection               cycleScrollDirection;

@property (nonatomic, assign) IBInspectable  NSInteger                          currentPageIndex;

@end

@interface UICycleScrollView ()
/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy)                 NSInteger                          (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy)                 UIView *                           (^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy)                 void                               (^tapActionBlock)(NSInteger pageIndex);

/**
 代理：第pageIndex个位置的操作
 **/
@property (nonatomic , copy)                 void                               (^operateAtIndex)(NSInteger pageIndex);
@end


@interface UICycleScrollView ()

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration slideAnimationDuration:(NSTimeInterval)slideAnimationDuration cycleScrollDirection:(CycleScrollDirection)direction;
- (void)reload;

@end
