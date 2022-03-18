//
//  IDEAEventKitThread.h
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
#import <IDEAEventKit/IDEAEventKitSingleton.h>

#pragma mark -

// main

#undef  dispatch_async_foreground
#define dispatch_async_foreground( block )                     \
        dispatch_async( dispatch_get_main_queue(), block )

#undef  dispatch_after_foreground
#define dispatch_after_foreground( seconds, block )            \
        dispatch_after( dispatch_time( DISPATCH_TIME_NOW, seconds * 1ull * NSEC_PER_SEC ), dispatch_get_main_queue(), block ); \

#undef  dispatch_barrier_async_foreground
#define dispatch_barrier_async_foreground( seconds, block )    \
        dispatch_barrier_async( [IDEAEventKitQueue sharedInstance].concurrent, ^{ \
           dispatch_async_foreground( block );                 \
        });

// concurrent

#undef  dispatch_async_background_concurrent
#define dispatch_async_background_concurrent( block )          \
        dispatch_async( [IDEAEventKitQueue sharedInstance].concurrent, block )

#undef  dispatch_after_background_concurrent
#define dispatch_after_background_concurrent( seconds, block ) \
        dispatch_after( dispatch_time( DISPATCH_TIME_NOW, seconds * 1ull * NSEC_PER_SEC ), [IDEAEventKitQueue sharedInstance].concurrent, block ); \

#undef  dispatch_barrier_async_background_concurrent
#define dispatch_barrier_async_background_concurrent( seconds, block )  \
        dispatch_barrier_async( [IDEAEventKitQueue sharedInstance].concurrent, block )

// serial

#undef  dispatch_async_background_serial
#define dispatch_async_background_serial( block )           \
        dispatch_async( [IDEAEventKitQueue sharedInstance].serial, block )

#undef  dispatch_after_background_serial
#define dispatch_after_background_serial( seconds, block )  \
        dispatch_after( dispatch_time( DISPATCH_TIME_NOW, seconds * 1ull * NSEC_PER_SEC ), [IDEAEventKitQueue sharedInstance].serial, block ); \

#pragma mark -

@interface IDEAEventKitQueue : NSObject

@singleton( IDEAEventKitQueue )

@prop_readonly( dispatch_queue_t,   serial );
@prop_readonly( dispatch_queue_t,   concurrent );

@end

#pragma mark -

@protocol NSLockProtocol <NSObject>
@optional
- (void)lock;
- (void)unlock;
@end
