//
//  UIView+XIB.h
//  Idea
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail:iidioter@gmail.com
//  TEL :+(86)18668032582
//

#import <UIKit/UIKit.h>


@interface UIView (XIB)

+ (__kindof UIView *)loadXIB:(NSString *)aXIB class:(Class)aClass;

@end

