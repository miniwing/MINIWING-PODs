//
//  UITextView+Font.m
//  UITextView+Font
//
//  Created by Harry on 15/11/26.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "UITextView+Font.h"

@implementation UITextView (Font)

- (void)setFontWithName:(NSString *)fontName {
   
   [self setFontWithName:fontName size:self.font.pointSize];
   
   return;
}

- (void)setFontWithName:(NSString *)fontName size:(CGFloat)fontSize {
   
   [self setFont:[UIFont fontWithName:fontName size:fontSize]];
   
   return;
}

@end
