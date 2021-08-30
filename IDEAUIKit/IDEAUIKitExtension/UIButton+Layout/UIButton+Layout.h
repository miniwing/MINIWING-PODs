//
//  UIButton+Layout.h
//  Button
//
//  Created by chh on 2018/1/2.
//  Copyright © 2018年 chh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LayoutStatus) {
   
   /** 正常位置，图左字右 */
   LayoutStatusNormal,
   /** 图右字左 */
   LayoutStatusImageRight,
   /** 图上字下 */
   LayoutStatusImageTop,
   /** 图下字上 */
   LayoutStatusImageBottom,
};

@interface UIButton (Layout)

- (void)layoutWithStatus:(LayoutStatus)status andMargin:(CGFloat)margin contentMode:(UIViewContentMode)aContentMode;

@end

