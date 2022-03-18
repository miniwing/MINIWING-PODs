//
//  IDEAEventKitNotification.m
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKit/IDEAEventKitNotification.h"
#import "IDEAEventKit/IDEAEventKitNotificationCenter.h"
#import "IDEAEventKit/IDEAEventKitThread.h"

#import "IDEAEventKit+Inner/IDEAEventKitRuntime.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation NSNotification (EventKit)

@def_prop_dynamic( NSString   *, prettyName );

#pragma mark -

- (NSString *)prettyName {
   
   return [self.name stringByReplacingOccurrencesOfString:@"notification." withString:@""];
}

- (BOOL)is:(NSString *)value {
   
   return [self.name isEqualToString:value];
}

@end

#pragma mark -

@implementation NSObject(NotificationResponder)

@def_prop_dynamic( IDEAEventKitEventBlock,  onNotification );

#pragma mark -

- (IDEAEventKitNotificationBlock)onNotification {
   
   @weakify(self);
   
   IDEAEventKitNotificationBlock stBlock = ^ NSObject * (NSString * aName, id aNotificationBlock) {
      
      @strongify(self);
      
      if (aNotificationBlock) {
         
         [[IDEAEventKitNotificationCenter sharedInstance] addObserver:self forNotification:aName];
      }
      else {
         
         [[IDEAEventKitNotificationCenter sharedInstance] removeObserver:self forNotification:aName];
      }
      
      aName = [aName stringByReplacingOccurrencesOfString:@"notification." withString:@"handleNotification____"];
      aName = [aName stringByReplacingOccurrencesOfString:@"notification____" withString:@"handleNotification____"];
      aName = [aName stringByReplacingOccurrencesOfString:@"-" withString:@"____"];
      aName = [aName stringByReplacingOccurrencesOfString:@"." withString:@"____"];
      aName = [aName stringByReplacingOccurrencesOfString:@"/" withString:@"____"];
      aName = [aName stringByAppendingString:@":"];
      
      if (aNotificationBlock) {
         
         [self addBlock:aNotificationBlock forName:aName];
         
      } /* End if () */
      else {
         
         [self removeBlockForName:aName];
         
      } /* End else */
      
      return self;
   };
   
   return [stBlock copy];
}

- (void)observeNotification:(NSString *)aName {
   
   [[IDEAEventKitNotificationCenter sharedInstance] addObserver:self forNotification:aName];
   
   return;
}

- (void)unobserveNotification:(NSString *)aName {
   
   [[IDEAEventKitNotificationCenter sharedInstance] removeObserver:self forNotification:aName];

   return;
}

- (void)observeAllNotifications {
   
   NSArray  *stMethods  = [[self class] methodsWithPrefix:@"handleNotification____" untilClass:[NSObject class]];
   
   if (stMethods && stMethods.count) {
      
      NSMutableArray *stNames = [NSMutableArray array];
      
      for (NSString *szMethod in stMethods) {
         
         NSString *szNotificationName  = szMethod;
         
         szNotificationName = [szNotificationName stringByReplacingOccurrencesOfString:@"handleNotification" withString:@"notification"];
         szNotificationName = [szNotificationName stringByReplacingOccurrencesOfString:@"____" withString:@"."];
         
         if ([szNotificationName hasSuffix:@":"]) {
            
            szNotificationName = [szNotificationName substringToIndex:(szNotificationName.length - 1)];
            
         } /* End if () */
         
         [[IDEAEventKitNotificationCenter sharedInstance] addObserver:self forNotification:szNotificationName];
         
         [stNames addObject:szNotificationName];
         
      } /* End for () */
      
      [self retainAssociatedObject:stNames forKey:"notificationNames"];
      
   } /* End if () */
   
   return;
}

- (void)unobserveAllNotifications {
   
   NSArray  *stNames = [self getAssociatedObjectForKey:"notificationNames"];
   
   if (stNames && stNames.count) {
      
      for (NSString *szName in stNames) {
         
         [[IDEAEventKitNotificationCenter sharedInstance] removeObserver:self forNotification:szName];
         
      } /* End for () */
      
      [self removeAssociatedObjectForKey:"notificationNames"];
      
   } /* End if () */
   
   [[IDEAEventKitNotificationCenter sharedInstance] removeObserver:self];
   
   return;
}

- (void)handleNotification:(IDEAEventKitNotification *)aNotification {
   
   UNUSED(aNotification);
   
   return;
}

@end

#pragma mark -

@implementation NSObject(NotificationSender)

+ (void)notify:(NSString *)aName {
   
   [self notify:aName withObject:nil];
   
   return;
}

- (void)notify:(NSString *)aName {
   
   [self notify:aName withObject:nil];

   return;
}

+ (void)notify:(NSString *)aName withObject:(NSObject *)aObject {
   
   @autoreleasepool {

      [[IDEAEventKitNotificationCenter sharedInstance] postNotification:aName object:aObject];

   }; /* @autoreleasepool */
   
   return;
}

- (void)notify:(NSString *)aName withObject:(NSObject *)aObject {
   
   [NSObject notify:aName withObject:aObject];
   
   return;
}

+ (void)postNotify:(NSString *)aName {
   
   [self postNotify:aName withObject:nil onQueue:NULL];
      
   return;
}

- (void)postNotify:(NSString *)aName {

   [self postNotify:aName withObject:nil onQueue:NULL];

   return;
}

+ (void)postNotify:(NSString *)aName onQueue:(dispatch_queue_t)aQueue {
   
   [self postNotify:aName withObject:nil onQueue:aQueue];

   return;
}
- (void)postNotify:(NSString *)aName onQueue:(dispatch_queue_t)aQueue {
   
   [self postNotify:aName withObject:nil onQueue:aQueue];

   return;
}

+ (void)postNotify:(NSString *)aName withObject:(NSObject *)aObject onQueue:(dispatch_queue_t)aQueue
{
   if (NULL == aQueue) {
      
      aQueue   = [IDEAEventKitQueue sharedInstance].concurrent;
      
   } /* End if () */
   
   dispatch_async(aQueue, ^{
      
      @autoreleasepool {

         [[IDEAEventKitNotificationCenter sharedInstance] postNotification:aName object:aObject];

      }; /* @autoreleasepool */

   });

   return;
}

- (void)postNotify:(NSString *)aName withObject:(NSObject *)aObject onQueue:(dispatch_queue_t)aQueue {
   
   [NSObject postNotify:aName withObject:aObject onQueue:aQueue];

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
