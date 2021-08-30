//
//  UIView+Shortcut.h
//  IDEAUIKit
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail:iidioter@gmail.com
//  TEL :+(852)53054612
//

#import <UIKit/UIKit.h>

#if __has_include(<UIKitExtension/UIKitExtension.h>)
#else
@interface UIView (Shortcut)

@property(assign) CGFloat   borderWidth;
@property(strong) UIColor  *borderColor;
@property(assign) CGFloat   cornerRadius;

@property(strong) UIColor  *shadowColor;
@property(assign) CGSize    shadowOffset;
@property(assign) float     shadowAlpha;
@property(assign) CGFloat   shadowRadius;

@end
#endif
