//
//  NSObject+IDEAEventBus.h
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "IDEAEventTypes.h"

@class IDEAEventBus;
@class IDEAJsonEvent;
@interface NSObject (IDEAEventBus)

/**
 在EventBus单例shared上监听指定类型的事件，并且跟随self一起取消监听
 */
- (IDEAEventSubscriberMaker *)subscribeSharedBus:(Class)eventClass;

/**
 在EventBus单例子监听指定字符串事件
 */
- (IDEAEventSubscriberMaker<NSString *> *)subscribeSharedBusOfName:(NSString *)eventName;

/**
 在bus上监听指定类型的事件，并且跟随self一起取消监听
 */
- (IDEAEventSubscriberMaker *)subscribe:(Class)eventClass on:(IDEAEventBus *)bus;

/**
 在bus上监听指定字符串时间
 */
- (IDEAEventSubscriberMaker<NSString *> *)subscribeName:(NSString *)eventName on:(IDEAEventBus *)bus;

@end

@interface NSObject(EventBus_JSON)

/**
 监听一个JSONEvent，并且self释放的时候自动取消订阅
 */
- (IDEAEventSubscriberMaker<IDEAJsonEvent *> *)subscribeSharedBusOfJSON:(NSString *)name;

@end

@interface NSObject(EventBus_Notification)

/**
 监听通知
 */
- (IDEAEventSubscriberMaker<NSNotification *> *)subscribeNotification:(NSString *)name;

- (IDEAEventSubscriberMaker<NSNotification *> *)subscribeAppDidBecomeActive;

- (IDEAEventSubscriberMaker<NSNotification *> *)subscribeAppDidEnterBackground;

- (IDEAEventSubscriberMaker<NSNotification *> *)subscribeAppDidReceiveMemoryWarning;

- (IDEAEventSubscriberMaker<NSNotification *> *)subscribeUserDidTakeScreenshot;

- (IDEAEventSubscriberMaker<NSNotification *> *)subscribeAppWillEnterForground;

- (IDEAEventSubscriberMaker<NSNotification *> *)subscribeAppWillResignActive;

- (IDEAEventSubscriberMaker<NSNotification *> *)subscribeAppWillTerminate;

@end

@interface NSObject(IDEAEventBus_Deprecated)

/**
 在EventBus单例子监听指定字符串事件
 */
- (IDEAEventSubscriberMaker<NSString *> *)subscribeName:(NSString *)eventName DEPRECATED_MSG_ATTRIBUTE("Use subscribeSharedBusOfName: method instead.");

/**
 在EventBus单例shared上监听指定类型的事件，并且跟随self一起取消监听
 */
- (IDEAEventSubscriberMaker *)subscribe:(Class)eventClass DEPRECATED_MSG_ATTRIBUTE("Use subscribeSharedBus: method instead.");

- (IDEAEventSubscriberMaker<IDEAJsonEvent *> *)subscribeJSON:(NSString *)name DEPRECATED_MSG_ATTRIBUTE("Use subscribeSharedBusOfJSON: method instead.");
@end
