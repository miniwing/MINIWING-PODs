//
//  UICollectionViewCellX.m
//  IDEAUIKit
//
//  Created by Harry on 2022/3/19.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "UICollectionViewCellX.h"

@interface UICollectionViewCellX ()

@property (nonatomic, assign)                UIRectCorner                          rectCorner;

//@property (nonatomic, strong)                NSLayoutConstraint                  * layoutConstraintL;
//@property (nonatomic, strong)                NSLayoutConstraint                  * layoutConstraintR;
//
//@property (nonatomic, assign)                CGFloat                               layoutConstraintLeftInset;
//@property (nonatomic, assign)                CGFloat                               layoutConstraintRightInset;

@end

@implementation UICollectionViewCellX

- (void)awakeFromNib {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super awakeFromNib];
   // Initialization code
   
   [self setBackgroundColor:UIColor.clearColor];
   [self.contentView setBackgroundColor:UIColor.clearColor];
   
   self.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];// 这句不可省略
//   [self.selectedBackgroundView setSize:CGSizeZero];
   [self.selectedBackgroundView setBackgroundColor:UIColor.clearColor];
   [self.selectedBackgroundView setClipsToBounds:YES];

   [self.containerView setClipsToBounds:YES];
   
//   self.layoutConstraintLeftInset   = [UICollectionViewCellX constraintLeftInset];
//   self.layoutConstraintRightInset  = [UICollectionViewCellX constraintRightInset];
   
   [self.containerView setBackgroundColorPicker:^UIColor *(DKThemeVersion *aThemeVersion) {
      
      if ([DKThemeVersionNight isEqualToString:aThemeVersion]) {
         
         return [IDEAColor colorWithKey:[IDEAColor tertiarySystemGroupedBackground]];
         
      } /* End if () */
      
      return [IDEAColor colorWithKey:[IDEAColor systemBackground]];
   }];
   
//   for (NSLayoutConstraint *stConstraint in self.contentView.constraints) {
//
//      if (([stConstraint.firstItem isEqual:self.containerView] && [stConstraint.secondItem isEqual:self.contentView])
//          || ([stConstraint.secondItem isEqual:self.containerView] && [stConstraint.firstItem isEqual:self.contentView])) {
//
//         if (NSLayoutAttributeLeading == stConstraint.firstAttribute && NSLayoutAttributeLeading == stConstraint.secondAttribute) {
//
//            self.layoutConstraintL  = stConstraint;
//
//         } /* End if () */
//         else if (NSLayoutAttributeTrailing == stConstraint.firstAttribute && NSLayoutAttributeTrailing == stConstraint.secondAttribute) {
//
//            self.layoutConstraintR  = stConstraint;
//
//         } /* End if () */
//
//      } /* End if () */
//
//   } /* End for () */
//
//   if (nil == self.layoutConstraintL) {
//
//      self.layoutConstraintL  = [NSLayoutConstraint constraintWithItem:self.containerView
//                                                             attribute:NSLayoutAttributeLeading
//                                                             relatedBy:NSLayoutRelationEqual
//                                                                toItem:self.contentView
//                                                             attribute:NSLayoutAttributeLeading
//                                                            multiplier:1
//                                                              constant:self.layoutConstraintLeftInset];
//
//      [self.contentView addConstraint:self.layoutConstraintL];
//
//   } /* End if () */
//   else {
//
//      [self.layoutConstraintL setConstant:self.layoutConstraintLeftInset];
//
//   } /* End else */
//
//   if (nil == self.layoutConstraintR) {
//
//      self.layoutConstraintR  = [NSLayoutConstraint constraintWithItem:self.containerView
//                                                             attribute:NSLayoutAttributeTrailing
//                                                             relatedBy:NSLayoutRelationEqual
//                                                                toItem:self.contentView
//                                                             attribute:NSLayoutAttributeTrailing
//                                                            multiplier:1
//                                                              constant:self.layoutConstraintRightInset];
//
//      [self.contentView addConstraint:self.layoutConstraintR];
//
//   } /* End if () */
//   else {
//
//      [self.layoutConstraintR setConstant:self.layoutConstraintRightInset];
//
//   } /* End else */
   
   [self.contentView setNeedsUpdateConstraints];
   [self.contentView updateConstraintsIfNeeded];
   
   [self.contentView setNeedsLayout];
   [self.contentView layoutIfNeeded];
   
   __CATCH(nErr);
   
   return;
}

- (void)prepareForReuse {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super prepareForReuse];
   
   // Configure the view for the selected state
   self.rectCorner   = UIRectCornerNone;

   [self.containerView.layer setMask:nil];
   [self.containerView.layer setMasksToBounds:NO];

   __CATCH(nErr);
   
   return;
}

- (void)setRectCorner:(UIRectCorner)aRectCorner {
   
   _rectCorner = aRectCorner;
   
   [self setNeedsDisplay];

   return;
}

+ (CGFloat)cornerRadii {
   
   return 8.0f;
}

//+ (CGFloat)constraintLeftInset {
//   
//   return 16.0f;
//}
//
//+ (CGFloat)constraintRightInset {
//   
//   return 16.0f;
//}

- (void)drawRect:(CGRect)aRect {
   
   if (UIRectCornerNone != self.rectCorner) {

      UIBezierPath   *stBezierPath  = [UIBezierPath bezierPathWithRoundedRect:self.containerView.bounds
                                                            byRoundingCorners:self.rectCorner
                                                                  cornerRadii:CGSizeMake([UICollectionViewCellX cornerRadii], [UICollectionViewCellX cornerRadii])];
      CAShapeLayer   *stMaskLayer   = [CAShapeLayer layer];
      stMaskLayer.frame = self.containerView.bounds;
      stMaskLayer.path  = stBezierPath.CGPath;

      [self.containerView.layer setMasksToBounds:YES];
      [self.containerView.layer setMask:stMaskLayer];

   } /* End if () */
   else {

      [self.containerView.layer setMask:nil];
      [self.containerView.layer setMasksToBounds:NO];

   } /* End else */

   [super drawRect:aRect];

   return;
}

@end
