//
//  UIImage+Bundle.h
//  IDEAKit
//
//  Created by Harry on 16/5/7.
//  Copyright © 2016年 Harry. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Bundle)

+ (nullable UIImage *)imageNamed:(NSString *)name inBundle:(nullable NSBundle *)bundle;

@end
