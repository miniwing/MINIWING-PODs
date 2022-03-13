//
//  UIFont+TypeFace.h
//  IDEATypeFace
//
//  Created by Harry on 2022/3/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (TypeFace)

+ (UIFont *)customSystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)customFontWithName:(NSString *)fontName size:(CGFloat)fontSize;
+ (CGFloat)transSizeWithFontSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
