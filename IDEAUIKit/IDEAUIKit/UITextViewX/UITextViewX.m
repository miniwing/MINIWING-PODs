//
// UITextViewInternal.m
// UIGrowingTextView
//
//  Created by Hans Pinckaers on 29-06-10.
//
//	MIT License
//
//	Copyright (c) 2011 Hans Pinckaers
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

#import "IDEAUIKit/UITextViewX.h"

@implementation UITextViewX

- (id)initWithFrame:(CGRect)frame {
   
   if (self = [super initWithFrame:frame]) {
      
      self.textAlignment = NSTextAlignmentCenter;
      [self addObserver:self forKeyPath:@"contentSize" options: (NSKeyValueObservingOptionNew) context:NULL];
      
   }
   
   return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
   
   if (self = [super initWithCoder:aDecoder]) {
      
      self.textAlignment = NSTextAlignmentCenter;
      
      [self addObserver:self forKeyPath:@"contentSize" options: (NSKeyValueObservingOptionNew) context:NULL];
   }
   
   return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
   
   if ([keyPath isEqualToString:@"contentSize"]) {
      
      UITextView *tv = object;
      CGFloat deadSpace = ([tv bounds].size.height - [tv contentSize].height);
      CGFloat inset = MAX(0, deadSpace/2.0);
      tv.contentInset = UIEdgeInsetsMake(inset, tv.contentInset.left, inset, tv.contentInset.right);
   }
}

- (void)dealloc {

   __LOG_FUNCTION;

   // Custom dealloc
   [self removeObserver:self forKeyPath:@"contentSize"];

   __SUPER_DEALLOC;

   return;
}

@end
