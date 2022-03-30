//
//  UINavigationBarX.m
//  IDEAUIKit
//
//  Created by Harry on 2022/3/25.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "UINavigationBarX.h"
#import "UINavigationBarX+Inner.h"

@interface UINavigationBarX ()

@end

@implementation UINavigationBarX

- (void)dealloc {

   __LOG_FUNCTION;

   // Custom dealloc

   __SUPER_DEALLOC;

   return;
}

- (instancetype)initWithCoder:(NSCoder *)aCoder {

   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super initWithCoder:aCoder];
   
   if (self) {

      [self __initUI];

   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (instancetype)initWithFrame:(CGRect)aFrame {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super initWithFrame:aFrame];
   
   if (self) {

      [self __initUI];
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (void)__initUI {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   
   
   __CATCH(nErr);
   
   return;
}

- (void)awakeFromNib {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super awakeFromNib];
   // Initialization code
   
   if (nil == self.navigationBar) {
      
      self.navigationBar   = [[MDCNavigationBar alloc] init];
      
      [self addSubview:self.navigationBar];
      
   } /* End if () */
   
   for (NSLayoutConstraint *stConstraint in self.constraints) {
      
      if (([stConstraint.firstItem isEqual:self.navigationBar] && [stConstraint.secondItem isEqual:self])
          || ([stConstraint.secondItem isEqual:self.navigationBar] && [stConstraint.firstItem isEqual:self])) {
         
         if (NSLayoutAttributeTop == stConstraint.firstAttribute && NSLayoutAttributeTop == stConstraint.secondAttribute) {
            
            self.navigationBarT  = stConstraint;
            
         } /* End if () */
         else if (NSLayoutAttributeBottom == stConstraint.firstAttribute && NSLayoutAttributeBottom == stConstraint.secondAttribute) {
            
            self.navigationBarB  = stConstraint;
            
         } /* End if () */
         else if (NSLayoutAttributeLeading == stConstraint.firstAttribute && NSLayoutAttributeLeading == stConstraint.secondAttribute) {
            
            self.navigationBarL  = stConstraint;
            
         } /* End if () */
         else if (NSLayoutAttributeTrailing == stConstraint.firstAttribute && NSLayoutAttributeTrailing == stConstraint.secondAttribute) {
            
            self.navigationBarR  = stConstraint;
            
         } /* End if () */
         
      } /* End if () */
      
   } /* End for () */
   
   if (nil == self.navigationBarT) {
      
      self.navigationBarT  = [NSLayoutConstraint constraintWithItem:self.navigationBar
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:self.navigationBarTopInset];
      
      [self addConstraint:self.navigationBarT];
      
   } /* End if () */
   else {
      
      [self.navigationBarT setConstant:self.navigationBarTopInset];
      
   } /* End else */
   
   if (nil == self.navigationBarB) {
      
      self.navigationBarB  = [NSLayoutConstraint constraintWithItem:self.navigationBar
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:self.navigationBarBottomInset];
      
      [self addConstraint:self.navigationBarB];
      
   } /* End if () */
   else {
      
      [self.navigationBarB setConstant:self.navigationBarBottomInset];
      
   } /* End else */

   if (nil == self.navigationBarL) {
      
      self.navigationBarL  = [NSLayoutConstraint constraintWithItem:self.navigationBar
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:self.navigationBarLeftInset];
      
      [self addConstraint:self.navigationBarL];
      
   } /* End if () */
   else {
      
      [self.navigationBarL setConstant:self.navigationBarLeftInset];
      
   } /* End else */

   if (nil == self.navigationBarR) {
      
      self.navigationBarR  = [NSLayoutConstraint constraintWithItem:self.navigationBar
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1
                                                           constant:self.navigationBarRightInset];
      
      [self addConstraint:self.navigationBarR];
      
   } /* End if () */
   else {
      
      [self.navigationBarR setConstant:self.navigationBarRightInset];
      
   } /* End else */

   [self.navigationBar setBackgroundColor:UIColor.clearColor];
   
   [self setNeedsUpdateConstraints];
   [self updateConstraintsIfNeeded];

   __CATCH(nErr);
   
   return;
}

- (void)setNavigationBarTopInset:(CGFloat)aTopInset {
   
   _navigationBarTopInset  = aTopInset;
   
   for (NSLayoutConstraint *stConstraint in self.constraints) {
      
      if (([stConstraint.firstItem isEqual:self.navigationBar] && [stConstraint.secondItem isEqual:self])
          || ([stConstraint.secondItem isEqual:self.navigationBar] && [stConstraint.firstItem isEqual:self])) {
         
         if (NSLayoutAttributeTop == stConstraint.firstAttribute && NSLayoutAttributeTop == stConstraint.secondAttribute) {
            
            self.navigationBarT  = stConstraint;

            break;
            
         } /* End if () */
         
      } /* End if () */
      
   } /* End for () */
   
   self.navigationBarT.constant  = aTopInset;
   
   [self setNeedsUpdateConstraints];
   [self updateConstraintsIfNeeded];
   
   return;
}

- (void)setNavigationBarBottomInset:(CGFloat)aBottomInset {
   
   _navigationBarBottomInset  = aBottomInset;

   for (NSLayoutConstraint *stConstraint in self.constraints) {
      
      if (([stConstraint.firstItem isEqual:self.navigationBar] && [stConstraint.secondItem isEqual:self])
          || ([stConstraint.secondItem isEqual:self.navigationBar] && [stConstraint.firstItem isEqual:self])) {
         
         if (NSLayoutAttributeBottom == stConstraint.firstAttribute && NSLayoutAttributeBottom == stConstraint.secondAttribute) {
            
            self.navigationBarB  = stConstraint;

            break;
            
         } /* End if () */
         
      } /* End if () */
      
   } /* End for () */
   
   self.navigationBarB.constant  = aBottomInset;

   [self setNeedsUpdateConstraints];
   [self updateConstraintsIfNeeded];

   return;
}

- (void)setNavigationBarLeftInset:(CGFloat)aLeftInset {
   
   _navigationBarLeftInset = aLeftInset;

   for (NSLayoutConstraint *stConstraint in self.constraints) {
      
      if (([stConstraint.firstItem isEqual:self.navigationBar] && [stConstraint.secondItem isEqual:self])
          || ([stConstraint.secondItem isEqual:self.navigationBar] && [stConstraint.firstItem isEqual:self])) {
         
         if (NSLayoutAttributeLeading == stConstraint.firstAttribute && NSLayoutAttributeLeading == stConstraint.secondAttribute) {
            
            self.navigationBarL  = stConstraint;

            break;
            
         } /* End if () */
         
      } /* End if () */
      
   } /* End for () */
   
   self.navigationBarL.constant  = aLeftInset;

   [self setNeedsUpdateConstraints];
   [self updateConstraintsIfNeeded];

   return;
}

- (void)setNavigationBarRightInset:(CGFloat)aRightInset {
   
   _navigationBarRightInset   = aRightInset;

   for (NSLayoutConstraint *stConstraint in self.constraints) {
      
      if (([stConstraint.firstItem isEqual:self.navigationBar] && [stConstraint.secondItem isEqual:self])
          || ([stConstraint.secondItem isEqual:self.navigationBar] && [stConstraint.firstItem isEqual:self])) {
         
         if (NSLayoutAttributeTrailing == stConstraint.firstAttribute && NSLayoutAttributeTrailing == stConstraint.secondAttribute) {
            
            self.navigationBarR  = stConstraint;
         
            break;
         } /* End if () */
         
      } /* End if () */
      
   } /* End for () */

   self.navigationBarR.constant  = aRightInset;

   [self setNeedsUpdateConstraints];
   [self updateConstraintsIfNeeded];

   return;
}

#if __Debug__
// 这个函数是专门为 xib设计的，会在渲染前设置你想要配置的属性。
- (void)prepareForInterfaceBuilder {
  
//   self.backgroundColor = [UIColor blueColor];
   
   return;
}
#endif /* __Debug__ */

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)aRect {
   
   // Drawing code

   return;
}
*/

@end
