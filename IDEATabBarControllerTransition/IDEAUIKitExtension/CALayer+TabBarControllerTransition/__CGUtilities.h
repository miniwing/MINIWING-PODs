//
//  __CGUtilities.h
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 15/2/28.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#if DEBUG
#  pragma clang diagnostic ignored                 "-Wnullability-completeness-on-arrays"
#endif /* DEBUG */

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

__BEGIN_DECLS

NS_ASSUME_NONNULL_BEGIN

/// Create an `ARGB` Bitmap context. Returns NULL if an error occurs.
///
/// @discussion The function is same as UIGraphicsBeginImageContextWithOptions(),
/// but it doesn't push the context to UIGraphic, so you can retain the context for reuse.
CGContextRef _Nullable __CGContextCreateARGBBitmapContext(CGSize size, BOOL opaque, CGFloat scale);

/// Create a `DeviceGray` Bitmap context. Returns NULL if an error occurs.
CGContextRef _Nullable __CGContextCreateGrayBitmapContext(CGSize size, CGFloat scale);

/// Get main screen's scale.
CGFloat __ScreenScale(void);

/// Get main screen's size. Height is always larger than width.
CGSize __ScreenSize(void);

/// Convert CALayer's gravity string to UIViewContentMode.
UIViewContentMode __CAGravityToUIViewContentMode(NSString *gravity);

/// Convert UIViewContentMode to CALayer's gravity string.
NSString *__UIViewContentModeToCAGravity(UIViewContentMode contentMode);

/**
 Returns a rectangle to fit the param rect with specified content mode.
 
 @param rect The constrant rect
 @param size The content size
 @param mode The content mode
 @return A rectangle for the given content mode.
 @discussion UIViewContentModeRedraw is same as UIViewContentModeScaleToFill.
 */
CGRect __CGRectFitWithContentMode(CGRect rect, CGSize size, UIViewContentMode mode);

// main screen's scale
#ifndef kScreenScale
#define kScreenScale __ScreenScale()
#endif

// main screen's size (portrait)
#ifndef kScreenSize
#define kScreenSize __ScreenSize()
#endif

// main screen's width (portrait)
#ifndef kScreenWidth
#define kScreenWidth __ScreenSize().width
#endif

// main screen's height (portrait)
#ifndef kScreenHeight
#define kScreenHeight __ScreenSize().height
#endif

NS_ASSUME_NONNULL_END

__END_DECLS
