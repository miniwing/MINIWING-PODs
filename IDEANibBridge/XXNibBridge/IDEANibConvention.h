// IDEANibConvention.h
// Version 2.2
//
// Copyright (c) 2015 sunnyxx ( http://github.com/sunnyxx )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

@protocol IDEANibConvention <NSObject>

/// Class name by convention.
+ (NSString *)nibID;

/// Nib file in main bundle with class name by convention.
+ (UINib *)nib;

@end

//@protocol IDEADeprecatedNibConvention <NSObject>
//
///// See `+ nibID`, I don't like this selector.
//+ (NSString *)xx_nibID;
//
///// See `+ nib`, I don't like this selector.
//+ (UINib *)xx_nib;
//
//@end

@interface UIView (IDEANibConvention) <IDEANibConvention>

/// Instantiate from `+ nib` with no owner, no options.
///
/// Required:
///   FooView.h, FooView.m, FooView.xib
/// Usage:
///   FooView *view = [FooView instantiateFromNib];
///
+ (id)instantiateFromNib;

/// See `+ instantiateFromNib` but with bundle and owner.
+ (id)instantiateFromNibInBundle:(NSBundle *)bundle owner:(id)owner;

@end

@interface UIViewController (IDEANibConvention) <IDEANibConvention>

/// Instantiate from given storyboard which class name as its `storyboard identifier`
+ (id)instantiateFromStoryboardNamed:(NSString *)name;

@end
