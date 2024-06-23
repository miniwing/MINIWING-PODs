//
//  IDEAWebView.m
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2024 Harry. All rights reserved.
//

#import "IDEAWebView.h"

@interface IDEAWebView ()

@end

@implementation IDEAWebView

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)aGestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)aOtherGestureRecognizer {
   
   if (self.scrollView.contentOffset.x <= 0) {
      
//      if ([aOtherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")])
      if ([aOtherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"FullscreenPopGestureRecognizerDelegate")]) {
         
         return YES;
      }
   }
   return NO;
}

@end
