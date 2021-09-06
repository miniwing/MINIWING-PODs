//
//  IDEAEventTypes.h
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDEAEvent<NSObject>

@optional


/**
 事件的名称
 
 @note: 有些类在运行时是子类，用这个强制返回父类
 */
+ (Class)eventClass;

/**
 事件的二级类型
 */
- (NSString *)eventSubType;

@end

@protocol IDEAEventToken<NSObject>

/**
 释放当前的监听
 */
- (void)dispose;

@end

/**
 提供一套DSL监听
 */
@interface IDEAEventSubscriberMaker<Value> : NSObject

typedef void (^IDEAEventNextBlock)(Value event) NS_SWIFT_UNAVAILABLE("");

/**
 事件触发的回调
 */
- (id<IDEAEventToken>)next:(IDEAEventNextBlock)hander;

/**
 监听的队列，设置了监听队列后，副作用事件的监听会变成异步
 */
- (IDEAEventSubscriberMaker<Value> *)atQueue:(dispatch_queue_t)queue;

/**
 在对象释放的时候，释放监听
 */
- (IDEAEventSubscriberMaker<Value> *)freeWith:(id)object;

/**
 二级事件，这个操作符可以多次使用
 
 举个例子：[IDEAEventBus shared].on(IDEAJsonEvent.class).ofSubType(@"Login").ofSubType(@"Logout")
 
 表示同时监听IDEAJsonEvent下面的id为Login和Logout事件
 */
- (IDEAEventSubscriberMaker<Value> *)ofSubType:(NSString *)subType;


#pragma mark - 点语法扩展

@property (readonly, nonatomic) IDEAEventSubscriberMaker<Value> *(^atQueue)(dispatch_queue_t);

@property (readonly, nonatomic) IDEAEventSubscriberMaker<Value> *(^ofSubType)(NSString *);

@property (readonly, nonatomic) IDEAEventSubscriberMaker<Value> *(^freeWith)(id);

//@property (readonly, nonatomic) id<IDEAEventToken>(^next)(IDEAEventNextBlock block);

@end

