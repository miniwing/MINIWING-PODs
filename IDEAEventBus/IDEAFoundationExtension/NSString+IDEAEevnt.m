//
//  NSString+IDEAEevnt.m
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "NSString+IDEAEevnt.h"

@implementation NSString (IDEAEevnt)

- (NSString *)eventSubType{
    return [self copy];
}

+ (Class)eventClass{
    return [NSString class];
}

@end
