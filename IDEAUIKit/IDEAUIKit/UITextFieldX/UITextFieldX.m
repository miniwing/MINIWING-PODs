//
//  UITextFieldX.m
//  IDEAUIKit
//
//  Created by Harry on 2022/3/18.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "UITextFieldX.h"

@interface UITextFieldX ()

@property (nonatomic, assign)                CGFloat                               edgeX;
@property (nonatomic, assign)                CGFloat                               edgeY;

@end

@implementation UITextFieldX

- (CGRect)textRectForBounds:(CGRect)aBounds {

   return CGRectInset(aBounds, self.leftView.width + self.edgeX, self.edgeY);
}

- (CGRect)editingRectForBounds:(CGRect)aBounds {

   return CGRectInset(aBounds, self.leftView.width + self.edgeX, self.edgeY);
}

- (void)setEdgeX:(CGFloat)aEdgeX edgeY:(CGFloat)aEdgeY {
   
   _edgeX   = aEdgeX;
   _edgeY   = aEdgeY;
   
   return;
}

@end
