//
//  IDEAEventBus.h
//  IDEAEventBus
//
//  Created by Harry on 2022/3/18.
//
//  Mail: miniwing.hz@gmail.com
//

#import <Foundation/Foundation.h>

#import <IDEAEventBus/IDEAEventBusBuilder.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEAEventBus : NSObject

@end

@interface IDEAEventBus ()

+ (instancetype)getDefault;
+ (instancetype)eventBusWithBuilder:(IDEAEventBusBuilder *)aBuilder;

@end

@interface IDEAEventBus ()

/**
 *  Unavailable initializer
 */
+ (instancetype)new NS_UNAVAILABLE;

/**
 *  Unavailable initializer
 */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
