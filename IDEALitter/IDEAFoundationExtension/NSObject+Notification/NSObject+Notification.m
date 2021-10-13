//
//  NSObject+Notification.m
//  Idea
//
//  Created by Harry on 14-7-25.
//  Copyright (c) 2014年 Harry. All rights reserved.
//

#import "NSObject+Notification.h"

@implementation NSObject (Notification)

+ (NSString *)notificationName:(NSString *)aszName
{
   return [NSString stringWithFormat:@"%@.%@", [self class], aszName];
}

- (void)addNotificationName:(NSString *)aszName selector:(SEL)astSelector object:(id)astObject
{
   {
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:astSelector
                                                   name:aszName
                                                 object:astObject];
      
      return;
   }
}
- (void)removeNotification
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
   
   return;
}

- (void)removeNotificationName:(NSString *)aszName object:(id)astObject
{
   [[NSNotificationCenter defaultCenter] removeObserver:self
                                                   name:aszName
                                                 object:astObject];
   
   return;
}


- (void)postNotification:(NSNotification *)astNotification
{
   [NSObject postNotification:astNotification];
   
   return;
}

- (void)postNotificationName:(NSString *)aszName object:(id)astObject
{
   [NSObject postNotificationName:aszName object:astObject];
   
   return;
}

- (void)postNotificationName:(NSString *)aszName object:(id)astObject userInfo:(NSDictionary *)astUserInfo
{
   [NSObject postNotificationName:aszName object:astObject userInfo:astUserInfo];
   
   return;
}


+ (void)postNotification:(NSNotification *)astNotification
{
   [[NSNotificationCenter defaultCenter] postNotification:astNotification];
   
   return;
}
+ (void)postNotificationName:(NSString *)aszName object:(id)astObject
{
   [[NSNotificationCenter defaultCenter] postNotificationName:aszName object:astObject];
   
   return;
}

+ (void)postNotificationName:(NSString *)aszName object:(id)astObject userInfo:(NSDictionary *)astUserInfo
{
   [[NSNotificationCenter defaultCenter] postNotificationName:aszName object:astObject userInfo:astUserInfo];
   
   return;
}

@end
