//
//  UIAlertController+Blocks.m
//  UIAlertController+Blocks
//
//  Created by Ryan Maxwell on 11/09/14.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Ryan Maxwell
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "UIAlertAction+Color.h"
#import "UIAlertController+Blocks.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

static NSInteger const UIAlertControllerBlocksCancelButtonIndex      = 0;
static NSInteger const UIAlertControllerBlocksDestructiveButtonIndex = 1;
static NSInteger const UIAlertControllerBlocksFirstOtherButtonIndex  = 2;

@implementation UIAlertController (Blocks)

+ (instancetype)showInViewController:(UIViewController *)aViewController
                  userInterfaceStyle:(UIUserInterfaceStyle)aUserInterfaceStyle
                           withTitle:(NSString *)aTitle
                             message:(NSString *)aMessage
                      preferredStyle:(UIAlertControllerStyle)aPreferredStyle
                   cancelButtonTitle:(NSString *)aCancelButtonTitle
              destructiveButtonTitle:(NSString *)aDestructiveButtonTitle
                   otherButtonTitles:(NSArray<NSString *> *)aOtherButtonTitles
#if TARGET_OS_IOS
  popoverPresentationControllerBlock:(void(^)(UIPopoverPresentationController *aPopover))aPopoverPresentationControllerBlock
#endif
                            tapBlock:(UIAlertControllerCompletionBlock)aTapBlock {
   
   UIAlertController          *stStrongController  = [self alertControllerWithTitle:aTitle
                                                                            message:aMessage
                                                                     preferredStyle:aPreferredStyle];
   
   if (aCancelButtonTitle && 0 < aCancelButtonTitle.length) {
      
      UIAlertAction  *stCancelAction   = [UIAlertAction actionWithTitle:aCancelButtonTitle
                                                                  style:UIAlertActionStyleCancel
                                                                handler:^(UIAlertAction *action) {
         if (aTapBlock) {
            
            aTapBlock(stStrongController, action, UIAlertControllerBlocksCancelButtonIndex);
            
         } /* End if () */
      }];
      
      [stStrongController addAction:stCancelAction];

   } /* End if () */
   
   for (NSUInteger H = 0; H < aOtherButtonTitles.count; H++) {
      
      NSString       *szOtherButtonTitle  = aOtherButtonTitles[H];
      
      UIAlertAction  *stOtherAction       = [UIAlertAction actionWithTitle:szOtherButtonTitle
                                                                     style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction *action) {
         if (aTapBlock) {
            
            aTapBlock(stStrongController, action, UIAlertControllerBlocksFirstOtherButtonIndex + H);
            
         } /* End if () */
      }];
      
      [stStrongController addAction:stOtherAction];
      
   } /* End for () */
   
#if TARGET_OS_IOS
   if (aPopoverPresentationControllerBlock) {
      
      aPopoverPresentationControllerBlock(stStrongController.popoverPresentationController);
      
   } /* End if () */
#endif
   
   if (aDestructiveButtonTitle) {
      
      UIAlertAction  *stDestructiveAction = [UIAlertAction actionWithTitle:aDestructiveButtonTitle
                                                                     style:UIAlertActionStyleDestructive
                                                                   handler:^(UIAlertAction *action) {
         
         if (aTapBlock) {
            
            aTapBlock(stStrongController, action, UIAlertControllerBlocksDestructiveButtonIndex);
         
         } /* End if () */
      }];
      
      [stStrongController addAction:stDestructiveAction];
   
   } /* End if () */
   
   LogDebug((@"+[UIAlertController showInViewController:] : %@", aViewController.topMost));
   
   [aViewController.topMost presentViewController:stStrongController animated:YES completion:nil];
   
   if (@available(iOS 13, *)) {
      
      stStrongController.overrideUserInterfaceStyle  = aUserInterfaceStyle;

   } /* End if () */
      
   return stStrongController;
}

+ (instancetype)showAlertInViewController:(UIViewController *)aViewController
                       userInterfaceStyle:(UIUserInterfaceStyle)aUserInterfaceStyle
                                withTitle:(NSString *)aTitle
                                  message:(NSString *)aMessage
                        cancelButtonTitle:(NSString *)aCancelButtonTitle
                   destructiveButtonTitle:(NSString *)aDestructiveButtonTitle
                        otherButtonTitles:(NSArray<NSString *> *)aOtherButtonTitles
                                 tapBlock:(UIAlertControllerCompletionBlock)aTapBlock {
   
   return [self showInViewController:aViewController
                  userInterfaceStyle:aUserInterfaceStyle
                           withTitle:aTitle
                             message:aMessage
                      preferredStyle:UIAlertControllerStyleAlert
                   cancelButtonTitle:aCancelButtonTitle
              destructiveButtonTitle:aDestructiveButtonTitle
                   otherButtonTitles:aOtherButtonTitles
#if TARGET_OS_IOS
  popoverPresentationControllerBlock:nil
#endif
                            tapBlock:aTapBlock];
}

+ (instancetype)showActionSheetInViewController:(UIViewController *)aViewController
                             userInterfaceStyle:(UIUserInterfaceStyle)aUserInterfaceStyle
                                      withTitle:(NSString *)aTitle
                                        message:(NSString *)aMessage
                              cancelButtonTitle:(NSString *)aCancelButtonTitle
                         destructiveButtonTitle:(NSString *)aDestructiveButtonTitle
                              otherButtonTitles:(NSArray<NSString *> *)aOtherButtonTitles
#if TARGET_OS_IOS
             popoverPresentationControllerBlock:(void(^)(UIPopoverPresentationController *aPopover))aPopoverPresentationControllerBlock
#endif
                                       tapBlock:(UIAlertControllerCompletionBlock)tapBlock {
   
   return [self showInViewController:aViewController
                  userInterfaceStyle:aUserInterfaceStyle
                           withTitle:aTitle
                             message:aMessage
                      preferredStyle:UIAlertControllerStyleActionSheet
                   cancelButtonTitle:aCancelButtonTitle
              destructiveButtonTitle:aDestructiveButtonTitle
                   otherButtonTitles:aOtherButtonTitles
#if TARGET_OS_IOS
  popoverPresentationControllerBlock:aPopoverPresentationControllerBlock
#endif
                            tapBlock:tapBlock];
}

#pragma mark -

- (BOOL)visible {
   
   return self.view.superview != nil;
}

- (NSInteger)cancelButtonIndex {
   
   return UIAlertControllerBlocksCancelButtonIndex;
}

- (NSInteger)firstOtherButtonIndex {
   
   return UIAlertControllerBlocksFirstOtherButtonIndex;
}

- (NSInteger)destructiveButtonIndex {
   
   return UIAlertControllerBlocksDestructiveButtonIndex;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
   
   LogDebug((@"+[UIAlertController supportedInterfaceOrientations] : %@", self.topMost));
   
   if (nil != self.topMost && self != self.topMost) {
      
      if (![self.topMost isKindOfClass:UIAlertController.class]) {
         
         return [self.topMost supportedInterfaceOrientations];

      } /* End if () */

   } /* End if () */
   
   return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {

   LogDebug((@"+[UIAlertController supportedInterfaceOrientations] : %@", self.topMost));
   
   if (nil != self.topMost && self != self.topMost) {
      
      if (![self.topMost isKindOfClass:UIAlertController.class]) {
         
         return [self.topMost shouldAutorotate];

      } /* End if () */
            
   } /* End if () */

   return NO;
}

@end

@implementation UIViewController (UACB_Topmost)

- (UIViewController *)topMost {
   
   UIViewController  *stTopMost  = self;
   UIViewController  *stAbove    = nil;
   
   while ((stAbove = stTopMost.presentedViewController)) {
      
      stTopMost = stAbove;
      
   } /* End while () */
   
   return stTopMost;
}

@end

#pragma clang diagnostic pop
