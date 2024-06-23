//
//  IDEAScrollView.m
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2024 Harry. All rights reserved.
//

#import "IDEAScrollView.h"

@implementation IDEAScrollView

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)aGestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)aOtherGestureRecognizer {
	
   if (self.contentOffset.x <= 0) {
   	
//      if ([aOtherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")])
      if ([aOtherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"FullscreenPopGestureRecognizerDelegate")]) {
      	
         return YES;
         
      } /* End if () */
      
   } /* End if () */
   
   return NO;
}

@end
