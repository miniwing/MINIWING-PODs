//
//  NSObject+Notification.h
//  IDEAWKKit
//
//  Created by Harry on 14-7-25.
//  Copyright (c) 2014年 Harry. All rights reserved.
//
//  Mail:miniwing.hz@gmail.com
//  TEL :+(852)53054612
//

#import <Foundation/Foundation.h>

@interface NSObject (Notification)

+ (NSString *)notificationName:(NSString *)aName;

- (void)addNotificationName:(NSString *)aName  selector:(SEL)aSelector object:(id)aObject;
- (void)removeAllNotifications;
- (void)removeNotificationName:(NSString *)aName object:(id)aObject;

- (void)postNotification:(NSNotification *)aNotification;
- (void)postNotificationName:(NSString *)aName object:(id)aObject;
- (void)postNotificationName:(NSString *)aName object:(id)aObject userInfo:(NSDictionary *)aUserInfo;

+ (void)postNotification:(NSNotification *)aNotification;
+ (void)postNotificationName:(NSString *)aName object:(id)aObject;
+ (void)postNotificationName:(NSString *)aName object:(id)aObject userInfo:(NSDictionary *)aUserInfo;

@end
