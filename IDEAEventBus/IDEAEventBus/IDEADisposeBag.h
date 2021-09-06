//
//  IDEADisposeBag.h
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "IDEAEventTypes.h"

@interface IDEADisposeBag : NSObject

/**
 增加一个需要释放的token
 */
- (void)addToken:(id<IDEAEventToken>)token;

@end
