//
//  UIView+ViewProperty.m
//  UIView+ViewProperty
//
//  Created by Harry on 15/11/26.
//  Copyright © 2015年 MINIWING. All rights reserved.

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

