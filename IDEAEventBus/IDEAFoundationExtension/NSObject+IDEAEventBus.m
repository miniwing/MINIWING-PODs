//
//  NSObject+IDEAEventBus.m
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "IDEAEventBus.h"
#import "NSObject+IDEAEventBus.h"
#import "NSString+IDEAEevnt.h"
#import "NSObject+IDEAEventBus+Inner.h"

@implementation NSObject (IDEAEventBus)

- (IDEAEventSubscriberMaker *)subscribeSharedBus:(Class)eventClass{
    return [IDEAEventBus shared].on(eventClass).freeWith(self);
}

- (IDEAEventSubscriberMaker *)subscribeSharedBusOfName:(NSString *)eventName{
    NSParameterAssert(eventName != nil);
    return [IDEAEventBus shared].on(NSString.class).ofSubType(eventName).freeWith(self);
}

- (IDEAEventSubscriberMaker *)subscribeName:(NSString *)eventName on:(IDEAEventBus *)bus{
    NSParameterAssert(eventName != nil);
    return bus.on(NSString.class).ofSubType(eventName).freeWith(self);
}

- (IDEAEventSubscriberMaker *)subscribe:(Class)eventClass on:(IDEAEventBus *)bus{
    return bus.on(eventClass).freeWith(self);
}

@end

@implementation NSObject(EventBus_JSON)

- (IDEAEventSubscriberMaker *)subscribeSharedBusOfJSON:(NSString *)name{
    return [IDEAEventBus shared].on(IDEAJsonEvent.class).freeWith(self).ofSubType(name);
}

@end

@implementation NSObject(EventBus_Notification)
/**
 监听通知
 */
- (IDEAEventSubscriberMaker<NSNotification *> *)subscribeNotification:(NSString *)name{
    return [IDEAEventBus shared].on(NSNotification.class).ofSubType(name).freeWith(self);
}

- (IDEAEventSubscriberMaker *)subscribeAppDidBecomeActive{
    return [self subscribeNotification:UIApplicationDidBecomeActiveNotification];
}

- (IDEAEventSubscriberMaker *)subscribeAppDidEnterBackground{
    return [self subscribeNotification:UIApplicationDidEnterBackgroundNotification];
}

- (IDEAEventSubscriberMaker *)subscribeAppDidReceiveMemoryWarning{
    return [self subscribeNotification:UIApplicationDidReceiveMemoryWarningNotification];
}

- (IDEAEventSubscriberMaker *)subscribeUserDidTakeScreenshot{
    return [self subscribeNotification:UIApplicationUserDidTakeScreenshotNotification];
}

- (IDEAEventSubscriberMaker *)subscribeAppWillEnterForground{
    return [self subscribeNotification:UIApplicationWillEnterForegroundNotification];
}

- (IDEAEventSubscriberMaker *)subscribeAppWillResignActive{
    return [self subscribeNotification:UIApplicationWillResignActiveNotification];
}

- (IDEAEventSubscriberMaker *)subscribeAppWillTerminate{
    return [self subscribeNotification:UIApplicationWillTerminateNotification];
}

@end

#pragma mark - Deprecated

@implementation NSObject(IDEAEventBus_Deprecated)

- (IDEAEventSubscriberMaker<NSString *> *)subscribeName:(NSString *)eventName{
    return [self subscribeSharedBusOfName:eventName];
}

- (IDEAEventSubscriberMaker *)subscribe:(Class)eventClass{
    return [self subscribeSharedBus:eventClass];
}

- (IDEAEventSubscriberMaker<IDEAJsonEvent *> *)subscribeJSON:(NSString *)name{
    return [self subscribeSharedBusOfJSON:name];
}

@end
