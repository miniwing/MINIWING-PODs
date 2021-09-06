//
//  IDEAJsonEvent.h
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDEAEventTypes.h"

/**
 通用的JSON Event，用于松耦合事件传递。
 */
@interface IDEAJsonEvent : NSObject<IDEAEvent>

- (instancetype)init NS_UNAVAILABLE;

/**
 事件的唯一id
 */
@property (readonly) NSString * uniqueId;

/**
 事件的数据，只可能为NSDictionary或者NSArray
 */
@property (readonly) id data;

/**
 字典初始化
*/
+ (instancetype)eventWithId:(NSString *)uniqueId jsonObject:(NSDictionary *)data;

/**
 数组初始化
 */
+ (instancetype)eventWithId:(NSString *)uniqueId jsonArray:(NSArray *)data;


@end
