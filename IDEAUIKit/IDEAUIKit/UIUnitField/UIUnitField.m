//
//  UIUnitField.m
//  UIUnitField
//
//  Created by Harry on 2019/9/18.
//  Copyright © 2019 Harry. All rights reserved.
//

#import "UIUnitField.h"
#import "UIUnitFieldTextRange.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
NSNotificationName const UIUnitFieldDidBecomeFirstResponderNotification = @"UIUnitFieldDidBecomeFirstResponderNotification";
NSNotificationName const UIUnitFieldDidResignFirstResponderNotification = @"UIUnitFieldDidResignFirstResponderNotification";
#else
NSString *const UIUnitFieldDidBecomeFirstResponderNotification = @"UIUnitFieldDidBecomeFirstResponderNotification";
NSString *const UIUnitFieldDidResignFirstResponderNotification = @"UIUnitFieldDidResignFirstResponderNotification";
#endif

@interface UIUnitField ()

@property (nonatomic, strong) NSMutableArray <NSString*> * characterArray;
@property (nonatomic, strong) CALayer                    * cursorLayer;

@end

@implementation UIUnitField
{
   UIColor        *mBackgroundColor;
   CGContextRef    mCtx;
   
   NSString       *mMarkedText;
}

@dynamic text;
@synthesize textContentType               = _textContentType;
@synthesize secureTextEntry               = _secureTextEntry;
@synthesize enablesReturnKeyAutomatically = _enablesReturnKeyAutomatically;
@synthesize keyboardType                  = _keyboardType;
@synthesize returnKeyType                 = _returnKeyType;

@synthesize autocapitalizationType        = _autocapitalizationType;
@synthesize autocorrectionType            = _autocorrectionType;

@synthesize inputDelegate                 = _inputDelegate;
@synthesize selectedTextRange             = _selectedTextRange;
@synthesize markedTextStyle               = _markedTextStyle;
@synthesize tokenizer                     = _tokenizer;

#pragma mark - Life

- (instancetype)initWithInputUnitCount:(NSUInteger)count {
   return [self initWithStyle:UIUnitFieldStyleBorder inputUnitCount:count];
}

- (instancetype)initWithStyle:(UIUnitFieldStyle)style inputUnitCount:(NSUInteger)count {
   if (self = [super initWithFrame:CGRectZero]) {
      NSCAssert(count > 0, @"UIUnitField must have one or more input units.");
      NSCAssert(count <= 8, @"UIUnitField can not have more than 8 input units.");
      
      _style = style;
      _inputUnitCount = count;
      [self initialize];
   }
   
   return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
   if (self = [super initWithFrame:frame]) {
      _inputUnitCount = 4;
      [self initialize];
   }
   
   return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
   if (self = [super initWithCoder:aDecoder]) {
      _inputUnitCount = 4;
      [self initialize];
   }
   
   return self;
}

- (void)initialize {
   [self setBackgroundColor:[UIColor clearColor]];
   self.opaque = NO;
   _characterArray   = [NSMutableArray array];
   _secureTextEntry  = NO;
   _unitSpace        = 12;
   _unitSize         = CGSizeMake(44, 44);
   _borderRadius     = 0;
   _borderWidth      = 1;
   _textFont         = [UIFont systemFontOfSize:22];
   _keyboardType     = UIKeyboardTypeNumberPad;
   _returnKeyType    = UIReturnKeyDone;
   _enablesReturnKeyAutomatically = YES;
   _autoResignFirstResponderWhenInputFinished = NO;
   _textColor        = [UIColor darkGrayColor];
   _tintColor        = [UIColor lightGrayColor];
   _trackTintColor   = [UIColor orangeColor];
   _cursorColor      = [UIColor orangeColor];
   mBackgroundColor  = mBackgroundColor ?: [UIColor clearColor];
   _autocorrectionType     = UITextAutocorrectionTypeNo;
   _autocapitalizationType = UITextAutocapitalizationTypeNone;
   self.cursorLayer.backgroundColor = _cursorColor.CGColor;
   
   UIUnitFieldTextPosition *point      = [UIUnitFieldTextPosition positionWithOffset:0];
   UITextRange             *aNewRange  = [UIUnitFieldTextRange rangeWithStart:point end:point];
   [self setSelectedTextRange:aNewRange];
   
   if (@available(iOS 12.0, *)) {
      _textContentType = UITextContentTypeOneTimeCode;
   }
   
   [self.layer addSublayer:self.cursorLayer];
   [self setNeedsDisplay];
   
   return;
}

#pragma mark - Property

- (NSString *)text {
   if (_characterArray.count == 0) return nil;
   return [_characterArray componentsJoinedByString:@""];
}

- (void)setText:(NSString *)aText
{
   
   if (_autoUpcase)
   {
      aText = [aText uppercaseString];
      
   } /* End if () */
   
   [_characterArray removeAllObjects];
   [aText enumerateSubstringsInRange:NSMakeRange(0, aText.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
      if (self.characterArray.count < self.inputUnitCount) {
         [self.characterArray addObject:substring];
      }
      else {
         *stop = YES;
      }
   }];
   
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];
   
   /**
    Supporting iOS12 SMS verification code, setText will be called when verification code input.
    */
   if (_characterArray.count >= _inputUnitCount) {
      if (_autoResignFirstResponderWhenInputFinished == YES) {
         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self resignFirstResponder];
         }];
      }
      return;
   }
}

- (CALayer *)cursorLayer {
   if (!_cursorLayer) {
      _cursorLayer = [CALayer layer];
      _cursorLayer.hidden = YES;
      _cursorLayer.opacity = 1;
      
      mMarkedText = nil;
      
      CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"opacity"];
      animate.fromValue = @(0);
      animate.toValue = @(1.5);
      animate.duration = 0.5;
      animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
      animate.autoreverses = YES;
      animate.removedOnCompletion = NO;
      animate.fillMode = kCAFillModeForwards;
      animate.repeatCount = HUGE_VALF;
      
      
      [_cursorLayer addAnimation:animate forKey:nil];
      
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
         [self layoutIfNeeded];
         
         self.cursorLayer.position = CGPointMake(CGRectGetWidth(self.bounds) / self.inputUnitCount / 2, CGRectGetHeight(self.bounds) / 2);
      }];
      
   }
   
   return _cursorLayer;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
   _secureTextEntry = secureTextEntry;
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];
}

#if TARGET_INTERFACE_BUILDER
- (void)setInputUnitCount:(NSUInteger)inputUnitCount {
   inputUnitCount = MAX(1, MIN(8, inputUnitCount));
   
   _inputUnitCount = inputUnitCount;
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];

   return;
}

- (void)setStyle:(NSUInteger)style {
   _style = style;
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];

   return;
}
#endif

- (void)setUnitSpace:(NSUInteger)unitSpace {
   if (unitSpace < 2) unitSpace = 0;
   
   _unitSpace = unitSpace;
   [self _resize];
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];

   return;
}

- (void)setTextFont:(UIFont *)textFont {
   if (textFont == nil) {
      _textFont = [UIFont systemFontOfSize:22];
   }
   else {
      _textFont = textFont;
   }
   
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];

   return;
}

- (void)setTextColor:(UIColor *)textColor {
   if (textColor == nil) {
      _textColor = [UIColor blackColor];
   }
   else {
      _textColor = textColor;
   }
   
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];

   return;
}

- (void)setBorderRadius:(CGFloat)borderRadius {
   if (borderRadius < 0) {
      return;
   }
   
   _borderRadius = borderRadius;
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];

   return;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
   if (borderWidth < 0) {
      return;
   }
   
   _borderWidth = borderWidth;
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];
   
   return;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
   mBackgroundColor = backgroundColor;
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];

   return;
}

- (void)setTintColor:(UIColor *)tintColor {
   _tintColor = tintColor;
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];

   return;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor {
   _trackTintColor = trackTintColor;
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];

   return;
}

- (void)setCursorColor:(UIColor *)cursorColor {
   _cursorColor = cursorColor;
   _cursorLayer.backgroundColor = _cursorColor.CGColor;
   [self _resetCursorStateIfNeeded];

   return;
}

- (void)setUnitSize:(CGSize)unitSize {
   _unitSize = unitSize;
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];

   return;
}

#pragma mark- Event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   [super touchesBegan:touches withEvent:event];
   [self becomeFirstResponder];

   return;
}

#pragma mark - Override

- (CGSize)intrinsicContentSize {
   
   return CGSizeMake(_inputUnitCount * (_unitSize.width + _unitSpace) - _unitSpace ,
                     _unitSize.height);
}


- (CGSize)sizeThatFits:(CGSize)size {
   return [self intrinsicContentSize];
}


- (BOOL)canBecomeFirstResponder {
   return YES;
}


- (BOOL)becomeFirstResponder {
   BOOL result = [super becomeFirstResponder];
   [self _resetCursorStateIfNeeded];
   
   if (result ==  YES) {
      [self sendActionsForControlEvents:UIControlEventEditingDidBegin];
      [[NSNotificationCenter defaultCenter] postNotificationName:UIUnitFieldDidBecomeFirstResponderNotification object:nil];
   }
   
   return result;
}


- (BOOL)canResignFirstResponder {
   return YES;
}


- (BOOL)resignFirstResponder {
   BOOL result = [super resignFirstResponder];
   [self _resetCursorStateIfNeeded];
   
   if (result) {
      [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
      [[NSNotificationCenter defaultCenter] postNotificationName:UIUnitFieldDidResignFirstResponderNotification object:nil];
   }
   
   return result;
}


- (void)drawRect:(CGRect)rect {
   /*
    *  绘制的线条具有宽度，因此在绘制时需要考虑该因素对绘制效果的影响。
    */
   CGSize unitSize = CGSizeMake((rect.size.width + _unitSpace) / _inputUnitCount - _unitSpace, rect.size.height);
   mCtx = UIGraphicsGetCurrentContext();
   
   [self _fillRect:rect unitSize:unitSize];
   [self _drawBorder:rect unitSize:unitSize];
   [self _drawText:rect unitSize:unitSize];
   [self _drawTrackBorder:rect unitSize:unitSize];

   return;
}

#pragma mark- Private

/**
 在 AutoLayout 环境下重新指定控件本身的固有尺寸
 
 `-drawRect:`方法会计算控件完成自身的绘制所需的合适尺寸，完成一次绘制后会通知 AutoLayout 系统更新尺寸。
 */
- (void)_resize {
   [self invalidateIntrinsicContentSize];
}

/**
 绘制背景色，以及剪裁绘制区域
 
 @param rect 控件绘制的区域
 */
- (void)_fillRect:(CGRect)rect unitSize:(CGSize)unitSize {
   [mBackgroundColor setFill];
   CGFloat radius = _style == UIUnitFieldStyleBorder ? _borderRadius : 0;
   
   if (_unitSpace < 2) {
      UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
      CGContextAddPath(mCtx, bezierPath.CGPath);
   }
   else {
      for (int H = 0; H < _inputUnitCount; ++H) {
         CGRect unitRect = CGRectMake(H * (unitSize.width + _unitSpace),
                                      0,
                                      unitSize.width,
                                      unitSize.height);
         unitRect = CGRectInset(unitRect, _borderWidth * 0.5, _borderWidth * 0.5);
         UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:unitRect cornerRadius:radius];
         CGContextAddPath(mCtx, bezierPath.CGPath);
      }
   }
   
   CGContextFillPath(mCtx);

   return;
}


/**
 绘制边框
 
 边框的绘制分为两种模式：连续和不连续。其模式的切换由`unitSpace`属性决定。
 当`unitSpace`值小于 2 时，采用的是连续模式，即每个 input unit 之间没有间隔。
 反之，每个 input unit 会被边框包围。
 
 @see unitSpace
 
 @param rect 控件绘制的区域
 @param unitSize 单个 input unit 占据的尺寸
 */
- (void)_drawBorder:(CGRect)rect unitSize:(CGSize)unitSize {
   
   CGRect bounds = CGRectInset(rect, _borderWidth * 0.5, _borderWidth * 0.5);
   
   if (_style == UIUnitFieldStyleBorder) {
      [self.tintColor setStroke];
      CGContextSetLineWidth(mCtx, _borderWidth);
      CGContextSetLineCap(mCtx, kCGLineCapRound);
      
      if (_unitSpace < 2) {
         UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:_borderRadius];
         CGContextAddPath(mCtx, bezierPath.CGPath);
         
         for (int H = 1; H < _inputUnitCount; ++H) {
            CGContextMoveToPoint(mCtx, (H * unitSize.width), 0);
            CGContextAddLineToPoint(mCtx, (H * unitSize.width), (unitSize.height));
         }
         
      }
      else {
         for (int H = (int)_characterArray.count; H < _inputUnitCount; H++) {
            CGRect unitRect = CGRectMake(H * (unitSize.width + _unitSpace),
                                         0,
                                         unitSize.width,
                                         unitSize.height);
            unitRect = CGRectInset(unitRect, _borderWidth * 0.5, _borderWidth * 0.5);
            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:unitRect cornerRadius:_borderRadius];
            CGContextAddPath(mCtx, bezierPath.CGPath);
         }
      }
      
      CGContextDrawPath(mCtx, kCGPathStroke);
   }
   else {
      
      [self.tintColor setFill];
      for (int H = (int)_characterArray.count; H < _inputUnitCount; H++) {
         CGRect unitLineRect = CGRectMake(H * (unitSize.width + _unitSpace),
                                          unitSize.height - _borderWidth,
                                          unitSize.width,
                                          _borderWidth);
         UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:unitLineRect cornerRadius:_borderRadius];
         CGContextAddPath(mCtx, bezierPath.CGPath);
      }
      
      CGContextDrawPath(mCtx, kCGPathFill);
   }

   return;
}


/**
 绘制文本
 
 当处于密文输入模式时，会用圆圈替代文本。
 
 @param rect 控件绘制的区域
 @param unitSize 单个 input unit 占据的尺寸
 */
- (void)_drawText:(CGRect)rect unitSize:(CGSize)unitSize {
   
   if ([self hasText] == NO) {
      return;
   }
   
//   NSMutableParagraphStyle *stStyle    = [[NSMutableParagraphStyle alloc] init];
//   [stStyle setAlignment:_textAlignment];
   
   NSDictionary            *stTextAttr = @{NSForegroundColorAttributeName : _textColor,
//                                           NSParagraphStyleAttributeName  : stStyle,
                                           NSFontAttributeName            : _textFont};
      
   for (int H = 0; H < _characterArray.count; H++) {
      
      CGRect unitRect = CGRectMake(H * (unitSize.width + _unitSpace),
                                   0,
                                   unitSize.width,
                                   unitSize.height);
      
      CGFloat yOffset = (_style == UIUnitFieldStyleBorder) ? 0 : _borderWidth;
      
      if (_secureTextEntry == NO) {
         NSString *subString = [_characterArray objectAtIndex:H];
         
         CGSize oneTextSize = [subString sizeWithAttributes:stTextAttr];
         CGRect drawRect = CGRectInset(unitRect,
                                       (unitRect.size.width - oneTextSize.width) / 2,
                                       (unitRect.size.height - oneTextSize.height) / 2);
         drawRect.size.height -= yOffset;
         
         NSDictionary      *stDrawAttributes = @{NSFontAttributeName             : _textFont,
                                                 NSForegroundColorAttributeName  : _textColor};
         
         NSAttributedString*stDrawText       = [[NSAttributedString alloc] initWithString:subString
                                                                               attributes:stDrawAttributes];
         
//         [subString drawInRect:drawRect withAttributes:stTextAttr];
         [stDrawText drawAtPoint:drawRect.origin];
      }
      else {
         CGRect drawRect = CGRectInset(unitRect,
                                       (unitRect.size.width - _textFont.pointSize / 2) / 2,
                                       (unitRect.size.height - _textFont.pointSize / 2) / 2);
         drawRect.size.height -= yOffset;
         [_textColor setFill];
         CGContextAddEllipseInRect(mCtx, drawRect);
         CGContextFillPath(mCtx);
      }
   }
   
   return;
}


/**
 绘制跟踪框，如果指定的`trackTintColor`为 nil 则不绘制
 
 @param rect 控件绘制的区域
 @param unitSize 单个 input unit 占据的尺寸
 */
- (void)_drawTrackBorder:(CGRect)rect unitSize:(CGSize)unitSize {
   if (_trackTintColor == nil) return;
   
   if (_style == UIUnitFieldStyleBorder) {
      if (_unitSpace < 2) return;
      
      [_trackTintColor setStroke];
      CGContextSetLineWidth(mCtx, _borderWidth);
      CGContextSetLineCap(mCtx, kCGLineCapRound);
      
      for (int H = 0; H < _characterArray.count; H++) {
         CGRect unitRect = CGRectMake(H * (unitSize.width + _unitSpace),
                                      0,
                                      unitSize.width,
                                      unitSize.height);
         unitRect = CGRectInset(unitRect, _borderWidth * 0.5, _borderWidth * 0.5);
         UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:unitRect cornerRadius:_borderRadius];
         CGContextAddPath(mCtx, bezierPath.CGPath);
      }
      
      CGContextDrawPath(mCtx, kCGPathStroke);
   }
   else {
      [_trackTintColor setFill];
      
      for (int H = 0; H < _characterArray.count; H++) {
         CGRect unitLineRect = CGRectMake(H * (unitSize.width + _unitSpace),
                                          unitSize.height - _borderWidth,
                                          unitSize.width,
                                          _borderWidth);
         UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:unitLineRect cornerRadius:_borderRadius];
         CGContextAddPath(mCtx, bezierPath.CGPath);
      }
      
      CGContextDrawPath(mCtx, kCGPathFill);
   }
   
   return;
}


- (void)_resetCursorStateIfNeeded {
   dispatch_async(dispatch_get_main_queue(), ^{
      self->_cursorLayer.hidden = !self.isFirstResponder || self->_cursorColor == nil || self->_inputUnitCount == self->_characterArray.count;
      
      if (self->_cursorLayer.hidden) return;
      
      CGSize unitSize = CGSizeMake((self.bounds.size.width + self->_unitSpace) / self->_inputUnitCount - self->_unitSpace, self.bounds.size.height);
      
      CGRect unitRect = CGRectMake(self->_characterArray.count * (unitSize.width + self->_unitSpace),
                                   0,
                                   unitSize.width,
                                   unitSize.height);
      unitRect = CGRectInset(unitRect,
                             unitRect.size.width / 2 - 1,
                             (unitRect.size.height - self->_textFont.pointSize) / 2);
      
      CGFloat yOffset = self->_style == UIUnitFieldStyleBorder ? 0 : self->_borderWidth;
      unitRect.size.height -= yOffset;
      
      [CATransaction begin];
      [CATransaction setDisableActions:NO];
      [CATransaction setAnimationDuration:0];
      [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
      self->_cursorLayer.frame = unitRect;
      [CATransaction commit];
   });

   return;
}


#pragma mark - UIKeyInput

- (BOOL)hasText {
   return _characterArray != nil && _characterArray.count > 0;
}

- (void)insertText:(NSString *)aText {
   if ([aText isEqualToString:@"\n"]) {
      [self resignFirstResponder];
      return;
   }
   
   if ([aText isEqualToString:@" "]) {
      return;
   }
   
   if (_characterArray.count >= _inputUnitCount) {
      if (_autoResignFirstResponderWhenInputFinished == YES) {
         [self resignFirstResponder];
      }
      return;
   }
   
   if ([self.delegate respondsToSelector:@selector(unitField:shouldChangeCharactersInRange:replacementString:)]) {
      if ([self.delegate unitField:self shouldChangeCharactersInRange:NSMakeRange(self.text.length, aText.length) replacementString:aText] == NO) {
         return;
      }
   }

   if (_autoUpcase)
   {
      aText = [aText uppercaseString];
      
   } /* End if () */
   
   [_inputDelegate textWillChange:self];
   NSRange   stRange;
   for (int H = 0; H < aText.length; H += stRange.length) {
      stRange = [aText rangeOfComposedCharacterSequenceAtIndex:H];
      [_characterArray addObject:[aText substringWithRange:stRange]];
   }
   
   if (_characterArray.count >= _inputUnitCount) {
      [_characterArray removeObjectsInRange:NSMakeRange(_inputUnitCount, _characterArray.count - _inputUnitCount)];
      if (_autoResignFirstResponderWhenInputFinished == YES) {
         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self resignFirstResponder];
         }];
      }
   }
   
   [self sendActionsForControlEvents:UIControlEventEditingChanged];
   
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];
   [_inputDelegate textDidChange:self];

   return;
}


- (void)deleteBackward {
   if ([self hasText] == NO)
      return;
   
   [_inputDelegate textWillChange:self];
   [_characterArray removeLastObject];
   [self sendActionsForControlEvents:UIControlEventEditingChanged];
   
   [self setNeedsDisplay];
   [self _resetCursorStateIfNeeded];
   [_inputDelegate textDidChange:self];

   return;
}


/**
 Supporting iOS12 SMS verification code, keyboardType must be UIKeyboardTypeNumberPad to localizable.
 
 Must set textContentType to UITextContentTypeOneTimeCode
 */


// UITextInput implement.
#pragma mark - UITextInput

/* Methods for manipulating text. */
- (nullable NSString *)textInRange:(UIUnitFieldTextRange *)range {
   return self.text;
}

- (void)replaceRange:(UIUnitFieldTextRange *)range withText:(NSString *)text {
}


// selectedRange is a range within the markedText
- (void)setMarkedText:(nullable NSString *)markedText selectedRange:(NSRange)selectedRange {
   mMarkedText = markedText;
}

- (void)unmarkText {
   if (self.text.length >= self.inputUnitCount) {
      mMarkedText = nil;
      return;
   }
   
   [self insertText:mMarkedText];
   mMarkedText = nil;
}


/* The end and beginning of the the text document. */
- (UITextPosition *)beginningOfDocument {
   return [UIUnitFieldTextPosition positionWithOffset:0];
}

- (UITextPosition *)endOfDocument {
   if (self.text.length == 0) {
      return [UIUnitFieldTextPosition positionWithOffset:0];
   }
   return [UIUnitFieldTextPosition positionWithOffset:self.text.length - 1];
}


/* A tokenizer must be provided to inform the text input system about text units of varying granularity. */
- (id<UITextInputTokenizer>)tokenizer {
   if (!_tokenizer) {
      _tokenizer = [[UITextInputStringTokenizer alloc] initWithTextInput:self];
   }
   return _tokenizer;
}


// Nil if no marked text.
- (UITextRange *)markedTextRange {
   return nil;
}


/* Methods for creating ranges and positions. */
- (nullable UITextRange *)textRangeFromPosition:(UIUnitFieldTextPosition *)fromPosition toPosition:(UIUnitFieldTextPosition *)toPosition {
   NSRange range = NSMakeRange(MIN(fromPosition.offset, toPosition.offset), ABS(toPosition.offset - fromPosition.offset));
   return [UIUnitFieldTextRange rangeWithRange:range];
}

- (nullable UITextPosition *)positionFromPosition:(UIUnitFieldTextPosition *)position offset:(NSInteger)offset {
   NSInteger end = position.offset + offset;
   if (end > self.text.length || end < 0)
      return nil;
   return [UIUnitFieldTextPosition positionWithOffset:end];
}

- (nullable UITextPosition *)positionFromPosition:(UIUnitFieldTextPosition *)position inDirection:(UITextLayoutDirection)direction offset:(NSInteger)offset {
   return [UIUnitFieldTextPosition positionWithOffset:position.offset + offset];
}


/* Simple evaluation of positions */
- (NSComparisonResult)comparePosition:(UIUnitFieldTextPosition *)position toPosition:(UIUnitFieldTextPosition *)other {
   if (position.offset < other.offset) return NSOrderedAscending;
   if (position.offset > other.offset) return NSOrderedDescending;
   return NSOrderedSame;
}

- (NSInteger)offsetFromPosition:(UIUnitFieldTextPosition *)from toPosition:(UIUnitFieldTextPosition *)toPosition {
   return toPosition.offset - from.offset ;
}


/* Layout questions. */
- (nullable UITextPosition *)positionWithinRange:(UITextRange *)range farthestInDirection:(UITextLayoutDirection)direction { return nil; }
- (nullable UITextRange *)characterRangeByExtendingPosition:(UIUnitFieldTextPosition *)position inDirection:(UITextLayoutDirection)direction { return nil; }


/* Writing direction */
- (UITextWritingDirection)baseWritingDirectionForPosition:(UIUnitFieldTextPosition *)position inDirection:(UITextStorageDirection)direction { return UITextWritingDirectionNatural; }
- (void)setBaseWritingDirection:(UITextWritingDirection)writingDirection forRange:(UITextRange *)range {}


/* Geometry used to provide, for example, a correction rect. */
- (NSArray<UITextSelectionRect *> *)selectionRectsForRange:(UIUnitFieldTextRange *)range { return nil; }
- (CGRect)firstRectForRange:(UIUnitFieldTextRange *)range { return CGRectNull; }
- (CGRect)caretRectForPosition:(UIUnitFieldTextPosition *)position { return CGRectNull; }


/* Hit testing. */
- (nullable UITextRange *)characterRangeAtPoint:(CGPoint)point { return nil; }
- (nullable UITextPosition *)closestPositionToPoint:(CGPoint)point withinRange:(UIUnitFieldTextRange *)range { return nil; }
- (nullable UITextPosition *)closestPositionToPoint:(CGPoint)point { return nil; }

@end
