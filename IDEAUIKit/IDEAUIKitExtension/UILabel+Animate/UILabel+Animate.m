//
//  UILabel+Animate.m
//  IDEAUIKit
//
//  Created by Harry on 2021/3/24.
//

#import "UILabel+Animate.h"

@implementation UILabel (Animate)

- (void)setText:(NSString *)aText animated:(BOOL)aAnimated completion:(void (^ __nullable)(void))aCompletion {
   
   [UIView transitionWithView:self
                     duration:UIAViewAnimationDefaultDuraton
                      options:UIViewAnimationOptionTransitionCrossDissolve
                   animations:^{
      [self setText:aText];
   }
                   completion:^(BOOL aFinished) {
      if (aCompletion) {
         
         aCompletion();
         
      } /* End if () */
   }];
   
   return;
}

@end
