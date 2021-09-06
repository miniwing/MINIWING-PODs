//
//  IDEAJsonEvent.m
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "IDEAJsonEvent.h"

@interface IDEAJsonEvent()

@property (nonatomic, copy) NSString * uniqueId;

@property (nonatomic, strong) id data;


@end

@implementation IDEAJsonEvent

- (instancetype)initWithId:(NSString *)unqiueId data:(id)data{
    if (self = [super init]) {
        _data = data;
        _uniqueId = unqiueId;
    }
    return self;
}

+ (instancetype)eventWithId:(NSString *)uniqueId jsonArray:(NSArray *)data{
    NSAssert([data isKindOfClass:[NSArray class]], @"Data must be NSArray");
    return [[self alloc] initWithId:uniqueId data:data];
}

+ (instancetype)eventWithId:(NSString *)uniqueId jsonObject:(NSDictionary *)data{
    NSAssert([data isKindOfClass:[NSDictionary class]], @"Data must be NSDictionary");
    return [[self alloc] initWithId:uniqueId data:data];
}

- (NSString *)eventSubType{
    return self.uniqueId;
}

@end
