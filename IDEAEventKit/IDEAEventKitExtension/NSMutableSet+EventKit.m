//
//  NSMutableSet+Extension.m
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKit/NSMutableSet+EventKit.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

static const void * __RetainFunc ( CFAllocatorRef allocator, const void * value ) { return value; }
static void         __ReleaseFunc( CFAllocatorRef allocator, const void * value ) { }

#pragma mark -

@implementation NSMutableSet (EventKit)

+ (NSMutableSet *)nonRetainingSet {
   
   CFSetCallBacks  stCallbacks   = kCFTypeSetCallBacks;
   stCallbacks.retain   = __RetainFunc;
   stCallbacks.release  = __ReleaseFunc;
   
   return (__bridge_transfer NSMutableSet *)CFSetCreateMutable( nil, 0, &stCallbacks );
}

@end

// ----------------------------------
// Unit test
// ----------------------------------

#pragma mark -

#if __IDEA_EVENT_KIT_TESTING__

#endif // #if __IDEA_EVENT_KIT_TESTING__

#import "IDEAEventKit/__pragma_pop.h"
