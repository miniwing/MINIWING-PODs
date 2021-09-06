//
//  NSNotification+IDEAEvent.m
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "NSNotification+IDEAEvent.h"

@implementation NSNotification (IDEAEvent)

+ (Class)eventClass{
    return [NSNotification class];
}

- (NSString *)eventSubType{
    return self.name;
}


@end
