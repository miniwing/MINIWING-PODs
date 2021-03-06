//
//  YYFPSLabel.m
//  UILabel+FPS
//
//  Created by Harry on 15/9/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YYFPSLabel.h"

#if FPS_LABEL

#define kSize CGSizeMake(48, 18)

@implementation YYFPSLabel {
   CADisplayLink *_link;
   NSUInteger _count;
   NSTimeInterval _lastTime;
   UIFont *_font;
   UIFont *_subFont;
   
   NSTimeInterval _llll;
}

- (instancetype)initWithFrame:(CGRect)frame {
   if (frame.size.width == 0 && frame.size.height == 0) {
      frame.size = kSize;
   }
   self = [super initWithFrame:frame];
   
   self.layer.cornerRadius = 4;
   self.clipsToBounds = YES;
   self.textAlignment = NSTextAlignmentCenter;
   self.userInteractionEnabled = NO;
   self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
   
   _font = [UIFont fontWithName:@"Zekton" size:10];
   if (_font) {
      _subFont = [UIFont fontWithName:@"Zekton" size:4];
   }
   else {
      _font = [UIFont systemFontOfSize:10];
      _subFont = [UIFont systemFontOfSize:4];
   }
   
#if YY_KIT
   _link = [CADisplayLink displayLinkWithTarget:[YYWeakProxy proxyWithTarget:self] selector:@selector(tick:)];
   [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
#endif /* YY_KIT */
   
   return self;
}

- (void)dealloc {
#if YY_KIT
   [_link invalidate];
#endif /* YY_KIT */
   
   return;
}

- (CGSize)sizeThatFits:(CGSize)size {
   return kSize;
}

- (void)tick:(CADisplayLink *)link {
   if (_lastTime == 0) {
      _lastTime = link.timestamp;
      return;
   }
   
   _count++;
   NSTimeInterval delta = link.timestamp - _lastTime;
   if (delta < 1) return;
   _lastTime = link.timestamp;
   float fps = _count / delta;
   _count = 0;
   
   CGFloat progress = fps / 60.0;
   UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
   
   NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
#if YY_KIT
   [text setColor:color range:NSMakeRange(0, text.length - 3)];
   [text setColor:UIColor.whiteColor range:NSMakeRange(text.length - 3, 3)];
   text.font = _font;
   [text setFont:_subFont range:NSMakeRange(text.length - 4, 1)];
#endif /* YY_KIT */
   
   self.attributedText = text;
}

@end

#endif /* FPS_LABEL */
