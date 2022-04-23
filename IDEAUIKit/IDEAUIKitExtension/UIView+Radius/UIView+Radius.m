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
   
//   if (0 == aRadius) {
//
//      aRadius  = self.frame.size.height / 2;
//
//   } /* End if () */
//   
//   objc_setAssociatedObject(self, UIVIEW_ROUND_RADIUS, aRadius, OBJC_ASSOCIATION_RETAIN);
   
   [self setClipsToBounds:aClipsToBounds];
   
   [self.layer setMasksToBounds:YES];
   [self.layer setCornerRadius:aRadius];
   
   return;
}

- (void)setRectCorner:(UIRectCorner)aRectCorner radius:(CGFloat)aRadius {
      
   UIBezierPath   *stBezierPath  = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         byRoundingCorners:aRectCorner
                                                               cornerRadii:CGSizeMake(aRadius, aRadius)];
   CAShapeLayer   *stMaskLayer   = [[CAShapeLayer alloc] init];
   stMaskLayer.frame = self.bounds;
   stMaskLayer.path  = stBezierPath.CGPath;
   
   [self.layer setMasksToBounds:YES];
   [self.layer setMask:stMaskLayer];

   [self setNeedsLayout];
   [self layoutIfNeeded];

   return;
}

@end

