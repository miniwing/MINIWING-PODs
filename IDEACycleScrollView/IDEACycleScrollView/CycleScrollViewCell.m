//
//  CycleScrollViewCell.m
//  CycleScrollViewDemo
//
//  Created by QuintGao on 2019/9/15.
//  Copyright © 2019 QuintGao. All rights reserved.
//

#import "CycleScrollViewCell.h"

@implementation CycleScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame {
   
   if (self = [super initWithFrame:frame]) {
      
      self.clipsToBounds = YES;
      self.layer.cornerRadius = 10;
      
      [self setBackgroundColor:UIColor.clearColor];
      
      [self addSubview:self.imageView];
      [self addSubview:self.coverView];
      
      [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
      
      [self.imageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

      UITapGestureRecognizer *stTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
      [self addGestureRecognizer:stTapGesture];
      
   } /* End if () */
   
   return self;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)aTap {
   
   !self.onDidClick ? : self.onDidClick(self.tag);
   
   return;
}

- (void)setupCellFrame:(CGRect)frame {
   
   if (CGRectEqualToRect(self.imageView.frame, frame)) {
      
      return;
      
   } /* End if () */
   
   self.imageView.frame = frame;
   self.coverView.frame = frame;
   
   return;
}

#pragma mark - 懒加载
- (UIImageView *)imageView {

   if (!_imageView) {
      
      _imageView = [UIImageView new];

   } /* End if () */

   return _imageView;
}

- (UIView *)coverView {
   
   if (!_coverView) {
      
      _coverView = [UIView new];
      _coverView.backgroundColor = [UIColor blackColor];
      _coverView.userInteractionEnabled = NO;
      
   } /* End if () */
   
   return _coverView;
}

@end
