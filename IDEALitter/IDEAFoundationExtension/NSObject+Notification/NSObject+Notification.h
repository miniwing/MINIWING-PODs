//
//  NSObject+Notification.h
//  Idea
//
//  Created by Harry on 14-7-25.
//  Copyright (c) 2014年 Harry. All rights reserved.
//
//  Mail:iidioter@gmail.com
//  TEL :+(86)18668032582
//

#import <Foundation/Foundation.h>

@interface NSObject (Notification)

+ (NSString *)notificationName:(NSString *)aszName;

- (void)addNotificationName:(NSString *)aszName  selector:(SEL)astSelector object:(id)astObject;
- (void)removeNotification;
- (void)removeNotificationName:(NSString *)aszName object:(id)astObject;

- (void)postNotification:(NSNotification *)astNotification;
- (void)postNotificationName:(NSString *)aszName object:(id)astObject;
- (void)postNotificationName:(NSString *)aszName object:(id)astObject userInfo:(NSDictionary *)astUserInfo;

+ (void)postNotification:(NSNotification *)astNotification;
+ (void)postNotificationName:(NSString *)aszName object:(id)astObject;
+ (void)postNotificationName:(NSString *)aszName object:(id)astObject userInfo:(NSDictionary *)astUserInfo;

@end
