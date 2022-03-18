//
//  IDEAEventKitNotification.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <Foundation/Foundation.h>

#import <IDEAEventKit/IDEAEventKitProperty.h>

#pragma mark -

#undef  notification
#define notification(name)                          \
        static_property(name##Notification)

#undef  def_notification
#define def_notification(name)                      \
        def_static_property2(name##Notification, @"notification", NSStringFromClass([self class]))

#undef  def_notification_alias
#define def_notification_alias(name, alias)         \
        alias_static_property(name##Notification, alias)

#undef  notificationName
#define notificationName(name)                      \
        name##Notification

#undef  makeNotification
#define makeNotification(...)                       \
        macro_string(macro_join(notification, __VA_ARGS__))

#undef  handleNotification
#define handleNotification(...)                     \
        - (void) macro_join(handleNotification, __VA_ARGS__):(NSNotification *)aNotification

#pragma mark -

typedef NSObject * (^ IDEAEventKitNotificationBlock)(NSString * name, id object);
//typedef NSObject * (^ IDEAEventKitNotificationBlock)(NSString * name, HandlerBlockType object);

#pragma mark -

@protocol ManagedNotification <NSObject>
@end

typedef NSNotification IDEAEventKitNotification;

#pragma mark -

@interface NSNotification (EventKit)

@prop_readonly(NSString *,   prettyName);

- (BOOL)is:(NSString *)aName;

@end

#pragma mark -

@interface NSObject(NotificationResponder)

@prop_readonly(IDEAEventKitNotificationBlock, onNotification);

- (void)observeNotification:(NSString *)aName;
- (void)unobserveNotification:(NSString *)aName;
- (void)unobserveAllNotifications;

- (void)handleNotification:(IDEAEventKitNotification *)aNotification;
- (void)setOnNotification:(IDEAEventKitNotificationBlock)aAppletNotificationBlock;

@end

#pragma mark -

@interface NSObject(NotificationSender)

/**
 Synchronous
 */
+ (void)notify:(NSString *)aName;
- (void)notify:(NSString *)aName;

+ (void)notify:(NSString *)aName withObject:(NSObject *)aObject;
- (void)notify:(NSString *)aName withObject:(NSObject *)aObject;

/**
 Asynchronous
 */
+ (void)postNotify:(NSString *)aName;
- (void)postNotify:(NSString *)aName;

+ (void)postNotify:(NSString *)aName onQueue:(dispatch_queue_t)aQueue;
- (void)postNotify:(NSString *)aName onQueue:(dispatch_queue_t)aQueue;

+ (void)postNotify:(NSString *)aName withObject:(NSObject *)aObject onQueue:(dispatch_queue_t)aQueue;
- (void)postNotify:(NSString *)aName withObject:(NSObject *)aObject onQueue:(dispatch_queue_t)aQueue;

@end
