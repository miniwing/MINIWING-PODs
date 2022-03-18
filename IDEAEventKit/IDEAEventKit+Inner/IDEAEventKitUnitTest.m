//
//  IDEAEventKitUnitTest.m
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKit/IDEAEventKitUnitTest.h"
#import "IDEAEventKit/IDEAEventKitDebug.h"
#import "IDEAEventKit/IDEAEventKitLog.h"
#import "IDEAEventKit/IDEAEventKitRuntime.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

#undef  MAX_UNITTEST_LOGS
#define MAX_UNITTEST_LOGS   (100)

#pragma mark -

@implementation IDEAEventKitTestFailure

@def_prop_strong( NSString *,   expr );
@def_prop_strong( NSString *,   file );
@def_prop_assign( NSInteger,   line );

+ (IDEAEventKitTestFailure *)expr:(const char *)expr file:(const char *)file line:(int)line {
   
   IDEAEventKitTestFailure * failure = [[IDEAEventKitTestFailure alloc] initWithName:@"UnitTest" reason:nil userInfo:nil];
   failure.expr = @(expr);
   failure.file = [@(file) lastPathComponent];
   failure.line = line;
   return failure;
}

@end

#pragma mark -

@implementation IDEAEventKitTestCase
@end

#pragma mark -

@implementation IDEAEventKitUnitTest {
   
   __strong NSMutableArray * _logs;
}

@def_singleton( IDEAEventKitUnitTest )

@def_prop_assign( NSUInteger,   failedCount );
@def_prop_assign( NSUInteger,   succeedCount );

- (id)init {
   
   self = [super init];
   if ( self ) {
      
      _logs = [[NSMutableArray alloc] init];
   }
   return self;
}

- (void)dealloc {
   
   _logs = nil;
   
   __SUPER_DEALLOC;
   
   return;
}

- (void)run {
   
   fprintf( stderr, "  =============================================================\n" );
   fprintf( stderr, "   Unit testing ...\n" );
   fprintf( stderr, "  -------------------------------------------------------------\n" );
   
   NSArray *   classes = [IDEAEventKitTestCase subClasses];
   LogLevel   filter = [IDEAEventKitLogger sharedInstance].filter;
   
   [IDEAEventKitLogger sharedInstance].filter = LogLevel_Warn;
   //   [IDEAEventKitLogger sharedInstance].filter = LogLevel_All;
   
   CFTimeInterval beginTime = CACurrentMediaTime();
   
   for ( NSString * className in classes ) {
      
      Class classType = NSClassFromString( className );
      
      if ( nil == classType ) {
         continue;
      }
      
      NSString * testCaseName;
      testCaseName = [classType description];
      testCaseName = [testCaseName stringByReplacingOccurrencesOfString:@"__TestCase__" withString:@"  TEST_CASE( "];
      testCaseName = [testCaseName stringByAppendingString:@" )"];
      
      NSString * formattedName = [testCaseName stringByPaddingToLength:48 withString:@" " startingAtIndex:0];
      
      //      [[IDEAEventKitLogger sharedInstance] disable];
      
      fprintf( stderr, "%s", [formattedName UTF8String] );
      
      CFTimeInterval time1 = CACurrentMediaTime();
      
      BOOL testCasePassed = YES;
      
      //   @autoreleasepool
      {
         
         @try {
            
            IDEAEventKitTestCase * testCase = [[classType alloc] init];
            
            NSArray * selectorNames = [classType methodsWithPrefix:@"runTest_" untilClass:[IDEAEventKitTestCase class]];
            
            if ( selectorNames && [selectorNames count] ) {
               
               for ( NSString * selectorName in selectorNames ) {
                  
                  SEL selector = NSSelectorFromString( selectorName );
                  if ( selector && [testCase respondsToSelector:selector] ) {
                     
                     NSMethodSignature * signature = [testCase methodSignatureForSelector:selector];
                     NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
                     
                     [invocation setTarget:testCase];
                     [invocation setSelector:selector];
                     [invocation invoke];
                  }
               }
            }
         }
         @catch ( NSException * e ) {
            
            if ( [e isKindOfClass:[IDEAEventKitTestFailure class]] ) {
               
               IDEAEventKitTestFailure * failure = (IDEAEventKitTestFailure *)e;
               
               [self writeLog:
                @"                        \n"
                "    %@ (#%lu)           \n"
                "                        \n"
                "    {                   \n"
                "        EXPECTED( %@ ); \n"
                "                  ^^^^^^          \n"
                "                  Assertion failed\n"
                "    }                   \n"
                "                        \n", failure.file, failure.line, failure.expr];
            }
            else {
               
               [self writeLog:@"\nUnknown exception '%@'", e.reason];
               [self writeLog:@"%@", e.callStackSymbols];
            }
            
            testCasePassed = NO;
         }
         @finally {
            
         }
      };
      
      CFTimeInterval time2 = CACurrentMediaTime();
      CFTimeInterval time = time2 - time1;
      
      //      [[IDEAEventKitLogger sharedInstance] enable];
      
      if ( testCasePassed ) {
         
         _succeedCount += 1;
         
         fprintf( stderr, "[ OK ]   %.003fs\n", time );
      }
      else {
         
         _failedCount += 1;
         
         fprintf( stderr, "[FAIL]   %.003fs\n", time );
      }
      
      [self flushLog];
   }
   
   CFTimeInterval endTime = CACurrentMediaTime();
   CFTimeInterval totalTime = endTime - beginTime;
   
   float passRate = (_succeedCount * 1.0f) / ((_succeedCount + _failedCount) * 1.0f) * 100.0f;
   
   fprintf( stderr, "  -------------------------------------------------------------\n" );
   fprintf( stderr, "  Total %lu cases                               [%.0f%%]   %.003fs\n", (unsigned long)[classes count], passRate, totalTime );
   fprintf( stderr, "  =============================================================\n" );
   fprintf( stderr, "\n" );
   
   [IDEAEventKitLogger sharedInstance].filter = filter;
   
   return;
}

- (void)writeLog:(NSString *)format, ... {
   
   if ( _logs.count >= MAX_UNITTEST_LOGS ) {
      
      return;
   }
   
   if ( nil == format || NO == [format isKindOfClass:[NSString class]] )
      return;
   
   va_list args;
   va_start( args, format );
   
   @autoreleasepool {
      
      NSMutableString * content = [[NSMutableString alloc] initWithFormat:(NSString *)format arguments:args];
      [_logs addObject:content];
   };
   
   va_end( args );
   
   return;
}

- (void)flushLog {
   
   if ( _logs.count ) {
      
      for ( NSString * log in _logs ) {
         
         fprintf( stderr, "       %s\n", [log UTF8String] );
      }
      
      if ( _logs.count >= MAX_UNITTEST_LOGS ) {
         
         fprintf( stderr, "       ...\n" );
      }
      
      fprintf( stderr, "\n" );
   }
   
   [_logs removeAllObjects];
   
   return;
}

@end

// ----------------------------------
// Unit test
// ----------------------------------

#pragma mark -

#if __IDEA_EVENT_KIT_TESTING__

TEST_CASE( Core, UnitTest )

DESCRIBE( before ) {
   
}

DESCRIBE( after ) {
   
}

TEST_CASE_END

#endif   // #if __IDEA_EVENT_KIT_TESTING__

#import "IDEAEventKit/__pragma_pop.h"
