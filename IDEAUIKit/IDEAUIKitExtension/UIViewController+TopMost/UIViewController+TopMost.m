//
//  UIViewController+TopMost.m
//  UIViewController+TopMost
//
//  Created by Harry on 2022/6/21.
//  Copyright (c) 2022年 Harry. All rights reserved.
//

#import "UIViewController+TopMost.h"

@implementation UIViewController (TopMost)

- (UIViewController *)TOP_MOST {
   
   UIViewController  *stTopMost  = self;
   UIViewController  *stAbove    = nil;
   
   while ((stAbove = stTopMost.presentedViewController)) {
      
      stTopMost = stAbove;
      
   } /* End while () */
   
   return stTopMost;
}

@end
