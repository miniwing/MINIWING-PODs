//
//  UIView+Radius.h
//  UIView+Radius
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail:miniwing.hz@gmail.com
//  TEL :+(852)53054612
//

#import <UIKit/UIKit.h>

@interface UIView (Radius)

/**
 *  设置圆角半径
 *
 *  @param aRadius 0 正圆  > 0 倒角半径
 */
- (void)setCornerRadius:(CGFloat)aRadius clipsToBounds:(BOOL)aClipsToBounds;
- (void)setCornerRadius:(CGFloat)aRadius clipsToBounds:(BOOL)aClipsToBounds masksToBounds:(BOOL)aMasksToBounds;

- (void)setRectCorner:(UIRectCorner)aRectCorner radius:(CGFloat)aRadius;

@end

