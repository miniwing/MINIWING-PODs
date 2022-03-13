//
//  IDEATypeFace.h
//  IDEATypeFace
//
//  Created by Harry on 2021/3/2.
//  Copyright © 2021 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import <IDEATypeFace/IDEATypeFaceSystemFont.h>

@protocol IDEATypeFaceDelegate <NSObject>

@required
/** Asks the receiver to return a font with a light weight. FontSize must be larger tha 0. */
- (nullable UIFont *)lightFontOfSize:(CGFloat)fontSize;

/** Asks the receiver to return a font with a normal weight. FontSize must be larger tha 0. */
- (nonnull UIFont *)regularFontOfSize:(CGFloat)fontSize;

/** Asks the receiver to return a font with a medium weight. FontSize must be larger tha 0. */
- (nullable UIFont *)mediumFontOfSize:(CGFloat)fontSize;

@optional
/** Asks the receiver to return a font with a bold weight. FontSize must be larger tha 0. */
- (nonnull UIFont *)boldFontOfSize:(CGFloat)fontSize;

/** Asks the receiver to return an italic font. FontSize must be larger tha 0. */
- (nonnull UIFont *)italicFontOfSize:(CGFloat)fontSize;

/** Asks the receiver to return a font with an italic bold weight. FontSize must be larger tha 0. */
- (nullable UIFont *)boldItalicFontOfSize:(CGFloat)fontSize;

/** Returns a bold version of the specified font. */
- (nonnull UIFont *)boldFontFromFont:(nonnull UIFont *)font;

/** Returns an italic version of the specified font. */
- (nonnull UIFont *)italicFontFromFont:(nonnull UIFont *)font;

@end
