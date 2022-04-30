//
//  UIView+Layout.m
//  UITableExcel_Example
//
//  Created by Mr.Yao on 2019/12/13.
//  Copyright © 2019 flyOfUI. All rights reserved.
//

#import "UIView+Layout.h"
#import <objc/runtime.h>


@implementation UIDrawLabel

- (void)drawRect:(CGRect)aRect {
   
   [super drawRect:aRect];
   
   [self __drawStroke:aRect
          strokeColor:self.borderColor
            fillColor:UIColor.clearColor
            lineWidth:self.borderWidth];
   
   return;
}

@end

@implementation UIDrawButton

- (void)drawRect:(CGRect)aRect {
   
   [super drawRect:aRect];
   
   [self __drawStroke:aRect
          strokeColor:self.borderColor
            fillColor:UIColor.clearColor
            lineWidth:self.borderWidth];
   
   return;
}

@end

@implementation UIView (Layout)

static char UIColumnModeKey;

- (UIColumnMode *)mode {
   return objc_getAssociatedObject(self, &UIColumnModeKey);
}
- (void)setMode:(UIColumnMode *)mode{
   objc_setAssociatedObject(self, &UIColumnModeKey, mode, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLayoutConstraint *)addConstraint:(NSLayoutAttribute)attribute equalTo:(UIView *)to offset:(CGFloat)offset {
   
   [self setTranslatesAutoresizingMaskIntoConstraints:NO];
   
   NSLayoutConstraint   *stLayoutConstraint  = [NSLayoutConstraint constraintWithItem:self
                                                                            attribute:attribute relatedBy:NSLayoutRelationEqual toItem:to
                                                                            attribute:attribute
                                                                           multiplier:1.0 constant:offset];
   
   [self.superview addConstraint:stLayoutConstraint];
   
   return stLayoutConstraint;
}

- (void)addLayoutConstraint:(NSLayoutConstraint *)constraint {
   
   [self.superview addConstraint:constraint];
   
}

- (NSLayoutConstraint *)addConstraint:(NSLayoutAttribute)attribute equalTo:(UIView *)to toAttribute:(NSLayoutAttribute)toAttribute offset:(CGFloat)offset {
   
   [self setTranslatesAutoresizingMaskIntoConstraints:NO];
   
   NSLayoutConstraint   *stLayoutConstraint  = [NSLayoutConstraint constraintWithItem:self
                                                                            attribute:attribute relatedBy:NSLayoutRelationEqual toItem:to
                                                                            attribute:toAttribute
                                                                           multiplier:1.0 constant:offset];
   
   [self.superview addConstraint:stLayoutConstraint];
   
   return stLayoutConstraint;
}

- (void)removeAllAutoLayout {
   
   for (NSLayoutConstraint *con in self.constraints) {
      
      [self removeConstraint:con];
   }
}

- (void)removeAutoLayout:(NSLayoutConstraint *)constraint{
   
   for (NSLayoutConstraint *con in self.superview.constraints) {
      
      if ([con isEqual:constraint]) {
         
         [self.superview removeConstraint:con];
      }
   }
}

- (NSLayoutConstraint *)getAutoLayoutByIdentifier:(NSString *)identifier{
   NSLayoutConstraint *lay = nil;
   for (NSLayoutConstraint *con in self.constraints)
   {
      if ([con.identifier isEqualToString:identifier]) {
         lay = con;
         break;
      }
   }
   return lay;
}
@end

@implementation UIView (UI_Draw)

static char kHssociatedParamsLayerKey;

//- (void)setYw_Layer:(CALayer *)yw_Layer {
//
//   objc_setAssociatedObject(self, &kHssociatedParamsLayerKey, yw_Layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (CALayer *)yw_Layer {
//
//   return objc_getAssociatedObject(self, &kHssociatedParamsLayerKey);
//}

- (void)__drawStroke:(CGRect)aRect
         strokeColor:(UIColor *)aStrokeColor
           fillColor:(UIColor *)aFillColor
           lineWidth:(CGFloat)aLineWidth {
   
   if (nil != aStrokeColor && aLineWidth != 0) {
      
      CGSize          stViewSize    = self.frame.size;
//      CAShapeLayer *maskLayer = [CAShapeLayer layer];
//      maskLayer.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);

      CAShapeLayer   *stShapeLayer  = nil;
                  
      for (CALayer *stLayer in self.layer.sublayers) {
         
         if ([stLayer.name isEqualToString:NSStringFromClass(CAShapeLayer.class)]) {
            
            stShapeLayer   = (CAShapeLayer *)stLayer;
            
            break;
         
         } /* End if () */
         
      } /* End for () */
      
      if (nil == stShapeLayer) {
         
         stShapeLayer   = [CAShapeLayer layer];

         [self.layer addSublayer:stShapeLayer];

      } /* End if () */

      stShapeLayer.frame         = CGRectMake(0, 0, stViewSize.width, stViewSize.height);
      stShapeLayer.fillColor     = aFillColor.CGColor;
      stShapeLayer.strokeColor   = aStrokeColor.CGColor;
      stShapeLayer.lineWidth     = aLineWidth;
      stShapeLayer.name          = NSStringFromClass(CAShapeLayer.class);
      
      UIBezierPath   *stBezierPath  = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, stViewSize.width, stViewSize.height)
                                                                 cornerRadius:0];
      stShapeLayer.path = stBezierPath.CGPath;

//      [self.layer insertSublayer:stShapeLayer atIndex:0];

//      [self.layer setMasksToBounds:YES];
//      [self.layer setMask:shapeLayer];
   }
   else {

//      NSArray<CALayer *> *stSublayers  =  [self.layer.sublayers copy];
//      for (CALayer *stLayer in stSublayers) {
         
//      for (CALayer *stLayer in self.layer.sublayers) {
//
//         if (nil != stLayer.superlayer) {
//
//            [stLayer removeFromSuperlayer];
//
//         } /* End if () */
//
//      } /* End for () */

      [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

   } /* End else */
   
   return;
}

@end

@implementation NSIndexPath (Colunmn)

static char YW_INDEXPATH_COLUMN_KEY;

- (NSInteger)colunmn {
   
   return [objc_getAssociatedObject(self, &YW_INDEXPATH_COLUMN_KEY) integerValue];
}

- (void)setColunmn:(NSInteger)colunmn {
   
   objc_setAssociatedObject(self, &YW_INDEXPATH_COLUMN_KEY, @(colunmn), OBJC_ASSOCIATION_ASSIGN);
   
   return;
}

@end
