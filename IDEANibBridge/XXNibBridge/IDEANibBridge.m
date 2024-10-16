// IDEANibBridge.m
// Version 2.2
//
// Copyright (c) 2015 sunnyxx ( http://github.com/sunnyxx )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "IDEANibBridge.h"

@interface IDEANibBridgeImplementation : NSObject
/// `NS_REPLACES_RECEIVER` attribute is a must for right ownership for `self` under ARC.
- (id)hackedAwakeAfterUsingCoder:(NSCoder *)decoder NS_REPLACES_RECEIVER;

@end

@implementation IDEANibBridgeImplementation

+ (void)load {
   
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      
      SEL    originalSelector = @selector(awakeAfterUsingCoder:);
      SEL    swizzledSelector = @selector(hackedAwakeAfterUsingCoder:);
      Method originalMethod   = class_getInstanceMethod(UIView.class, originalSelector);
      Method swizzledMethod   = class_getInstanceMethod(self, swizzledSelector);
      
      if (class_addMethod(UIView.class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
         
         class_replaceMethod(UIView.class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
      }
      else {
         
         method_exchangeImplementations(originalMethod, swizzledMethod);
      }
   });
   
   return;
}

- (id)hackedAwakeAfterUsingCoder:(NSCoder *)aDecoder {
   
   self = [super awakeAfterUsingCoder:aDecoder];
   
#if __Debug__
   if ([NSStringFromClass(self.class) isEqualToString:@"UINavigationBarX"]) {
      
      LogDebug((@"UINavigationBarX"));
      
   } /* End if () */
#endif /* __Debug__ */
   if ([self.class conformsToProtocol:@protocol(IDEANibBridge)] && ((UIView *)self).subviews.count == 0) {
      
      return [IDEANibBridgeImplementation instantiateRealViewFromPlaceholder:(UIView *)self];

//      if ([self respondsToSelector:@selector(shouldApplyNibBridge)]) {
//         
//         if ([(id<IDEANibBridge>)self shouldApplyNibBridge]) {
//            
//            // "self" is placeholder view for this moment, replace it.
//            return [IDEANibBridgeImplementation instantiateRealViewFromPlaceholder:(UIView *)self];
//            
//         } /* End if () */
//         
//      } /* End if () */
//      else {
//         
//         // "self" is placeholder view for this moment, replace it.
//         return [IDEANibBridgeImplementation instantiateRealViewFromPlaceholder:(UIView *)self];
//         
//      } /* End else */
      
   } /* End if () */
   
   return self;
}

+ (UIView *)instantiateRealViewFromPlaceholder:(UIView *)placeholderView {
   
   // Required to conform `IDEANibConvension`.
   UIView   *realView   = [[placeholderView class] instantiateFromNib];
   
   realView.tag      = placeholderView.tag;
   realView.frame    = placeholderView.frame;
   realView.bounds   = placeholderView.bounds;
   realView.hidden   = placeholderView.hidden;
   realView.clipsToBounds     = placeholderView.clipsToBounds;
   realView.autoresizingMask  = placeholderView.autoresizingMask;
   realView.userInteractionEnabled  = placeholderView.userInteractionEnabled;
   realView.translatesAutoresizingMaskIntoConstraints = placeholderView.translatesAutoresizingMaskIntoConstraints;
   
   // Copy autolayout constrains.
   if (placeholderView.constraints.count > 0) {
      
      // We only need to copy "self" constraints (like width/height constraints)
      // from placeholder to real view
      for (NSLayoutConstraint *constraint in placeholderView.constraints) {
         
         NSLayoutConstraint   *newConstraint    = nil;
         
         // "Height" or "Width" constraint
         // "self" as its first item, no second item
         if (!constraint.secondItem) {
            
            newConstraint =   [NSLayoutConstraint constraintWithItem:realView
                                                           attribute:constraint.firstAttribute
                                                           relatedBy:constraint.relation
                                                              toItem:nil
                                                           attribute:constraint.secondAttribute
                                                          multiplier:constraint.multiplier
                                                            constant:constraint.constant];
         } /* End if () */
         // "Aspect ratio" constraint
         // "self" as its first AND second item
         else if ([constraint.firstItem isEqual:constraint.secondItem]) {
            
            newConstraint =   [NSLayoutConstraint constraintWithItem:realView
                                                           attribute:constraint.firstAttribute
                                                           relatedBy:constraint.relation
                                                              toItem:realView
                                                           attribute:constraint.secondAttribute
                                                          multiplier:constraint.multiplier
                                                            constant:constraint.constant];
         } /* End else if () */
         
         // Copy properties to new constraint
         if (newConstraint) {
            
            newConstraint.shouldBeArchived = constraint.shouldBeArchived;
            newConstraint.priority = constraint.priority;
            
//            if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f) {
//               newConstraint.identifier = constraint.identifier;
//            } /* End if () */
            
            if (@available(iOS 7.0, *)) {
               
               newConstraint.identifier = constraint.identifier;
               
            } /* End if () */
            
            [realView addConstraint:newConstraint];
            
         } /* End if () */
         
      } /* End for () */
      
   } /* End for () */
   
   return realView;
}

@end
