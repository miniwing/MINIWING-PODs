//
// UITextView.h
//
//	MIT License
//
// Created by Harry on 15/10/26.
// Copyright © 2015年 Harry. All rights reserved.
//
// Mail:iidioter@gmail.com
// TEL :+(852)53054612

#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
	// UITextAlignment is deprecated in iOS 6.0+, use NSTextAlignment instead.
	// Reference: https://developer.apple.com/library/ios/documentation/uikit/reference/NSString_UIKit_Additions/Reference/Reference.html
#   define NSTextAlignment UITextAlignment
#endif

@class UIGrowingTextView;
@class UITextViewInternal;

@protocol UIGrowingTextViewDelegate

@optional
- (BOOL)growingTextViewShouldBeginEditing:(UIGrowingTextView *)aGrowingTextView;
- (BOOL)growingTextViewShouldEndEditing:(UIGrowingTextView *)aGrowingTextView;

- (void)growingTextViewDidBeginEditing:(UIGrowingTextView *)aGrowingTextView;
- (void)growingTextViewDidEndEditing:(UIGrowingTextView *)aGrowingTextView;

- (BOOL)growingTextView:(UIGrowingTextView *)aGrowingTextView shouldChangeTextInRange:(NSRange)aRange replacementText:(NSString *)aText;
- (void)growingTextViewDidChange:(UIGrowingTextView *)aGrowingTextView;

- (void)growingTextView:(UIGrowingTextView *)aGrowingTextView willChangeHeight:(float)aHeight;
- (void)growingTextView:(UIGrowingTextView *)aGrowingTextView didChangeHeight:(float)aHeight;

- (void)growingTextViewDidChangeSelection:(UIGrowingTextView *)aGrowingTextView;
- (BOOL)growingTextViewShouldReturn:(UIGrowingTextView *)aGrowingTextView;

@end

@interface UIGrowingTextView : UIView <UITextViewDelegate>

//real class properties
@property (nonatomic, assign)             int                                   maxNumberOfLines;
@property (nonatomic, assign)             int                                   minNumberOfLines;
@property (nonatomic, assign)             int                                   maxHeight;
@property (nonatomic, assign)             int                                   minHeight;
@property (nonatomic, assign)             BOOL                                  animateHeightChange;
@property (nonatomic, assign)             NSTimeInterval                        animationDuration;
@property (nonatomic, strong)             NSString                            * placeholder;
@property (nonatomic, strong)             UIColor                             * placeholderColor;
@property (nonatomic, strong)             UITextView                          * internalTextView;

//uitextview properties
@property (nonatomic, weak)               NSObject<UIGrowingTextViewDelegate> * delegate;
@property (nonatomic, strong)             NSString                            * text;
@property (nonatomic, strong)             UIFont                              * font;
@property (nonatomic, strong)             UIColor                             * textColor;
@property (nonatomic, assign)             NSTextAlignment                       textAlignment;    // default is NSTextAlignmentLeft
@property (nonatomic, assign)             NSRange                               selectedRange;            // only ranges of length 0 are supported
@property (nonatomic, assign, getter=isEditable)   BOOL                         editable;
@property (nonatomic, assign)             UIDataDetectorTypes                   dataDetectorTypes __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_3_0);
@property (nonatomic, assign)             UIReturnKeyType                       returnKeyType;
@property (nonatomic, assign)             UIKeyboardType                        keyboardType;
@property (nonatomic, assign)             UIEdgeInsets                          contentInset;
@property (nonatomic, assign)             BOOL                                  isScrollable;
@property (nonatomic, assign)             BOOL                                  enablesReturnKeyAutomatically;

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
- (id)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer;
#endif

//uitextview methods
//need others? use .internalTextView
- (BOOL)becomeFirstResponder;
- (BOOL)resignFirstResponder;
- (BOOL)isFirstResponder;

- (BOOL)hasText;
- (void)scrollRangeToVisible:(NSRange)range;

// call to force a height change (e.g. after you change max/min lines)
- (void)refreshHeight;

@end
