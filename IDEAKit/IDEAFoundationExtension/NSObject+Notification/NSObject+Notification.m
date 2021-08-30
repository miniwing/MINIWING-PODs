//
//  NSObject+Notification.m
//  IDEAKit
//
//  Created by Harry on 14-7-25.
//  Copyright (c) 2014年 Harry. All rights reserved.
//

#import "IDEAKit/NSObject+Notification.h"

@implementation NSObject (Notification)

+ (NSString *)notificationName:(NSString *)aName {
   
   return [NSString stringWithFormat:@"%@.%@", [self class], aName];
}

- (void)addNotificationName:(NSString *)aName selector:(SEL)aSelector object:(id)aObject {
   
   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:aSelector
                                                name:aName
                                              object:aObject];
   
   return;
}

- (void)removeAllNotification {
   
   [[NSNotificationCenter defaultCenter] removeObserver:self];
   
   return;
}

- (void)removeNotificationName:(NSString *)aName object:(id)aObject {
   
   [[NSNotificationCenter defaultCenter] removeObserver:self
                                                   name:aName
                                                 object:aObject];
   
   return;
}

- (void)postNotification:(NSNotification *)aNotification {
   
   [NSObject postNotification:aNotification];
   
   return;
}

- (void)postNotificationName:(NSString *)aName object:(id)aObject {
   
   [NSObject postNotificationName:aName object:aObject];
   
   return;
}

- (void)postNotificationName:(NSString *)aName object:(id)aObject userInfo:(NSDictionary *)aUserInfo {
   
   [NSObject postNotificationName:aName object:aObject userInfo:aUserInfo];
   
   return;
}


+ (void)postNotification:(NSNotification *)aNotification {
   
   [[NSNotificationCenter defaultCenter] postNotification:aNotification];
   
   return;
}

+ (void)postNotificationName:(NSString *)aName object:(id)aObject {
   
   [[NSNotificationCenter defaultCenter] postNotificationName:aName object:aObject];
   
   return;
}

+ (void)postNotificationName:(NSString *)aName object:(id)aObject userInfo:(NSDictionary *)aUserInfo {
   
   [[NSNotificationCenter defaultCenter] postNotificationName:aName object:aObject userInfo:aUserInfo];
   
   return;
}

@end
