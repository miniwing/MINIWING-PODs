//
//  IDEASystemFont.h
//  IDEAFONT
//
//  Created by Harry on 2021/3/4.
//

#import <Foundation/Foundation.h>

#import <IDEAFONT/IDEAFONT.h>

#ifndef IDEA_FONT_BOLD
#  define IDEA_FONT_BOLD                           (0)
#endif /* IDEA_FONT_BOLD */

NS_ASSUME_NONNULL_BEGIN

@interface IDEASystemFont : NSObject

/** Asks the receiver to return a font with a light weight. FontSize must be larger tha 0. */
+ (nullable UIFont *)lightFontOfSize:(CGFloat)fontSize;

/** Asks the receiver to return a font with a normal weight. FontSize must be larger tha 0. */
+ (nonnull UIFont *)regularFontOfSize:(CGFloat)fontSize;

/** Asks the receiver to return a font with a medium weight. FontSize must be larger tha 0. */
+ (nullable UIFont *)mediumFontOfSize:(CGFloat)fontSize;

/** Asks the receiver to return a font with a bold weight. FontSize must be larger tha 0. */
+ (nonnull UIFont *)boldFontOfSize:(CGFloat)fontSize;

/** Asks the receiver to return an italic font. FontSize must be larger tha 0. */
+ (nonnull UIFont *)italicFontOfSize:(CGFloat)fontSize;

/** Asks the receiver to return a font with an italic bold weight. FontSize must be larger tha 0. */
+ (nullable UIFont *)boldItalicFontOfSize:(CGFloat)fontSize;

/** Returns a bold version of the specified font. */
+ (nonnull UIFont *)boldFontFromFont:(nonnull UIFont *)font;

/** Returns an italic version of the specified font. */
+ (nonnull UIFont *)italicFontFromFont:(nonnull UIFont *)font;

@end

@interface IDEASystemFont (Size)

+ (CGFloat)appFontTitleSize;
+ (CGFloat)appFontSearchBarSize;
+ (CGFloat)appFontTabTitleSize;

@end

NS_ASSUME_NONNULL_END
