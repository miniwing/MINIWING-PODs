//
//  IDEAEventKitNotificationCenter.m
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKit/IDEAEventKitNotificationCenter.h"
#import "IDEAEventKit/IDEAEventKitNotificationBus.h"

#import "IDEAEventKit/NSMutableArray+EventKit.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark - 

@implementation IDEAEventKitNotificationCenter {
   
   NSMutableDictionary * _map;
}

@def_singleton( IDEAEventKitNotificationCenter )

- (id)init {
   
   self = [super init];
   if ( self ) {
      
      _map = [[NSMutableDictionary alloc] init];
      
   } /* End if () */
   
   return self;
}

- (void)dealloc {
   
   [_map removeAllObjects];
   _map = nil;
   
   __SUPER_DEALLOC;
   
   return;
}

#pragma mark -

- (void)postNotification:(NSString *)aName {
   
   [self postNotification:aName object:nil];
   
   return;
}

- (void)postNotification:(NSString *)aName object:(id)aObject {
   
   LogDebug(( @"Notification '%@'", [aName stringByReplacingOccurrencesOfString:@"notification." withString:@""] ));
   
   [[NSNotificationCenter defaultCenter] postNotificationName:aName object:aObject];
   
   return;
}

- (void)addObserver:(id)aObserver forNotification:(NSString *)aName {
   
   if ( nil == aObserver ) {
      
      return;
      
   } /* End if () */
   
   [[NSNotificationCenter defaultCenter] removeObserver:self name:aName object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:aName object:nil];
   
   NSMutableArray *stObservers   = [_map objectForKey:aName];
   
   if ( nil == stObservers ) {
      
      stObservers = [NSMutableArray nonRetainingArray];
      
      [_map setObject:stObservers forKey:aName];
      
   } /* End if () */
   
   if ( NO == [stObservers containsObject:aObserver] ) {
      
      [stObservers addObject:aObserver];
      
   } /* End if () */
   
   return;
}

- (void)removeObserver:(id)aObserver forNotification:(NSString *)aName {
   
   NSMutableArray *stObservers   = [_map objectForKey:aName];
   
   if ( stObservers ) {
      
      [stObservers removeObject:aObserver];
      
   } /* End if () */
   
   if ( nil == stObservers || 0 == stObservers.count ) {
      
      [_map removeObjectForKey:aName];
      
      [[NSNotificationCenter defaultCenter] removeObserver:self name:aName object:nil];
      
   } /* End if () */
   
   return;
}

- (void)removeObserver:(id)aObserver {
   
   for ( NSMutableArray *stObservers in _map.allValues ) {
      
      [stObservers removeObject:aObserver];
      
   } /* End for () */
   
   [[NSNotificationCenter defaultCenter] removeObserver:aObserver];
   
   return;
}

- (void)handleNotification:(IDEAEventKitNotification *)aNotification {
   
   NSMutableArray *stObservers   = [_map objectForKey:aNotification.name];
   
   if ( stObservers && stObservers.count ) {
      
      for ( NSObject * observer in stObservers ) {
         
         [[IDEAEventKitNotificationBus sharedInstance] routes:aNotification target:observer];
         
      } /* End for () */
      
   } /* End if () */
   
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
