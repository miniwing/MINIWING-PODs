//
//  IDEAWaterDropView.h
//  Idea
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <UIKit/UIKit.h>

@interface IDEAWaterDropView : UIView

@property (nonatomic, strong)             CAShapeLayer                        * shapeLayer;
@property (nonatomic, strong)             CAShapeLayer                        * lineLayer;
@property (nonatomic, strong)             UIImageView                         * refreshView;

@property (nonatomic, assign, readonly)   BOOL                                  isRefreshing;

@property (nonatomic, assign)             float                                 waterTop;           // 水滴 距离底部的距离
@property (nonatomic, assign)             float                                 maxDropLength;      // 最长拖动距离
@property (nonatomic, assign)             float                                 radius;             // 水滴的半径

@property (nonatomic, copy)               void                                 (^handleRefreshEvent)(void);
@property (nonatomic, assign)             float                                 currentOffset;

@property (nonatomic, strong)             NSString                            * dropImage;

@end

@interface IDEAWaterDropView ()

//设置完参数后  需要手动调用此方法
- (void)loadWaterView;

- (void)stopRefresh;
- (void)startRefreshAnimation;

@end
