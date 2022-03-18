//
//  IDEAEventKitUnitTest.h
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
#import "IDEAEventKit/IDEAEventKitSingleton.h"

#undef  TEST_CASE
#define TEST_CASE( __module, __name )  \
        @interface __TestCase__##__module##_##__name : IDEAEventKitTestCase \
        @end                           \
        @implementation __TestCase__##__module##_##__name

#undef  TEST_CASE_END
#define TEST_CASE_END \
        @end

#undef  DESCRIBE
#define DESCRIBE( ... ) \
        - (void) macro_concat( runTest_, __LINE__ )

#undef  REPEAT
#define REPEAT( __n ) \
        for ( int __i_##__LINE__ = 0; __i_##__LINE__ < __n; ++__i_##__LINE__ )

#undef  EXPECTED
#define EXPECTED( ... ) \
        if ( !(__VA_ARGS__) ) \
        { \
           @throw [IDEAEventKitTestFailure expr:#__VA_ARGS__ file:__FILE__ line:__LINE__]; \
        }

#undef  TIMES
#define TIMES( __n ) \
        /* [[IDEAEventKitUnitTest sharedInstance] writeLog:@"Loop %d times @ %@(#%d)", __n, [@(__FILE__) lastPathComponent], __LINE__]; */ \
        for ( int __i_##__LINE__ = 0; __i_##__LINE__ < __n; ++__i_##__LINE__ )

#undef  TEST
#define TEST( __name, __block ) \
        [[IDEAEventKitUnitTest sharedInstance] writeLog:@"> %@", @(__name)]; \
        __block

#pragma mark -

@interface IDEAEventKitTestFailure : NSException

@prop_strong( NSString *,   expr );
@prop_strong( NSString *,   file );
@prop_assign( NSInteger,   line );

+ (IDEAEventKitTestFailure *)expr:(const char *)expr file:(const char *)file line:(int)line;

@end

#pragma mark -

@interface IDEAEventKitTestCase : NSObject
@end

#pragma mark -

@interface IDEAEventKitUnitTest : NSObject

@singleton( IDEAEventKitUnitTest )

@prop_assign( NSUInteger,   failedCount );
@prop_assign( NSUInteger,   succeedCount );

- (void)run;

- (void)writeLog:(NSString *)format, ...;
- (void)flushLog;

@end
