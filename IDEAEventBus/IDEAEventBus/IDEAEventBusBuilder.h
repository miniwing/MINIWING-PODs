//
//  IDEAEventBusBuilder.h
//  IDEAEventBus
//
//  Created by Harry on 2022/3/18.
//
//  Mail: miniwing.hz@gmail.com
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class IDEAEventBus;

@interface IDEAEventBusBuilder : NSObject

@end

@interface IDEAEventBusBuilder ()

- (IDEAEventBus *)build;

@end

NS_ASSUME_NONNULL_END
