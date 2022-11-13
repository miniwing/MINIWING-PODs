//
//  IDEAWaterDropView.m
//  Idea
//
//  Created by Harry on 15/10/20.
//  Copyright © 2015年 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612

#import "IDEAWaterDropView.h"

@interface IDEAWaterDropView () <CAAnimationDelegate>

@property (nonatomic, assign)             float                                 animationing;
@property (nonatomic, assign)             float                                 isRefresh;
@property (nonatomic, assign)             float                                 centerX;

@property (nonatomic, strong)             CAShapeLayer                        * shakeLayer;
@property (nonatomic, strong)             NSTimer                             * timer;

@end

@implementation IDEAWaterDropView

- (void)dealloc {
   
   __LOG_FUNCTION;
   
   // Custom dealloc
   
   __RELEASE(_shakeLayer);
   
   __SUPER_DEALLOC;
   
   return;
}

- (BOOL)isRefreshing {
   
   return _isRefresh;
}

- (void)parameterInit {
   
   if (_waterTop == 0) {
      
      _waterTop = 30;
      
   } /* End if () */
   
   if (_maxDropLength == 0) {
      
      _maxDropLength = 80;

   } /* End if () */

   if (_radius == 0) {
      
      _radius = 5;

   } /* End if () */

   _centerX = self.bounds.size.width / 2;
   
   return;
}

- (void)loadWaterView {
   
   [self parameterInit];
   
   _lineLayer = [CAShapeLayer layer];
   [_lineLayer setFillColor:[UIColor colorWithRed:222 / 255.0 green:216 / 255.0 blue:211 / 255.0 alpha:0.5].CGColor];
   [self.layer addSublayer:_lineLayer];
   
   _shapeLayer = [CAShapeLayer layer];
   [_shakeLayer setFillColor:[UIColor colorWithRed:222 / 255.0 green:216 / 255.0 blue:211 / 255.0 alpha:1].CGColor];
   [_shapeLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
   [_shapeLayer setLineWidth:3];
   [self.layer addSublayer:_shapeLayer];
   
   _shakeLayer = [CAShapeLayer layer];
   [_shakeLayer setFillColor:[UIColor colorWithRed:222 / 255.0 green:216 / 255.0 blue:211 / 255.0 alpha:1].CGColor];
   [_shakeLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
   [_shakeLayer setLineWidth:3];
   [_shakeLayer setFrame:CGRectMake(_centerX - _radius, self.bounds.size.height - _waterTop, _radius * 2, _radius * 2)];
   CGPathRef   stPATH  = CGPathCreateWithEllipseInRect(_shakeLayer.bounds, NULL);
   [_shakeLayer setPath:stPATH];
   CGPathRelease(stPATH);
   [_shakeLayer setOpacity:0];
   [self.layer addSublayer:_shakeLayer];
   
   self.currentOffset = 0;
   
   return;
}

- (CGMutablePathRef)createPathWithOffset:(float)currentOffset {
   
   CGMutablePathRef path = CGPathCreateMutable();
   float top = self.bounds.size.height - _waterTop - currentOffset;
   float wdiff = currentOffset* 0.2;
   
   if (0 == currentOffset) {
      
      CGPathAddEllipseInRect(path, NULL, CGRectMake(_centerX - _radius, top, _radius * 2, _radius * 2));
      
   } /* End if () */
   else {
      
      CGPathAddArc(path, NULL, _centerX, top + _radius, _radius, 0, M_PI, YES);
      
      float bottom = top + wdiff + _radius * 2;
      
      if (10 > currentOffset) {
         
         CGPathAddCurveToPoint(path, NULL, _centerX - _radius, bottom,_centerX, bottom, _centerX, bottom);
         CGPathAddCurveToPoint(path, NULL, _centerX, bottom, _centerX + _radius, bottom, _centerX + _radius, top + _radius);

      } /* End if () */
      else {
         
         CGPathAddCurveToPoint(path, NULL, _centerX - _radius, top + _radius, _centerX - _radius,bottom - 2, _centerX, bottom);
         CGPathAddCurveToPoint(path, NULL, _centerX + _radius, bottom - 2, _centerX + _radius,top + _radius , _centerX + _radius, top + _radius);

      } /* End else */

   } /* End else */

   CGPathCloseSubpath(path);
   
   return path;
}

- (void)setCurrentOffset:(float)currentOffset {
   
   if (_isRefresh) {
      
      return;
      
   } /* End if () */
   
   [_refreshView.layer setOpacity:0];
   
   [self privateSetCurrentOffset:currentOffset];
   
   return;
}

- (void)privateSetCurrentOffset:(float)currentOffset {
   
   currentOffset = currentOffset > 0 ? 0 : currentOffset;
   currentOffset = -currentOffset;
   
   _currentOffset =  currentOffset;
   
   if (currentOffset < _maxDropLength) {
      
      float top = self.bounds.size.height - _waterTop - currentOffset;
      
      CGMutablePathRef path = [self createPathWithOffset:currentOffset];
      _shapeLayer.path = path;
      CGPathRelease(path);
      
      
      CGMutablePathRef line = CGPathCreateMutable();
      float w = ((_maxDropLength - currentOffset) / _maxDropLength) + 1;
      float lt = top + _radius * 2;
      float lb = self.bounds.size.height;
      
      if (currentOffset==0) {
         
         CGPathAddRect(line, NULL, CGRectMake(_centerX - w / 2, lt , 2 , lb - lt));
         
      } /* End if () */
      else {
         
         CGPathMoveToPoint(line, NULL, _centerX - w / 2, lt);
         CGPathAddLineToPoint(line, NULL, _centerX + w / 2, lt);
         
         CGPathAddCurveToPoint(line, NULL, _centerX + w / 2, lt + 5, _centerX + w / 2,lt + (lb - lt) / 2 - 5, _centerX + 1 , lb);
         CGPathAddLineToPoint(line,  NULL, _centerX - 1, lb);
         CGPathAddCurveToPoint(line, NULL, _centerX - w / 2, lt + 5, _centerX - w / 2,lt + (lb - lt) / 2 - 5, _centerX - w / 2, lt);
         
      } /* End else */
      
      CGPathCloseSubpath(line);
      _lineLayer.path = line;
      CGPathRelease(line);
      
      self.transform = CGAffineTransformMakeScale(0.85+0.15*(w-1), 1);
      
   } /* End if () */
   else {
      
      if (self.timer == nil) {
         
         _isRefresh = YES;
         self.transform = CGAffineTransformIdentity;
         self.timer = [NSTimer timerWithTimeInterval:0.02 target:self selector:@selector(resetWater) userInfo:nil repeats:YES];
         [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
         [_timer fire];

      } /* End if () */

   } /* End else */
   
   return;
}

-(void)resetWater {
   
   [self privateSetCurrentOffset:-(_currentOffset-(_maxDropLength/8))];
   
   if (_currentOffset==0) {
      
      [self.timer invalidate];
      self.timer = nil;
      
      if (self.handleRefreshEvent!= nil) {
         
         self.handleRefreshEvent();
         
      } /* End if () */
      
      [self shake];

   } /* End if () */

   return;
}

- (void)stopRefresh {
   
   [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startRefreshAnimation) object:nil];
   _isRefresh = NO;
   
   CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
   anim.fromValue = @(1);
   anim.toValue = @(0);
   anim.duration = 0.2;
   anim.delegate = self;
   [_refreshView.layer addAnimation:anim forKey:nil];
   _refreshView.layer.opacity = 0;
   _shakeLayer.opacity = 0;
   
   anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
   anim.fromValue = @(0);
   anim.toValue   = @(1);
   anim.beginTime = 0.2;
   anim.duration  = 0.2;
   anim.delegate  = self;
   
   [_shapeLayer addAnimation:anim forKey:nil];
   _shapeLayer.opacity = 0;
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
   
   if(anim.beginTime > 0) {
      
      _shapeLayer.opacity = 1;
   }
   else {
      
      [_refreshView.layer removeAllAnimations];
   }
   
   return;
}

- (void)startRefreshAnimation {
   
   if(self.refreshView == nil) {
      
      self.refreshView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.dropImage]];
      [self addSubview:_refreshView];
   }
   
   _shakeLayer.opacity = 0;
   _shapeLayer.opacity = 0;
   
   _refreshView.center = CGPointMake(_centerX, _shakeLayer.frame.origin.y + _shakeLayer.frame.size.height/2);
   [_refreshView.layer removeAllAnimations];
   _refreshView.layer.opacity = 1;
   
   CABasicAnimation* alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
   alpha.duration = 0.2;
   alpha.fromValue = @0.5;
   alpha.toValue = @1;
   
   CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
   animation.duration = 1;
   animation.beginTime = 0.1;
   animation.fromValue = @0;
   animation.toValue = @(M_PI*2);
   animation.repeatCount = INT_MAX;
   
   [_refreshView.layer addAnimation:alpha forKey:nil];
   [_refreshView.layer addAnimation:animation forKey:@"rotation"];
   
   return;
}

NS_INLINE CATransform3D CATransform3DMakeRotationScale(CGFloat angle,CGFloat sx, CGFloat sy, CGFloat sz) {
   
   CATransform3D transform = CATransform3DIdentity;
   transform = CATransform3DRotate(transform, angle, 0, 0, 1);
   transform = CATransform3DScale(transform, sx, sy, sz);
   transform = CATransform3DRotate(transform, -angle, 0, 0, 1);
   
   return transform;
}

- (void)shake {
   
   _shakeLayer.opacity = 1;
   _shapeLayer.opacity = 0;
   
   float kDuration = 0.5;
   float angle = M_PI;
   float w = 1.3 , h = 1.3;
   
   CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
   animation.values = [NSArray arrayWithObjects:
                       [NSValue valueWithCATransform3D:_shakeLayer.transform],
                       [NSValue valueWithCATransform3D:CATransform3DMakeRotationScale(angle,w, 2-h, 1)],
                       [NSValue valueWithCATransform3D:CATransform3DMakeRotationScale(angle,1-(w-1)*0.5, 1+(h-1)*0.5, 1)],
                       [NSValue valueWithCATransform3D:CATransform3DMakeRotationScale(angle,1+(w-1)*0.25, 1-(h-1)*0.25, 1)],
                       [NSValue valueWithCATransform3D:CATransform3DMakeRotationScale(angle,1, 1, 1)], nil];
   animation.keyTimes = [NSArray arrayWithObjects:
                         [NSNumber numberWithFloat:0],
                         [NSNumber numberWithFloat:0.3],
                         [NSNumber numberWithFloat:0.6],
                         [NSNumber numberWithFloat:0.9],
                         [NSNumber numberWithFloat:1], nil];
   _shakeLayer.transform = CATransform3DIdentity;
   animation.timingFunctions = [NSArray arrayWithObjects:
                                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
   
   animation.duration = kDuration;
   [_shakeLayer addAnimation:animation forKey:nil];
      
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((kDuration-0.1f) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      
      [self startRefreshAnimation];
   });
}

@end
