//
//  UIButton+Font.m
//  UIButton+Font
//
//  Created by Harry on 15/11/26.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "UIButton+Font.h"

@implementation UIButton (Font)

- (void)setFontWithName:(NSString *)fontName {
      
   [self setFontWithName:fontName size:self.titleLabel.font.pointSize];
   
   return;
}

- (void)setFontWithName:(NSString *)fontName size:(CGFloat)fontSize {
   
   [self.titleLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
   
   return;
}

@end
