//
//  UIButton+Layout.m
//  Button
//
//  Created by chh on 2018/1/2.
//  Copyright © 2018年 chh. All rights reserved.
//

#import "UIButton+Layout.h"

@implementation UIButton (Layout)

- (void)layoutWithStatus:(LayoutStatus)status andMargin:(CGFloat)margin contentMode:(UIViewContentMode)aContentMode {
   
   CGFloat   imgWidth   = self.imageView.bounds.size.width;
   CGFloat   imgHeight  = self.imageView.bounds.size.height;
   CGFloat   labWidth   = self.titleLabel.bounds.size.width;
   CGFloat   labHeight  = self.titleLabel.bounds.size.height;
   CGSize    textSize   = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
   CGSize    frameSize  = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
   
   if (labWidth < frameSize.width) {
      
      labWidth = frameSize.width;

   } /* End if () */

   CGFloat kMargin = margin / 2.0;
   switch (status) {
         
      case LayoutStatusNormal://图左字右
         [self setImageEdgeInsets:UIEdgeInsetsMake(0, -kMargin, 0, kMargin)];
         [self setTitleEdgeInsets:UIEdgeInsetsMake(0, kMargin, 0, -kMargin)];
         break;
      case LayoutStatusImageRight://图右字左
         [self setImageEdgeInsets:UIEdgeInsetsMake(0, labWidth + kMargin, 0, -labWidth - kMargin)];
         [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth - kMargin, 0, imgWidth + kMargin)];
         break;
      case LayoutStatusImageTop://图上字下
         [self setImageEdgeInsets:UIEdgeInsetsMake(0,0, labHeight + margin, -labWidth)];
         [self setTitleEdgeInsets:UIEdgeInsetsMake(imgHeight + margin, -imgWidth, 0, 0)];
         break;
      case LayoutStatusImageBottom://图下字上
         [self setImageEdgeInsets:UIEdgeInsetsMake(labHeight + margin,0, 0, -labWidth)];
         [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth, imgHeight + margin, 0)];
         break;
      default:
         break;
         
   } /* End switch () */
   
   [self.imageView setContentMode:aContentMode];
   [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
   
   return;
}

@end

