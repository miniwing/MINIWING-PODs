//
//  IDEAEventKitTrigger.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <Foundation/Foundation.h>

#import "IDEAEventKit/IDEAEventKitProperty.h"
#import "IDEAEventKit/IDEAEventKitSingleton.h"

#pragma mark -

typedef void ( *ImpFuncType )( id a, SEL b, void * c );

#pragma mark -

#undef  joint
#define joint( name )                        property (nonatomic, readonly) NSString * __name

#undef  def_joint
#define def_joint( name   )                  dynamic __name

#define hookBefore( name, ... )              hookBefore_( macro_concat(before_, name), __VA_ARGS__)
#define hookBefore_( name, ... )             - (void) macro_join(name, __VA_ARGS__)

#define hookAfter( name, ... )               hookAfter_( macro_concat(after_, name), __VA_ARGS__)
#define hookAfter_( name, ... )              - (void) macro_join(name, __VA_ARGS__)

#pragma mark -

#define trigger( target, prefix, name )      [target performCallChainWithPrefix:macro_string(macro_concat(prefix, name)) reversed:NO]
#define triggerR( target, prefix, name )     [target performCallChainWithPrefix:macro_string(macro_concat(prefix, name)) reversed:YES]

#define triggerBefore( target, name )        [target performCallChainWithPrefix:macro_string(macro_concat(before_, name)) reversed:NO]
#define triggerBeforeR( target, name )       [target performCallChainWithPrefix:macro_string(macro_concat(before_, name)) reversed:YES]

#define triggerAfter( target, name )         [target performCallChainWithPrefix:macro_string(macro_concat(after_, name)) reversed:NO]
#define triggerAfterR( target, name )        [target performCallChainWithPrefix:macro_string(macro_concat(after_, name)) reversed:YES]

#define callChain( target, name )            [target performCallChainWithName:@(#name) reversed:NO]
#define callChainR( target, name )           [target performCallChainWithName:@(#name) reversed:YES]

#pragma mark -

@interface NSObject(Loader)

- (void)load;
- (void)unload;

- (void)performLoad;
- (void)performUnload;

@end

#pragma mark -

@interface NSObject(Trigger)

+ (void)performSelectorWithPrefix:(NSString *)aPrefix;
- (void)performSelectorWithPrefix:(NSString *)aPrefix;

- (id)performCallChainWithSelector:(SEL)aSEL;
- (id)performCallChainWithSelector:(SEL)aSEL reversed:(BOOL)aFlag;

- (id)performCallChainWithPrefix:(NSString *)aPrefix;
- (id)performCallChainWithPrefix:(NSString *)aPrefix reversed:(BOOL)aFlag;

- (id)performCallChainWithName:(NSString *)aName;
- (id)performCallChainWithName:(NSString *)aName reversed:(BOOL)aFlag;

@end
