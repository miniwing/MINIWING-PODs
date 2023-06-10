//
//  NSTimer+Addition.m
//  Idea
//
//  Created by Harry on 15/11/18.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)

- (void)pauseTimer
{
   if (![self isValid])
   {
      return ;
   }
   
   [self setFireDate:[NSDate distantFuture]];
   
   return;
}


- (void)resumeTimer
{
   if (![self isValid])
   {
      return ;
   }
   
   [self setFireDate:[NSDate date]];
   
   return;
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)adInterval
{
   if (![self isValid])
   {
      return ;
   }
   
   [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:adInterval]];
   
   return;
}

@end
