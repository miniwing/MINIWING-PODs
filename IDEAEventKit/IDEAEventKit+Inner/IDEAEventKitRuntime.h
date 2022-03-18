//
//  IDEAEventKitRuntime.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKit+Inner/IDEAEventKitConfig.h"

#import "IDEAEventKit/IDEAEventKitProperty.h"

#pragma mark -

#undef  appletClass
#define appletClass( x )         NSClassFromString(@ #x)

#undef  appletInstance
#define appletInstance( x )      [[NSClassFromString(@ #x) alloc] init]

#pragma mark -

@interface NSObject(Runtime)

+ (NSArray *)subClasses;

+ (NSArray *)methods;
+ (NSArray *)methodsUntilClass:(Class)baseClass;
+ (NSArray *)methodsWithPrefix:(NSString *)prefix;
+ (NSArray *)methodsWithPrefix:(NSString *)prefix untilClass:(Class)baseClass;

+ (NSArray *)properties;
+ (NSArray *)propertiesUntilClass:(Class)baseClass;
+ (NSArray *)propertiesWithPrefix:(NSString *)prefix;
+ (NSArray *)propertiesWithPrefix:(NSString *)prefix untilClass:(Class)baseClass;

+ (NSArray *)classesWithProtocolName:(NSString *)protocolName;

+ (void *)replaceSelector:(SEL)sel1 withSelector:(SEL)sel2;

@end
