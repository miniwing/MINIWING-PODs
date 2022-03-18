//
//  IDEAEventKitHandler.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <Foundation/Foundation.h>

#import <IDEAEventKit/IDEAEventKitProperty.h>

#pragma mark -

typedef id      BlockType;
typedef void (^ BlockTypeVoid)   (void);
typedef void (^ BlockTypeVarg)   (id first, ...);

typedef void (^ HandlerBlockType)(id object);

#pragma mark -

@class IDEAEventKitHandler;

@interface NSObject (EventKitBlockHandler)

- (IDEAEventKitHandler *)blockHandlerOrCreate;
- (IDEAEventKitHandler *)blockHandler;

- (void)addBlock:(id)block forName:(NSString *)aName;
- (void)removeBlockForName:(NSString *)aName;
- (void)removeAllBlocks;

@end

#pragma mark -

@interface IDEAEventKitHandler : NSObject

- (BOOL)trigger:(NSString *)aName;
- (BOOL)trigger:(NSString *)aName withObject:(id)aObject;

- (void)addHandler:(id)aHandler forName:(NSString *)aName;
- (void)removeHandlerForName:(NSString *)aName;
- (void)removeAllHandlers;

@end
