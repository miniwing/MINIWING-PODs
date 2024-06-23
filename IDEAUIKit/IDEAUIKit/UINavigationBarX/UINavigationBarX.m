//
//  UINavigationBarX.m
//  IDEAUIKit
//
//  Created by Harry on 2022/3/25.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAColor/UIColorX+System.h"

#import "NSLayoutConstraint+Extension.h"

#import "UINavigationBarX.h"
#import "UINavigationBarX+Inner.h"

@interface UINavigationBarX () <IDEANibBridge>

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
   
   if ([self conformsToProtocol:@protocol(IDEANibBridge)]) {
      
      if (nil == self.superview) {
         
         nErr  = noErr;
         
         break;
         
      } /* End if () */
      
   } /* End if () */

   [self setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor appNavigationBarBackground])];

   [self.navigationBar setBackgroundColor:UIColor.clearColor];

   [self setTranslatesAutoresizingMaskIntoConstraints:NO];
   [self setAutoresizingMask:UIViewAutoresizingNone];
   
   LogDebug((@"-[UINavigationBarX awakeFromNib] : stackView : %@", self.navigationBar));
   LogDebug((@"-[UINavigationBarX awakeFromNib] : navigationBar : %@", self.navigationBar));

   LogDebug((@"-[UINavigationBarX awakeFromNib] : splitView : %@", self.splitView));
   [self.subTitleLabel setHidden:YES];

   [self.splitView setHidden:YES];
   [self.splitView setBackgroundColor:UIColorX.opaqueSeparatorColor];
//   [self.splitView setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor lightGray])];
   [self.splitViewH setConstant:0.5f];

//   if (nil == self.navigationBarXHeight) {
//
//      self.navigationBarXHeight  = [NSLayoutConstraint constraintWithIdentifier:@"H"
//                                                                       fromView:self];
//
//   } /* End if () */
//
//   if (nil == self.navigationBarXHeight) {
//
//      self.navigationBarXHeight  = [NSLayoutConstraint constraintWithItem:self
//                                                                attribute:NSLayoutAttributeHeight
//                                                                relatedBy:NSLayoutRelationEqual
//                                                                   toItem:nil
//                                                                attribute:nil
//                                                               multiplier:1
//                                                                 constant:110];
//
//   } /* End if () */

   LogDebug((@"-[UINavigationBarX awakeFromNib] : navigationBarXHeight : %@", self.navigationBarXHeight));
   
   for (NSLayoutConstraint *stConstraint in self.constraints) {
      
//      LogDebug((@"-[UINavigationBarX awakeFromNib] : Constraint : %@", stConstraint));
      
      if (NSLayoutAttributeHeight == stConstraint.firstAttribute || NSLayoutAttributeHeight == stConstraint.secondAttribute) {
         
         LogDebug((@"-[UINavigationBarX awakeFromNib] : NSLayoutAttributeHeight : %@ : %@", stConstraint, stConstraint.identifier));

         if (![self.navigationBarXHeight.identifier isEqualToString:stConstraint.identifier]) {
            
            [stConstraint setActive:NO];
            
         } /* End if () */
                  
      } /* End if () */

   } /* End for () */

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

- (void)showLine:(BOOL)aShow {
   
   [self showLine:aShow animated:NO];
   
   return;
}

- (void)showLine:(BOOL)aShow animated:(BOOL)aAnimated {
   
   [self.splitView setHidden:!aShow animated:aAnimated];
   
   return;
}

- (void)setSubTitle:(NSString *)aTitle {
   
   if (nil == aTitle || 0 == aTitle.length) {
      
      [self.subTitleLabel setHidden:YES animated:YES];
      
   } /* End if () */
   else {
      
      [self.subTitleLabel setText:aTitle];

      [self.subTitleLabel setHidden:NO animated:YES];

   } /* End else */
   
   return;
}

#if __Debug__
// 这个函数是专门为 xib设计的，会在渲染前设置你想要配置的属性。
- (void)prepareForInterfaceBuilder {
  
//   self.backgroundColor = UIColor.blueColor;
   
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

//- (void)awakeFromNibEx {
//
//   int                            nErr                                     = EFAULT;
//
//   __TRY;
//
//   [super awakeFromNib];
//   // Initialization code
//
//   [self setNeedsUpdateConstraints];
//   [self updateConstraintsIfNeeded];
//
//   [self setTranslatesAutoresizingMaskIntoConstraints:NO];
//
//   if (nil == self.stackView) {
//
//      self.stackView = [[UIStackView alloc] init];
//      [self.stackView setAxis:UILayoutConstraintAxisVertical];
//
//   } /* End if () */
//
//   if (nil == self.navigationBar) {
//
//      self.navigationBar   = [[MDCNavigationBar alloc] init];
//      [self.navigationBar setTranslatesAutoresizingMaskIntoConstraints:NO];
//
//      [self.stackView addSubview:self.navigationBar];
//
//   } /* End if () */
//
//   LogDebug((@"-[UINavigationBarX awakeFromNib] : navigationBar : %@", self.navigationBar));
//
//   if (nil == self.splitView) {
//
//      self.splitView   = [[UIView alloc] init];
//      [self.splitView setBackgroundColor:UIColor.blackColor];
//      [self.splitView setTranslatesAutoresizingMaskIntoConstraints:NO];
//
//      [self addSubview:self.splitView];
//
//   } /* End if () */
//
//   [self.splitView setHidden:YES];
//   LogDebug((@"-[UINavigationBarX awakeFromNib] : splitView : %@", self.splitView));
//
//   for (NSLayoutConstraint *stConstraint in self.constraints) {
//
//      if (([stConstraint.firstItem isEqual:self.navigationBar] && [stConstraint.secondItem isEqual:self])
//          || ([stConstraint.firstItem isEqual:self] && [stConstraint.secondItem isEqual:self.navigationBar])) {
//
//         if (NSLayoutAttributeTop == stConstraint.firstAttribute && NSLayoutAttributeTop == stConstraint.secondAttribute) {
//
//            self.navigationBarT  = stConstraint;
//
//         } /* End if () */
//         else if (NSLayoutAttributeBottom == stConstraint.firstAttribute && NSLayoutAttributeBottom == stConstraint.secondAttribute) {
//
//            self.navigationBarB  = stConstraint;
//
//         } /* End if () */
//         else if (NSLayoutAttributeLeading == stConstraint.firstAttribute && NSLayoutAttributeLeading == stConstraint.secondAttribute) {
//
//            self.navigationBarL  = stConstraint;
//
//         } /* End if () */
//         else if (NSLayoutAttributeTrailing == stConstraint.firstAttribute && NSLayoutAttributeTrailing == stConstraint.secondAttribute) {
//
//            self.navigationBarR  = stConstraint;
//
//         } /* End if () */
//
//      } /* End if () */
//
//      if (([stConstraint.firstItem isEqual:self.splitView] && [stConstraint.secondItem isEqual:self])
//          || ([stConstraint.firstItem isEqual:self] && [stConstraint.secondItem isEqual:self.splitView])) {
//
//         if (NSLayoutAttributeTop == stConstraint.firstAttribute && NSLayoutAttributeTop == stConstraint.secondAttribute) {
//
//            self.splitViewT  = stConstraint;
//
//         } /* End if () */
//         else if (NSLayoutAttributeBottom == stConstraint.firstAttribute && NSLayoutAttributeBottom == stConstraint.secondAttribute) {
//
//            self.splitViewB  = stConstraint;
//
//         } /* End if () */
//         else if (NSLayoutAttributeLeading == stConstraint.firstAttribute && NSLayoutAttributeLeading == stConstraint.secondAttribute) {
//
//            self.splitViewL  = stConstraint;
//
//         } /* End if () */
//         else if (NSLayoutAttributeTrailing == stConstraint.firstAttribute && NSLayoutAttributeTrailing == stConstraint.secondAttribute) {
//
//            self.splitViewR  = stConstraint;
//
//         } /* End if () */
//
//      } /* End if () */
//
//   } /* End for () */
//
//   if (nil == self.navigationBarT) {
//
//      self.navigationBarT  = [NSLayoutConstraint constraintWithItem:self.navigationBar
//                                                          attribute:NSLayoutAttributeTop
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self
//                                                          attribute:NSLayoutAttributeTop
//                                                         multiplier:1
//                                                           constant:self.navigationBarTopInset];
//
//      [self addConstraint:self.navigationBarT];
//
//   } /* End if () */
//   else {
//
//      [self.navigationBarT setConstant:self.navigationBarTopInset];
//
//   } /* End else */
//
//   if (nil == self.navigationBarB) {
//
//      self.navigationBarB  = [NSLayoutConstraint constraintWithItem:self
//                                                          attribute:NSLayoutAttributeBottom
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.navigationBar
//                                                          attribute:NSLayoutAttributeBottom
//                                                         multiplier:1
//                                                           constant:self.navigationBarBottomInset];
//
//      [self addConstraint:self.navigationBarB];
//
//   } /* End if () */
//   else {
//
//      [self.navigationBarB setConstant:self.navigationBarBottomInset];
//
//   } /* End else */
//
//   if (nil == self.navigationBarL) {
//
//      self.navigationBarL  = [NSLayoutConstraint constraintWithItem:self.navigationBar
//                                                          attribute:NSLayoutAttributeLeading
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self
//                                                          attribute:NSLayoutAttributeLeading
//                                                         multiplier:1
//                                                           constant:self.navigationBarLeftInset];
//
//      [self addConstraint:self.navigationBarL];
//
//   } /* End if () */
//   else {
//
//      [self.navigationBarL setConstant:self.navigationBarLeftInset];
//
//   } /* End else */
//
//   if (nil == self.navigationBarR) {
//
//      self.navigationBarR  = [NSLayoutConstraint constraintWithItem:self
//                                                          attribute:NSLayoutAttributeTrailing
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.navigationBar
//                                                          attribute:NSLayoutAttributeTrailing
//                                                         multiplier:1
//                                                           constant:self.navigationBarRightInset];
//
//      [self addConstraint:self.navigationBarR];
//
//   } /* End if () */
//   else {
//
//      [self.navigationBarR setConstant:self.navigationBarRightInset];
//
//   } /* End else */
//
//   [self.navigationBar setBackgroundColor:UIColor.clearColor];
//
//   if (self.splitViewT) {
//
//      self.splitViewT.active  = NO;
//
//   } /* End if () */
//
//   if (nil == self.splitViewB) {
//
//      self.splitViewB  = [NSLayoutConstraint constraintWithItem:self
//                                                      attribute:NSLayoutAttributeBottom
//                                                      relatedBy:NSLayoutRelationEqual
//                                                         toItem:self.splitView
//                                                      attribute:NSLayoutAttributeBottom
//                                                     multiplier:1
//                                                       constant:0];
//
//      [self addConstraint:self.splitViewB];
//
//   } /* End if () */
//   else {
//
//      [self.splitViewB setConstant:0];
//
//   } /* End else */
//
//   if (nil == self.splitViewL) {
//
//      self.splitViewL  = [NSLayoutConstraint constraintWithItem:self.splitView
//                                                      attribute:NSLayoutAttributeLeading
//                                                      relatedBy:NSLayoutRelationEqual
//                                                         toItem:self
//                                                      attribute:NSLayoutAttributeLeading
//                                                     multiplier:1
//                                                       constant:0];
//
//      [self addConstraint:self.splitViewL];
//
//   } /* End if () */
//   else {
//
//      [self.splitViewL setConstant:0];
//
//   } /* End else */
//
//   if (nil == self.splitViewR) {
//
//      self.splitViewR  = [NSLayoutConstraint constraintWithItem:self
//                                                      attribute:NSLayoutAttributeTrailing
//                                                      relatedBy:NSLayoutRelationEqual
//                                                         toItem:self.splitView
//                                                      attribute:NSLayoutAttributeTrailing
//                                                     multiplier:1
//                                                       constant:0];
//
//      [self addConstraint:self.splitViewR];
//
//   } /* End if () */
//   else {
//
//      [self.splitViewR setConstant:0];
//
//   } /* End else */
//
//   for (NSLayoutConstraint *stConstraint in self.splitView.constraints) {
//
//      if ([stConstraint.firstItem isEqual:self.splitView]) {
//
//         if (NSLayoutAttributeHeight == stConstraint.firstAttribute) {
//
//            self.splitViewH   = stConstraint;
//
//            break;
//
//         } /* End if () */
//
//      } /* End if () */
//
//   } /* End for () */
//
//   if (nil == self.splitViewH) {
//
//      self.splitViewH  = [NSLayoutConstraint constraintWithItem:self.splitView
//                                                      attribute:NSLayoutAttributeHeight
//                                                      relatedBy:NSLayoutRelationEqual
//                                                         toItem:nil
//                                                      attribute:NSLayoutAttributeNotAnAttribute
//                                                     multiplier:1
//                                                       constant:0.5f];
//
//      [self.splitView addConstraint:self.splitViewH];
//
//   } /* End if () */
//   else {
//
//      [self.splitViewH setConstant:0.5f];
//
//   } /* End else */
//
////   [self setNeedsUpdateConstraints];
////   [self updateConstraintsIfNeeded];
//
//   __CATCH(nErr);
//
//   return;
//}

@end
