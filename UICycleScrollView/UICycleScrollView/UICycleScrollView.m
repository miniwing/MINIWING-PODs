//
//  UICycleScrollView.m
//  Idea
//
//  Created by Harry on 15/11/18.
//  Copyright © 2015年 Harry. All rights reserved.
//
//  Mail:iidioter@gmail.com
//  TEL :+(86)18668032582
//

#pragma clang diagnostic ignored                   "-Wcomma"
#pragma clang diagnostic ignored                   "-Wformat"
#pragma clang diagnostic ignored                   "-Wvarargs"
#pragma clang diagnostic ignored                   "-Wdocumentation"
#pragma clang diagnostic ignored                   "-Wwritable-strings"
#pragma clang diagnostic ignored                   "-Wunreachable-code"
#pragma clang diagnostic ignored                   "-Wshorten-64-to-32"
#pragma clang diagnostic ignored                   "-Wwritable-strings"
#pragma clang diagnostic ignored                   "-Wstrict-prototypes"
#pragma clang diagnostic ignored                   "-Wimplicit-retain-self"
#pragma clang diagnostic ignored                   "-Wundeclared-selector"
#pragma clang diagnostic ignored                   "-Wunguarded-availability"
#pragma clang diagnostic ignored                   "-Wunknown-warning-option"
#pragma clang diagnostic ignored                   "-Wdeprecated-declarations"
#pragma clang diagnostic ignored                   "-Wnonportable-include-path"
#pragma clang diagnostic ignored                   "-Wdeprecated-implementations"
#pragma clang diagnostic ignored                   "-Wmismatched-parameter-types"
#pragma clang diagnostic ignored                   "-Wobjc-redundant-literal-use"
#pragma clang diagnostic ignored                   "-Wblock-capture-autoreleasing"
#pragma clang diagnostic ignored                   "-Wtautological-pointer-compare"
#pragma clang diagnostic ignored                   "-Wdocumentation-deprecated-sync"
#pragma clang diagnostic ignored                   "-Wnullability-completeness-on-arrays"

#import "UIKitExtension/UIKitExtension.h"

#import "UICycleScrollView.h"
#import "NSTimer+Addition.h"


@interface UICycleScrollView () <UIScrollViewDelegate>

@property (nonatomic, assign)             NSInteger                             pagesCount;
@property (nonatomic, strong)             NSMutableArray<UIView *>            * contentViews;

@property (nonatomic, strong)             NSTimer                             * animationTimer;

@end

@implementation UICycleScrollView

- (void)dealloc
{
   __LOG_FUNCTION;
   
   // Custom dealloc
   
   __SUPER_DEALLOC;
   
   return;
}

- (void)awakeFromNib
{
   [super awakeFromNib];
   
   // Initialization code
   self.autoresizesSubviews = YES;
   
   if (nil == _scrollView)
   {
      _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
      [_scrollView setFrame:self.frame];
      
      [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
      
      [_scrollView setContentMode:UIViewContentModeCenter];
      [_scrollView setClipsToBounds:YES];
      
      [self addSubview:_scrollView];
      
   } /* End if () */
   
   if (self.cycleScrollDirection == CycleScrollVertical)
   {
      _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame), 3 * CGRectGetHeight(_scrollView.frame));
      _scrollView.contentOffset = CGPointMake(0,0);
      
   } /* End if () */
   else
   {
      _scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
      _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame), 0);
      
   } /* End else */
   
   [_scrollView setBackgroundColor:[UIColor clearColor]];
   [_scrollView setDelegate:self];
   [_scrollView setPagingEnabled:YES];
   [_scrollView setAlwaysBounceVertical:NO];
   
   LogDebug((@"frameHeight : %d", (int)self.height));
   
   if (nil == _pageControl)
   {
      _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height - 16, self.width, 16)];
      
      [_pageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin];
      
      [self addSubview:_pageControl];
      
   } /* End if () */
   
   [_pageControl setBackgroundColor:[UIColor clearColor]];
   [_pageControl setUserInteractionEnabled:NO];
   [_pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
   
#ifdef APP_TINT_COLOR
   _pageControl.currentPageIndicatorTintColor = APP_TINT_COLOR;
#else /* APP_TINT_COLOR */
   _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:120.0/255.0 green:180.0/255.0 blue:0.0/255.0 alpha:1];
#endif /* !APP_TINT_COLOR */
   
   return;
}

//- (void)setAnimationDuration:(CGFloat)aAnimationDuration
//{
//   int                            nErr                                     = EFAULT;
//
//   __TRY;
//
//   _animationDuration      = aAnimationDuration;
//
//   [_animationTimer invalidate];
//   __RELEASE(_animationTimer);
//
//   if (0 < _animationDuration)
//   {
//      _animationTimer   = [NSTimer scheduledTimerWithTimeInterval:_animationDuration
//                                                           target:self
//                                                         selector:@selector(animationTimerDidFired:)
//                                                         userInfo:nil
//                                                          repeats:YES];
//
//      [_animationTimer pauseTimer];
//
//   } /* End if () */
//
//   __CATCH(nErr);
//
//   return;
//}
//
//- (void)setSlideAnimationDuration:(CGFloat)aSlideAnimationDuration
//{
//   int                            nErr                                     = EFAULT;
//
//   __TRY;
//
//   _slideAnimationDuration = aSlideAnimationDuration;
//
//   __CATCH(nErr);
//
//   return;
//}

//- (void)setTintColor:(UIColor *)aTintColor
//{
//   [super setTintColor:aTintColor];
//
//   _pageControl.currentPageIndicatorTintColor = aTintColor;
//}

- (void)layoutSubviews
{
   [super layoutSubviews];
   
   [_scrollView setFrame:CGRectMake(0, 0, self.width, self.height)];
   if (_cycleScrollDirection == CycleScrollVertical)
   {
      _scrollView.contentSize    = CGSizeMake(CGRectGetWidth(self.frame), 3 * CGRectGetHeight(self.frame));
      _scrollView.contentOffset  = CGPointMake(0,0);
      
   } /* End if () */
   else
   {
      _scrollView.contentSize    = CGSizeMake(3 * CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
      _scrollView.contentOffset  = CGPointMake(CGRectGetWidth(self.frame), 0);
      
   } /* End else */
   
   [_pageControl setOrigin:CGPointMake(0, self.height - 16)];
   [_scrollView setOrigin:CGPointMake(0, 0)];
   
   return;
}

- (void)setCurrentPageIndex:(NSInteger)aCurrentPageIndex
{
   _currentPageIndex = aCurrentPageIndex;
   
   [self configContentViews];
   
   return;
}

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
   _totalPagesCount  = [totalPagesCount copy];
   _pagesCount       = totalPagesCount();
   
   if (_currentPageIndex < 0)
   {
      _currentPageIndex = 0;
      
   } /* End if () */
   else if (_currentPageIndex >= _pagesCount)
   {
      _currentPageIndex = _pagesCount - 1;
      
   } /* End if () */
   
   if (_pagesCount > 1)
   {
      if (self.cycleScrollDirection == CycleScrollVertical)
      {
         _scrollView.contentSize   = CGSizeMake(CGRectGetWidth(_scrollView.frame), 3 * CGRectGetHeight(_scrollView.frame));
         _scrollView.contentOffset = CGPointMake(0,0);
         
         [_scrollView setAlwaysBounceHorizontal:NO];
      }
      else
      {
         _scrollView.contentSize   = CGSizeMake(3 * CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
         _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame), 0);
         
         [_scrollView setAlwaysBounceVertical:NO];
      }
      
   } /* End if () */
   else
   {
      if (self.cycleScrollDirection == CycleScrollVertical)
      {
         _scrollView.contentSize   = CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
         _scrollView.contentOffset = CGPointMake(0,0);
         
         [_scrollView setAlwaysBounceHorizontal:NO];
      }
      else
      {
         _scrollView.contentSize   = CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
         _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame), 0);
         
         [_scrollView setAlwaysBounceVertical:NO];
      }
      
   }
   
//    self.currentPageIndex=_pagesCount-1;
   if (_pagesCount > 0)
   {
      [self configContentViews];
      [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
      
      _pageControl.numberOfPages = _pagesCount;
      
   } /* End if () */
   
   [_scrollView setScrollEnabled:!(1 == _pagesCount)];
   
   return;
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration slideAnimationDuration:(NSTimeInterval)slideAnimationDuration cycleScrollDirection:(CycleScrollDirection)direction
{
   self = [self initWithFrame:frame];
   
   self.cycleScrollDirection  =  direction;
   
   if (animationDuration > 0.0)
   {
      self.slideAnimationDuration   = slideAnimationDuration;
      self.animationDuration        = animationDuration;
      
      if (nil != _animationTimer)
      {
         [_animationTimer invalidate];
         __RELEASE(_animationTimer)
         
      } /* End if () */
      
      self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:self.animationDuration
                                                             target:self
                                                           selector:@selector(animationTimerDidFired:)
                                                           userInfo:nil
                                                            repeats:YES];
      [self.animationTimer pauseTimer];
      
   } /* End if () */
   
   self.currentPageIndex=0;
   
   return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
   self = [super initWithCoder:aDecoder];
   
   if (self)
   {
      [self setClipsToBounds:YES];
      
      self.cycleScrollDirection  =  CycleScrollHorizontal;
      
      self.animationDuration        = ANIMATION_DURATION;
      self.slideAnimationDuration   = SLIDE_ANIMATION_DURATION;
      
      if (_animationDuration > 0.0)
      {
         if (nil != _animationTimer)
         {
            [_animationTimer invalidate];
            __RELEASE(_animationTimer)
            
         } /* End if () */
         
         self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:self.animationDuration
                                                                target:self
                                                              selector:@selector(animationTimerDidFired:)
                                                              userInfo:nil
                                                               repeats:YES];
         [self.animationTimer pauseTimer];
         
      } /* End if () */
      
   } /* End if () */
   
   return self;
}

- (void)setFrame:(CGRect)aFrame
{
   [super setFrame:aFrame];
   
   [_scrollView setFrame:aFrame];
   [_scrollView setOrigin:CGPointZero];
   
   CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
   
   [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(_scrollView.frame), 3 * CGRectGetHeight(_scrollView.frame))];
   
   //   for (UIView *contentView in self.contentViews)
   //   {
   //      [contentView setFrame:self.frame];
   //
   //   } /* End for () */
   
   return;
}

//- (void)layoutSubviews
//{
//   [super layoutSubviews];
//   
//   if (self.cycleScrollDirection==CycleScrollVertical)
//   {
//      [_scrollView setContentOffset:CGPointMake(0,0)];
//      
//      _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame), 3 * CGRectGetHeight(_scrollView.frame));
//   }
//   else
//   {
//      [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
//      
//      _scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
//   }
//   
////   [_pageControl setFrameOrigin:(CGPoint){(self.frameWidth - 60) / 2, self.frameHeight - 40}];
//   
//   return;
//}


- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self)
   {
      // Initialization code
      self.autoresizesSubviews = YES;
      _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
      _scrollView.autoresizingMask = 0xFF;
      _scrollView.contentMode = UIViewContentModeCenter;
      if (self.cycleScrollDirection==CycleScrollVertical)
      {
         _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame), 3 * CGRectGetHeight(_scrollView.frame));
         _scrollView.contentOffset = CGPointMake(0,0);
         
      } /* End if () */
      else
      {
         _scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
         _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame), 0);
         
      } /* End else */
      
      _scrollView.delegate               = self;
      _scrollView.pagingEnabled          = YES;
      _scrollView.alwaysBounceVertical   = NO;
      
      [self addSubview:_scrollView];
   }
   return self;
}

#pragma mark -
#pragma mark - 私有函数

- (NSMutableArray<UIView *> *)contentViews {
   
   if (!_contentViews) {
      
      _contentViews = [NSMutableArray<UIView *> array];
      
   } /* End if () */

   return _contentViews;
}

- (void)configContentViews {
   
   [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
   [self setScrollViewContentDataSource];
   
   for (int H = 0; H < self.contentViews.count; ++H) {
      
      UIView *stContentView   = [self.contentViews objectAtIndex:H];
      
//      stContentView.userInteractionEnabled = YES;
//      
//      UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
//      [stContentView addGestureRecognizer:tapGesture];
      
      CGRect stRightRect = stContentView.frame;
      
      if (self.cycleScrollDirection == CycleScrollVertical) {
         
         stRightRect.origin = CGPointMake(0, -CGRectGetHeight(_scrollView.frame) * H + CGRectGetHeight(_scrollView.frame) );
         
      } /* End if () */
      else {
         
         stRightRect.origin = CGPointMake(CGRectGetWidth(_scrollView.frame) * H, 0);
         
      } /* End else */
            
      [stContentView setFrame:(CGRect){stRightRect.origin, _scrollView.frame.size}];
            
      [_scrollView addSubview:stContentView];
      
   } /* End for () */
   
//   NSInteger counter = 0;
//
//   for (UIView *stContentView in self.contentViews) {
//
//      stContentView.userInteractionEnabled = YES;
//      UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
//      [stContentView addGestureRecognizer:tapGesture];
//      CGRect rightRect = stContentView.frame;
//      __LOG_RECT(rightRect);
//
//      if (self.cycleScrollDirection==CycleScrollVertical) {
//
//         rightRect.origin = CGPointMake(0,-CGRectGetHeight(_scrollView.frame) * (counter ++)+CGRectGetHeight(_scrollView.frame) );
//
//      } /* End if () */
//      else {
//
//         rightRect.origin = CGPointMake(CGRectGetWidth(_scrollView.frame) * (counter ++), 0);
//
//      } /* End else */
//
//      //      contentView.frame = rightRect;
//      //      contentView.frame.size  = _scrollView.frame.size;
//
//      [stContentView setFrame:(CGRect){rightRect.origin, _scrollView.frame.size}];
//
//      __LOG_RECT(_scrollView.frame);
//      __LOG_RECT(rightRect);
//
//      [_scrollView addSubview:stContentView];
//
//   } /* End for () */
   
   if (self.cycleScrollDirection==CycleScrollVertical) {
      
      [_scrollView setContentOffset:CGPointMake(0,0)];
      
      _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame), 3 * CGRectGetHeight(_scrollView.frame));
      
   } /* End if () */
   else {
      
      [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
      
      _scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
      
   } /* End else */
   
   return;
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource {
   
   NSInteger   previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
   NSInteger   rearPageIndex     = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
      
   [self.contentViews removeAllObjects];
   
   if (self.fetchContentViewAtIndex && _pagesCount > 0) {
      
      [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
      [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
      [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
      
   } /* End if () */
   
   return;
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex {
   
   if (currentPageIndex == -1) {
      
      return self.pagesCount - 1;
   }
   else if (currentPageIndex >= self.pagesCount) {
      
      return 0;
   }
   else {
      
      return currentPageIndex;
   }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
   [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   if (self.cycleScrollDirection==CycleScrollVertical) {
      
      int contentOffsetY = scrollView.contentOffset.y;
      
      if(contentOffsetY <= -CGRectGetHeight(scrollView.frame)) {
         
         self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
         LogDebug((@"next，当前页:%d",self.currentPageIndex));
         [self configContentViews];
      }
      
      if(contentOffsetY >=CGRectGetHeight(_scrollView.frame)) {
         self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
         LogDebug((@"previous，当前页:%d",self.currentPageIndex));
         [self configContentViews];
      }
      
      [scrollView setContentOffset:CGPointMake(0,0) animated:YES];
   }
   else {
      
      int contentOffsetX = scrollView.contentOffset.x;
      
      if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
         self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
         LogDebug((@"next，当前页:%d",self.currentPageIndex));
         [self configContentViews];
      }
      
      if(contentOffsetX <= 0) {
         self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
         LogDebug((@"previous，当前页:%d",self.currentPageIndex));
         [self configContentViews];
      }
      [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
   }
   
   if (nil != self.operateAtIndex) {
      
      self.operateAtIndex(_currentPageIndex);

   } /* End if () */
   
   return;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   int contentOffsetX = scrollView.contentOffset.x;
   if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
      self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
      _pageControl.currentPage = self.currentPageIndex;
      [self configContentViews];
   }
   if(contentOffsetX <= 0) {
      self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
      _pageControl.currentPage = self.currentPageIndex;
      [self configContentViews];
   }
}

#pragma mark -
#pragma mark - 响应事件

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wimplicit-retain-self"

- (void)animationTimerDidFired:(NSTimer *)timer
{
   CGPoint newOffset;
   if (self.cycleScrollDirection == CycleScrollVertical)
   {
      newOffset = CGPointMake(_scrollView.contentOffset.x, _scrollView.contentOffset.y-CGRectGetHeight(_scrollView.frame));
   }
   else
   {
      newOffset = CGPointMake(_scrollView.contentOffset.x + CGRectGetWidth(_scrollView.frame), _scrollView.contentOffset.y);
   }
   
   [_scrollView setContentOffset:newOffset animated:YES];
   
#if 1
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([UIView animationDefaultDuration] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                  {
      if (self.cycleScrollDirection == CycleScrollVertical)
      {
         int contentOffsetY = _scrollView.contentOffset.y;
         if(contentOffsetY <= -CGRectGetHeight(_scrollView.frame))
         {
            self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
            LogDebug((@"next，当前页:%d",self.currentPageIndex));
            [self configContentViews];
         }
         if(contentOffsetY >=CGRectGetHeight(_scrollView.frame))
         {
            self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
            LogDebug((@"previous，当前页:%d",self.currentPageIndex));
            [self configContentViews];
         }
      }
      else
      {
         int contentOffsetX = _scrollView.contentOffset.x;
         if(contentOffsetX >= (2 * CGRectGetWidth(_scrollView.frame)))
         {
            self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
            LogDebug((@"next，当前页:%d",self.currentPageIndex));
            [self configContentViews];
         }
         if(contentOffsetX <= 0)
         {
            self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
            LogDebug((@"previous，当前页:%d",self.currentPageIndex));
            [self configContentViews];
         }
      }
      
      if (nil != self.operateAtIndex) {
         
         self.operateAtIndex(self.currentPageIndex);

      } /* End if () */
   });
   
#else
   [UIView animateWithDuration:self.slideAnimationDuration animations:^
    {
      //FOCUS_PICTURE_SCROLL_INTERVAL
      [_scrollView setContentOffset:newOffset];
   }
                    completion:^(BOOL complete)
    {
      if (self.cycleScrollDirection == CycleScrollVertical)
      {
         int contentOffsetY = _scrollView.contentOffset.y;
         if(contentOffsetY <= -CGRectGetHeight(_scrollView.frame))
         {
            self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
            LogDebug((@"next，当前页:%d",self.currentPageIndex));
            [self configContentViews];
         }
         if(contentOffsetY >=CGRectGetHeight(_scrollView.frame))
         {
            self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
            LogDebug((@"previous，当前页:%d",self.currentPageIndex));
            [self configContentViews];
         }
      }
      else
      {
         int contentOffsetX = _scrollView.contentOffset.x;
         if(contentOffsetX >= (2 * CGRectGetWidth(_scrollView.frame)))
         {
            self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
            LogDebug((@"next，当前页:%d",self.currentPageIndex));
            [self configContentViews];
         }
         if(contentOffsetX <= 0)
         {
            self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
            LogDebug((@"previous，当前页:%d",self.currentPageIndex));
            [self configContentViews];
         }
      }
      
      if (nil != self.operateAtIndex) {
         
         self.operateAtIndex(self.currentPageIndex);

      } /* End if () */
   }];
#endif
   
   return;
   
}

#pragma clang diagnostic pop

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
   if (self.tapActionBlock)
   {
      self.tapActionBlock(self.currentPageIndex);
      
   } /* End if () */
   
   return;
}

-(void)onClick
{
   return;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)reload {

   _pagesCount       = self.totalPagesCount();
   _currentPageIndex = 0;
   
   [self.contentViews removeAllObjects];
   
   [self configContentViews];

   return;
}

@end
