//
//  UILabel+Font.m
//  IDEAUIKit
//
//  Created by Harry on 15/9/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "UILabel+Font.h"

@implementation UILabel (Font)

- (void)setFontWithName:(NSString *)fontName {
   
   [self setFontWithName:fontName size:self.font.pointSize];
   
   return;
}

- (void)setFontWithName:(NSString *)fontName size:(CGFloat)fontSize {
   
   [self setFont:[UIFont fontWithName:fontName size:fontSize]];
   
   return;
}

@end

