//
//  UITableViewCellX.m
//  IDEAUIKit
//
//  Created by Harry on 2022/3/19.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "UITableViewCellX.h"

@interface UITableViewCellX ()

@property (nonatomic, assign)                UIRectCorner                          rectCorner;

@end

@implementation UITableViewCellX

- (void)setRectCorner:(UIRectCorner)aRectCorner {
   
   _rectCorner = aRectCorner;
   
   return;
}

- (void)drawRect:(CGRect)aRect {
   
   [super drawRect:aRect];
   
   if (0 != self.rectCorner) {
      
      UIBezierPath   *stBezierPath  = [UIBezierPath bezierPathWithRoundedRect:self.containerView.bounds
                                                            byRoundingCorners:self.rectCorner
                                                                  cornerRadii:CGSizeMake(8, 8)];
      CAShapeLayer   *stMaskLayer   = [[CAShapeLayer alloc] init];
      stMaskLayer.frame = self.containerView.bounds;
      stMaskLayer.path  = stBezierPath.CGPath;
      
      [self.containerView.layer setMasksToBounds:YES];
      [self.containerView.layer setMask:stMaskLayer];

   } /* End if () */
   
   return;
}

@end
