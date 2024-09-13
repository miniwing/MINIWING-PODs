//
//  UIView+Radius.m
//  UIView+Radius
//
//  Created by Harry on 15/1/17.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "UIView+Radius.h"

#define UIVIEW_ROUND_RADIUS                  @"UIView+Round+Radius"

@implementation UIView (Radius)

//- (void)awakeFromNib {
//
//   NSNumber                      *stRadius                                 = nil;
//
//   [super awakeFromNib];
//
//   stRadius = objc_getAssociatedObject(self, UIVIEW_ROUND_RADIUS);
//
//   objc_setAssociatedObject(self, UIVIEW_ROUND_RADIUS, nil, OBJC_ASSOCIATION_RETAIN);
//
//   if (stRadius) {
//
//      [self.layer setMasksToBounds:YES];
//      [self.layer setCornerRadius:[stRadius floatValue]];
//
//   } /* End if () */
//
//   return;
//}

- (void)setCornerRadius:(CGFloat)aRadius clipsToBounds:(BOOL)aClipsToBounds {
   
//   [self setClipsToBounds:aClipsToBounds];
//   
//   [self.layer setMasksToBounds:YES];
//   [self.layer setCornerRadius:aRadius];
   
   [self setCornerRadius:aRadius clipsToBounds:aClipsToBounds masksToBounds:YES];
   
   return;
}

- (void)setCornerRadius:(CGFloat)aRadius clipsToBounds:(BOOL)aClipsToBounds masksToBounds:(BOOL)aMasksToBounds {
   
   [self setClipsToBounds:aClipsToBounds];
   
   [self.layer setMasksToBounds:aMasksToBounds];
   [self.layer setCornerRadius:aRadius];
   
   return;
}

- (void)setRectCorner:(UIRectCorner)aRectCorner radius:(CGFloat)aRadius {
   
   [self setRectCorner:aRectCorner radius:aRadius masksToBounds:YES];
   
   return;
}

- (void)setRectCorner:(UIRectCorner)aRectCorner radius:(CGFloat)aRadius masksToBounds:(BOOL)aMasksToBounds {
      
   UIBezierPath   *stBezierPath  = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         byRoundingCorners:aRectCorner
                                                               cornerRadii:CGSizeMake(aRadius, aRadius)];
   CAShapeLayer   *stMaskLayer   = [[CAShapeLayer alloc] init];
   stMaskLayer.frame = self.bounds;
   stMaskLayer.path  = stBezierPath.CGPath;
//   stMaskLayer.maskedCorners  = nil;
   
   [self.layer setMasksToBounds:aMasksToBounds];
   [self.layer setMask:stMaskLayer];
   
   // 提高性能
   [self.layer setShouldRasterize:YES];
   [self.layer setRasterizationScale:[UIScreen mainScreen].scale];

   [self setNeedsLayout];
   [self layoutIfNeeded];

   return;
}

@end

