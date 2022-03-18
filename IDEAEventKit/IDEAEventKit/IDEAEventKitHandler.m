//
//  IDEAEventKitHandler.m
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKitHandler.h"
#import "IDEAEventKitTrigger.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

//#pragma mark -
//
//typedef void (^ HandlerBlockType)(id object);
static const char *kBlockHandlerKey = "IDEA.block.Handler";

#pragma mark -

@implementation NSObject (EventKitBlockHandler)

- (IDEAEventKitHandler *)blockHandlerOrCreate {
   
   IDEAEventKitHandler  *stHandler  = [self getAssociatedObjectForKey:kBlockHandlerKey];
   
   if (nil == stHandler) {
      
      stHandler = [[IDEAEventKitHandler alloc] init];
      
      [self retainAssociatedObject:stHandler forKey:kBlockHandlerKey];
      
   } /* End if () */
   
   return stHandler;
}

- (IDEAEventKitHandler *)blockHandler {
   
   return [self getAssociatedObjectForKey:kBlockHandlerKey];
}

- (void)addBlock:(id)aBlock forName:(NSString *)aName {
   
   IDEAEventKitHandler *stHandler  = [self blockHandlerOrCreate];
   
   if (stHandler) {
      
      [stHandler addHandler:aBlock forName:aName];
      
   } /* End if () */
   
   return;
}

- (void)removeBlockForName:(NSString *)aName {
   
   IDEAEventKitHandler * handler = [self blockHandler];
   
   if (handler) {
      
      [handler removeHandlerForName:aName];
   }
}

- (void)removeAllBlocks {
   
   IDEAEventKitHandler *stHandler  = [self blockHandler];
   
   if (stHandler) {
      
      [stHandler removeAllHandlers];
      
   } /* End if () */
   
   [self removeAssociatedObjectForKey:kBlockHandlerKey];
   
   return;
}

@end

#pragma mark -

@implementation IDEAEventKitHandler {
   
   NSMutableDictionary * _blocks;
}

- (id)init {
   
   self = [super init];
   if (self) {
      
      _blocks = [[NSMutableDictionary alloc] init];
   }
   return self;
}

- (void)dealloc {
   
   [_blocks removeAllObjects];
   _blocks = nil;
}

- (BOOL)trigger:(NSString *)name {
   
   return [self trigger:name withObject:nil];
}

- (BOOL)trigger:(NSString *)name withObject:(id)object {
   
   if (nil == name) {
      return NO;
   }
   
   HandlerBlockType   stBlock = (HandlerBlockType)[_blocks objectForKey:name];
   
   if (nil == stBlock) {
      return NO;
   }
   
   stBlock(object);
   
   return YES;
}

- (void)addHandler:(id)aHandler forName:(NSString *)aName {
   
   if (nil == aName) {
      return;
   }
   
   if (nil == aHandler) {
      
      [_blocks removeObjectForKey:aName];
      
   } /* End if () */
   else {
      
      [_blocks setObject:aHandler forKey:aName];
      
   } /* End else */
   
   return;
}

- (void)removeHandlerForName:(NSString *)aName {
   
   if (nil == aName) {
      
      return;
      
   } /* End if () */
   
   [_blocks removeObjectForKey:aName];
   
   return;
}

- (void)removeAllHandlers {
   
   [_blocks removeAllObjects];
   
   return;
}

@end

// ----------------------------------
// Unit test
// ----------------------------------

#pragma mark -

#if __IDEA_EVENT_KIT_TESTING__

#endif // #if __IDEA_EVENT_KIT_TESTING__

#import "IDEAEventKit/__pragma_pop.h"
