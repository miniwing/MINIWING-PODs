//
//  UIView+ViewProperty.m
//  Idea
//
//  Created by Harry on 15/11/26.
//  Copyright © 2015年 Harry. All rights reserved.

#import "UIView+ViewProperty.h"

@implementation UIView (ViewProperty)

- (BOOL)masksToBounds {
   
   return self.layer.masksToBounds;
}

- (void)setMasksToBounds:(BOOL)masksToBounds {
   
   self.layer.masksToBounds   = masksToBounds;
   
   return;
}

@end

