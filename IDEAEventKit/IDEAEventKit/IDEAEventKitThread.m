//
//  IDEAEventKitThread.m
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKit/IDEAEventKitThread.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------
#pragma mark -

@implementation IDEAEventKitQueue

@def_singleton( IDEAEventKitQueue )

@def_prop_strong( dispatch_queue_t,   serial );
@def_prop_strong( dispatch_queue_t,   concurrent );

- (id)init {
   
   self = [super init];
   
   if (self) {
      
      _serial      = dispatch_queue_create( "com.idea.applet.serial", DISPATCH_QUEUE_SERIAL );
      _concurrent  = dispatch_queue_create( "com.idea.applet.concurrent", DISPATCH_QUEUE_CONCURRENT );
      
   } /* End if () */
   
   return self;
}

- (void)dealloc {
   
   _serial     = nil;
   _concurrent = nil;
   
   __SUPER_DEALLOC;
   
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
