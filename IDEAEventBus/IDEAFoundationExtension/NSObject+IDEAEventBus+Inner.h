//
//  NSObject+IDEAEventBus_Private.h
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "IDEADisposeBag.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (IDEAEventBus_Private)

/**
 释放池
 */
@property (strong, nonatomic, readonly) IDEADisposeBag * eb_disposeBag;

@end

NS_ASSUME_NONNULL_END
