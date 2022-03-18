//
//  IDEAEventKitAssert.m
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKit+Inner/IDEAEventKitAssert.h"
#import "IDEAEventKit+Inner/IDEAEventKitLog.h"

#import "IDEAEventKit/NSObject+EventKit.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation IDEAEventKitAsserter

@def_singleton( IDEAEventKitAsserter );

@def_prop_assign( BOOL,   enabled );

+ (void)classAutoLoad {
   
   [IDEAEventKitAsserter sharedInstance];
   
   return;
}

- (id)init
{
   self = [super init];
   
   if ( self ) {
      
      _enabled = YES;
      
   } /* End if () */
   
   return self;
}

- (void)toggle {
   
   _enabled = _enabled ? NO : YES;
   
   return;
}

- (void)enable {
   
   _enabled = YES;
   
   return;
}

- (void)disable {
   
   _enabled = NO;
   
   return;
}

- (void)file:(const char *)file line:(NSUInteger)line func:(const char *)func flag:(BOOL)flag expr:(const char *)expr {
   
   if ( NO == _enabled ) {
      
      return;
      
   } /* End if () */
   
   if ( NO == flag ) {
      
#if __IDEA_EVENT_KIT_DEBUG__
      
      fprintf( stderr,
              "                        \n"
              "    %s @ %s (#%lu)      \n"
              "    {                   \n"
              "        ASSERT( %s );   \n"
              "        ^^^^^^          \n"
              "        Assertion failed\n"
              "    }                   \n"
              "                        \n", func, [[@(file) lastPathComponent] UTF8String], (unsigned long)line, expr );
      
#endif
      
      abort();
   }
}

@end

#pragma mark -

#if __cplusplus
extern "C"
#endif
void IDEAEventKitAssert( const char * file, NSUInteger line, const char * func, BOOL flag, const char * expr ) {
   
   [[IDEAEventKitAsserter sharedInstance] file:file line:line func:func flag:flag expr:expr];
   
   return;
}

// ----------------------------------
// Unit test
// ----------------------------------

#pragma mark -

#if __IDEA_EVENT_KIT_TESTING__

#endif // #if __IDEA_EVENT_KIT_TESTING__

#import "IDEAEventKit/__pragma_pop.h"
