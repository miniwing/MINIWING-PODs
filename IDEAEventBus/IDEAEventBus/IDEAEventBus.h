//
//  IDEAEventBus.h
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDEAEventTypes.h"
#import "IDEAJsonEvent.h"
#import "NSNotification+IDEAEvent.h"
#import "NSObject+IDEAEventBus.h"
#import "NSString+IDEAEevnt.h"

//监听全局总线，监听的生命周期和object一样
#define IDEASub(_object_,_className_) ((IDEAEventSubscriberMaker<_className_ *> *)[_object_ subscribeSharedBus:[_className_ class]])
#define IDEASubName(_object_,_name_) ([_object_ subscribeSharedBusOfName:_name_])
//监听全局总线，异步在主线程监听
#define IDEASubMain(_object_,_className_) ([IDEASub(_object_, _className_) atQueue:dispatch_get_main_queue()])
//全局总线监听NSNotification
#define IDEASubNoti(_object_,_name_) ((IDEAEventSubscriberMaker<NSNotification *> *)[_object_ subscribeNotification:_name_])
//全局总线监听IDEAJsonEvent
#define IDEASubJSON(_object_,_name_) ((IDEAEventSubscriberMaker<IDEAJsonEvent *> *)[_object_ subscribeSharedBusOfJSON:_name_])

@class IDEAEventSubscriberMaker;

/**
 事件总线，负责转发事件，
 支持同步/异步派发，同步/异步监听
 */
@interface IDEAEventBus<EventType> : NSObject

/**
 单例
 */
@property (class, readonly)                  IDEAEventBus                        * shared;

/**
 注册监听事件,点语法
 
 如果需要监听系统的通知，请监听NSNotification这个类，如果要监听通用的事件，请监听IDEAJsonEvent
 */
@property (nonatomic, readonly)              IDEAEventSubscriberMaker<EventType> * (^on)(Class eventClass);

/**
 注册监听事件
 
 如果需要监听系统的通知，请监听NSNotification这个类，如果要监听通用的事件，请监听IDEAJsonEvent
 */
- (IDEAEventSubscriberMaker<EventType> *)on:(Class)aEventClass;

/**
 发布Event,等待event执行结束
 */
- (void)dispatch:(id<IDEAEvent>)aEvent;

/**
 异步到eventbus内部queue上dispath
 */
- (void)dispatchOnBusQueue:(id<IDEAEvent>)aEvent;

/**
 异步到主线程dispatch
 */
- (void)dispatchOnMain:(id<IDEAEvent>)aEvent;

@end


