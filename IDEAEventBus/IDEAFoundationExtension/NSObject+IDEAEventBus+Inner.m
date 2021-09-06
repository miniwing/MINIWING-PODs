//
//  NSObject+IDEAEventBus_Private.m
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "NSObject+IDEAEventBus+Inner.h"

static const char event_bus_disposeContext;

@implementation NSObject (IDEAEventBus_Private)

- (IDEADisposeBag *)eb_disposeBag{
   IDEADisposeBag * bag = objc_getAssociatedObject(self, &event_bus_disposeContext);
    if (!bag) {
        bag = [[IDEADisposeBag alloc] init];
        objc_setAssociatedObject(self, &event_bus_disposeContext, bag, OBJC_ASSOCIATION_RETAIN);
    }
    return bag;
}

@end
