//
//  UIImage+Bundle.m
//  IDEAKit
//
//  Created by Harry on 16/5/7.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import "UIImage+Bundle.h"

@implementation UIImage (Bundle)

+ (nullable UIImage *)imageNamed:(NSString *)name inBundle:(nullable NSBundle *)bundle
{
   return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
}

@end
