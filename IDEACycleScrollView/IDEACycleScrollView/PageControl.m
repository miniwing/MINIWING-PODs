//
//  PageControl.m
//  PageControl
//
//  Created by QuintGao on 2019/9/21.
//  Copyright © 2019 QuintGao. All rights reserved.
//

#import "PageControl.h"

@interface PageDotView : UIView

@property (nonatomic, assign)                NSInteger                             numberOfPages;
@property (nonatomic, assign)                NSInteger                             currentPage;
@property (nonatomic, strong)                UIColor                             * pageIndicatorColor;
@property (nonatomic, strong)                UIColor                             * currentPageIndicatorColor;

@property (nonatomic, assign)                CGFloat                               dotWidth;
@property (nonatomic, assign)                CGFloat                               dotHeight;
@property (nonatomic, assign)                CGFloat                               dotMargin;

@end

@implementation PageDotView

- (void)setCurrentPage:(NSInteger)currentPage {
   if (_currentPage == currentPage) return;
   
   _currentPage = MIN(currentPage, self.numberOfPages - 1);
   
   for (NSInteger i = 0; i < self.numberOfPages; i++) {
      UIView *dotView = self.subviews[i];
      if (currentPage == i) {
         dotView.backgroundColor = self.currentPageIndicatorColor;
      }else {
         dotView.backgroundColor = self.pageIndicatorColor;
      }
   }
   [self layoutSubviews];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
   if (_numberOfPages == numberOfPages) return;
   _numberOfPages = MAX(0, numberOfPages);
   [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
   for (NSInteger i = 0; i < numberOfPages; i++) {
      UIView *dotView = [UIView new];
      if (self.currentPage == i) {
         dotView.backgroundColor = self.currentPageIndicatorColor;
      }else {
         dotView.backgroundColor = self.pageIndicatorColor;
      }
      dotView.layer.cornerRadius = self.dotHeight * 0.5f;
      dotView.layer.masksToBounds = YES;
      [self addSubview:dotView];
   }
   [self layoutSubviews];
}

- (void)layoutSubviews {
   
   [super layoutSubviews];
   
   CGFloat selectW = 2 * self.dotWidth + self.dotMargin;
   
   CGFloat viewX = (self.frame.size.width - self.dotWidth * (self.numberOfPages + 1) - self.dotMargin * self.numberOfPages) / 2;
   CGFloat viewY = (self.frame.size.height - self.dotHeight) / 2;
   
   for (NSInteger i = 0; i < self.numberOfPages; i++) {
      UIView *dotView = self.subviews[i];
      
      if (self.currentPage == i) {
         dotView.frame = CGRectMake(viewX, viewY, selectW, self.dotHeight);
         viewX += selectW + self.dotMargin;
      }else {
         dotView.frame = CGRectMake(viewX, viewY, self.dotWidth, self.dotHeight);
         viewX += self.dotWidth + self.dotMargin;
      }
   }
}

@end

@interface PageControl()

@property (nonatomic, strong) PageDotView *pageDotView;

@end

@implementation PageControl

- (instancetype)initWithFrame:(CGRect)frame {
   if (self = [super initWithFrame:frame]) {
      
      self.style                          = PageControlStyleCycle;
      self.pageIndicatorTintColor         = UIColor.grayColor;
      self.currentPageIndicatorTintColor  = UIColor.whiteColor;
      
      self.dotWidth  = 8;
      self.dotHeight = 8;
      self.dotMargin = 8;
   }
   return self;
}

- (instancetype)initWithCoder:(NSCoder *)aCoder {

   if (self = [super initWithCoder:aCoder]) {
      
      self.style                          = PageControlStyleCycle;
      self.pageIndicatorTintColor         = UIColor.grayColor;
      self.currentPageIndicatorTintColor  = UIColor.whiteColor;

      self.dotWidth  = 8;
      self.dotHeight = 8;
      self.dotMargin = 8;
      
   } /* End if () */

   return self;
}


- (void)setStyle:(PageControlStyle)style {
   _style = style;
   
   if (style == PageControlStyleRectangle) {
      self.dotWidth = 20;
      self.dotHeight = 4;
   }else if (style == PageControlStyleSizeDot) {
      self.pageDotView.dotWidth = self.dotWidth;
      self.pageDotView.dotHeight = self.dotHeight;;
      self.pageDotView.dotMargin = self.dotMargin;
      [self.pageDotView layoutSubviews];
   }
}

- (void)setDotWidth:(CGFloat)dotWidth {
   _dotWidth = dotWidth;
   
   if (self.style == PageControlStyleSizeDot) {
      self.pageDotView.dotWidth = dotWidth;
      [self.pageDotView layoutSubviews];
   }
}

- (void)setDotHeight:(CGFloat)dotHeight {
   _dotHeight = dotHeight;
   
   if (self.style == PageControlStyleSizeDot) {
      self.pageDotView.dotHeight = dotHeight;
      [self.pageDotView layoutSubviews];
   }
}

- (void)setDotMargin:(CGFloat)dotMargin {
   _dotMargin = dotMargin;
   
   if (self.style == PageControlStyleSizeDot) {
      self.pageDotView.dotMargin = dotMargin;
      [self.pageDotView layoutSubviews];
   }
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
   [super setNumberOfPages:numberOfPages];
   
   if (self.style == PageControlStyleSystem) return;
   
   [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
   if (self.style == PageControlStyleSizeDot) {
      [self addSubview:self.pageDotView];
      self.pageDotView.numberOfPages = numberOfPages;
      return;
   }
   
   for (NSInteger i = 0; i < numberOfPages; i++) {
      UIView *dotView = [UIView new];
      dotView.tag = [dotView hash] + i;
      
      if (self.hidesForSinglePage && numberOfPages == 1) {
         dotView.hidden = YES;
      }
      
      [self addSubview:dotView];
   }
}

- (void)setCurrentPage:(NSInteger)currentPage {
   [super setCurrentPage:currentPage];
   
   if (self.style == PageControlStyleSystem) return;
   
   if (self.style == PageControlStyleSizeDot) {
      self.pageDotView.currentPage = currentPage;
      return;
   }
   
   [super setCurrentPage:currentPage];
   
   [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      obj.backgroundColor = currentPage == idx ? self.currentPageIndicatorTintColor : self.pageIndicatorTintColor;
   }];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
   [super setPageIndicatorTintColor:pageIndicatorTintColor];
   
   if (self.style == PageControlStyleSizeDot) {
      self.pageDotView.pageIndicatorColor = pageIndicatorTintColor;
   }
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
   [super setCurrentPageIndicatorTintColor:currentPageIndicatorTintColor];
   
   if (self.style == PageControlStyleSizeDot) {
      self.pageDotView.currentPageIndicatorColor = currentPageIndicatorTintColor;
   }
}

- (void)layoutSubviews {
   [super layoutSubviews];
   
   if (self.style == PageControlStyleSystem) return;
   
   [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      if (obj.tag == [obj hash] + idx) {
         
         switch (self.style) {
            case PageControlStyleCycle: {
               CGFloat objW = self.dotWidth;
               CGFloat objH = self.dotHeight;
               
               CGFloat originX = (self.frame.size.width - objW * self.numberOfPages - self.dotMargin * (self.numberOfPages - 1)) / 2;
               CGFloat objX = originX + (self.dotMargin + objW) * idx;
               CGFloat objy = (self.frame.size.height - objH) / 2;
               
               obj.frame = CGRectMake(objX, objy, objW, objH);
               obj.layer.cornerRadius = objW / 2;
               obj.layer.masksToBounds = YES;
            }
               break;
            case PageControlStyleRectangle: {
               CGFloat objW = self.dotWidth;
               CGFloat objH = self.dotHeight;
               
               CGFloat originX = (self.frame.size.width - objW * self.numberOfPages - self.dotMargin * (self.numberOfPages - 1)) / 2;
               CGFloat objX = originX + (self.dotMargin + objW) * idx;
               CGFloat objy = (self.frame.size.height - objH) / 2;
               
               obj.frame = CGRectMake(objX, objy, objW, objH);
            }
               break;
            case PageControlStyleSquare: {
               CGFloat objW = self.dotWidth;
               CGFloat objH = self.dotHeight;
               
               CGFloat originX = (self.frame.size.width - objW * self.numberOfPages - self.dotMargin * (self.numberOfPages - 1)) / 2;
               CGFloat objX = originX + (self.dotMargin + objW) * idx;
               CGFloat objy = (self.frame.size.height - objH) / 2;
               
               obj.frame = CGRectMake(objX, objy, objW, objH);
            }
               break;
            case PageControlStyleSizeDot:
               obj.frame = self.bounds;
               break;
            default:
               break;
         }
      }else {
         [obj removeFromSuperview];
      }
   }];
}

#pragma mark - 懒加载
- (PageDotView *)pageDotView {
   if (!_pageDotView) {
      _pageDotView = [[PageDotView alloc] initWithFrame:self.bounds];
      _pageDotView.pageIndicatorColor = self.pageIndicatorTintColor;
      _pageDotView.currentPageIndicatorColor = self.currentPageIndicatorTintColor;
      _pageDotView.tag = [_pageDotView hash];
   }
   return _pageDotView;
}

@end
