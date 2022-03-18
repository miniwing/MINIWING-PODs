//
//  IDEAEventKitDebug.m
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKit+Inner/IDEAEventKitDebug.h"
#import "IDEAEventKit+Inner/IDEAEventKitLog.h"
#import "IDEAEventKit+Inner/IDEAEventKitUnitTest.h"

#import "IDEAEventKit/NSObject+EventKit.h"
#import "IDEAEventKit/NSArray+EventKit.h"
#import "IDEAEventKit/NSMutableArray+EventKit.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

#undef  MAX_CALLSTACK_DEPTH
#define MAX_CALLSTACK_DEPTH   (64)

#pragma mark -

@interface IDEAEventKitCallFrame()
+ (NSUInteger)hexValueFromString:(NSString *)text;
+ (id)parseFormat1:(NSString *)line;
+ (id)parseFormat2:(NSString *)line;
@end

#pragma mark -

@implementation IDEAEventKitCallFrame

@def_prop_assign( CallFrameType,   type );
@def_prop_strong( NSString *,      process );
@def_prop_assign( NSUInteger,      entry );
@def_prop_assign( NSUInteger,      offset );
@def_prop_strong( NSString *,      clazz );
@def_prop_strong( NSString *,      method );

- (id)init {
   
   self = [super init];
   if ( self ) {
      
      _type = CallFrameType_Unknown;
      
   } /* End if () */
   
   return self;
}

- (void)dealloc {
   
   self.process= nil;
   self.clazz  = nil;
   self.method = nil;
   
   __SUPER_DEALLOC;
   
   return;
}

#if APPLET_DESCRIPTION
- (NSString *)description {
   
   if ( CallFrameType_ObjectC == _type ) {
      
      return [NSString stringWithFormat:@"[O] %@(0x%08x + %llu) -> [%@ %@]", _process, (unsigned int)_entry, (unsigned long long)_offset, _clazz, _method];
   }
   else if ( CallFrameType_NativeC == _type ) {
      
      return [NSString stringWithFormat:@"[C] %@(0x%08x + %llu) -> %@", _process, (unsigned int)_entry, (unsigned long long)_offset, _method];
   }
   else {
      
      return [NSString stringWithFormat:@"[X] <unknown>(0x%08x + %llu)", (unsigned int)_entry, (unsigned long long)_offset];
   }
}
#endif /* APPLET_DESCRIPTION */

+ (NSUInteger)hexValueFromString:(NSString *)aText {
   
   unsigned int number = 0;
   [[NSScanner scannerWithString:aText] scanHexInt:&number];
   return (NSUInteger)number;
}

+ (id)parseFormat1:(NSString *)aLine {
   
   //   example: peeper  0x00001eca -[PPAppDelegate application:didFinishLaunchingWithOptions:] + 106
   
   static __strong NSRegularExpression * __regex = nil;
   
   if ( nil == __regex ) {
      
      NSError  *error = NULL;
      NSString *expr = @"^[0-9]*\\s*([a-z0-9_]+)\\s+(0x[0-9a-f]+)\\s+-\\[([a-z0-9_]+)\\s+([a-z0-9_:]+)]\\s+\\+\\s+([0-9]+)$";
      
      __regex = [NSRegularExpression regularExpressionWithPattern:expr options:NSRegularExpressionCaseInsensitive error:&error];
      
   } /* End if () */
   
   NSTextCheckingResult *stResult   = [__regex firstMatchInString:aLine options:0 range:NSMakeRange(0, [aLine length])];
   
   if ( stResult && (__regex.numberOfCaptureGroups + 1) == stResult.numberOfRanges ) {
      
      IDEAEventKitCallFrame  *stFrame = [[IDEAEventKitCallFrame alloc] init];
      if ( stFrame ) {
         
         stFrame.type      = CallFrameType_ObjectC;
         stFrame.process   = [aLine substringWithRange:[stResult rangeAtIndex:1]];
         stFrame.entry     = [self hexValueFromString:[aLine substringWithRange:[stResult rangeAtIndex:2]]];
         stFrame.clazz     = [aLine substringWithRange:[stResult rangeAtIndex:3]];
         stFrame.method    = [aLine substringWithRange:[stResult rangeAtIndex:4]];
         stFrame.offset    = (NSUInteger)[[aLine substringWithRange:[stResult rangeAtIndex:5]] intValue];
         
         return stFrame;
         
      } /* End if () */
      
   } /* End if () */
   
   return nil;
}

+ (id)parseFormat2:(NSString *)aLine {
   
   //   example: UIKit 0x0105f42e UIApplicationMain + 1160
   
   static __strong NSRegularExpression * __regex = nil;
   
   if ( nil == __regex ) {
      
      NSError  *error = NULL;
      NSString *expr = @"^[0-9]*\\s*([a-z0-9_]+)\\s+(0x[0-9a-f]+)\\s+([a-z0-9_]+)\\s+\\+\\s+([0-9]+)$";
      
      __regex = [NSRegularExpression regularExpressionWithPattern:expr options:NSRegularExpressionCaseInsensitive error:&error];
      
   } /* End if () */
   
   NSTextCheckingResult *stResult   = [__regex firstMatchInString:aLine options:0 range:NSMakeRange(0, [aLine length])];
   
   if ( stResult && (__regex.numberOfCaptureGroups + 1) == stResult.numberOfRanges ) {
      
      IDEAEventKitCallFrame  *stFrame = [[IDEAEventKitCallFrame alloc] init];
      if ( stFrame ) {
         
         stFrame.type = CallFrameType_NativeC;
         stFrame.process = [aLine substringWithRange:[stResult rangeAtIndex:1]];
         stFrame.entry = [self hexValueFromString:[aLine substringWithRange:[stResult rangeAtIndex:2]]];
         stFrame.clazz = nil;
         stFrame.method = [aLine substringWithRange:[stResult rangeAtIndex:3]];
         stFrame.offset = (NSUInteger)[[aLine substringWithRange:[stResult rangeAtIndex:4]] intValue];
         
         return stFrame;
         
      } /* End if () */
      
   } /* End if () */
   
   return nil;
}

+ (id)unknown {
   
   return [[IDEAEventKitCallFrame alloc] init];
}

+ (id)parse:(NSString *)aLine {
   
   if ( 0 == [aLine length] )
      return nil;
   
   id frame1 = [IDEAEventKitCallFrame parseFormat1:aLine];
   if ( frame1 ) {
      return frame1;
   }
   
   id frame2 = [IDEAEventKitCallFrame parseFormat2:aLine];
   if ( frame2 ) {
      return frame2;
   }
   
   return nil;
}

@end

#pragma mark -

@implementation IDEAEventKitDebugger

@def_singleton( IDEAEventKitDebugger )

@def_prop_readonly( NSArray *,   callstack );

#if __IDEA_EVENT_KIT_DEBUG__
static void __uncaughtExceptionHandler( NSException * exception ) {
   
   fprintf( stderr, "\nUncaught exception: %s\n%s",
           [[exception description] UTF8String],
           [[[exception callStackSymbols] description] UTF8String] );
   
   TRAP();
}
#endif   // #if __IDEA_EVENT_KIT_DEBUG__

#if __IDEA_EVENT_KIT_DEBUG__
static void __uncaughtSignalHandler( int signal ) {
   
   fprintf( stderr, "\nUncaught signal: %d", signal );
   
   TRAP();
}
#endif   // #if __IDEA_EVENT_KIT_DEBUG__

+ (void)classAutoLoad {
   
#if __IDEA_EVENT_KIT_DEBUG__
   NSSetUncaughtExceptionHandler( &__uncaughtExceptionHandler );
   
   signal( SIGABRT,   &__uncaughtSignalHandler );
   signal( SIGILL,      &__uncaughtSignalHandler );
   signal( SIGSEGV,   &__uncaughtSignalHandler );
   signal( SIGFPE,      &__uncaughtSignalHandler );
   signal( SIGBUS,      &__uncaughtSignalHandler );
   signal( SIGPIPE,   &__uncaughtSignalHandler );
#endif
   
   [IDEAEventKitDebugger sharedInstance];
}

- (NSArray *)callstack {
   
   return [[IDEAEventKitDebugger sharedInstance] callstack:MAX_CALLSTACK_DEPTH];
}

- (NSArray *)callstack:(NSInteger)depth; {
   
   NSMutableArray * array = [[NSMutableArray alloc] init];
   
   void * stacks[MAX_CALLSTACK_DEPTH] = { 0 };
   
   int frameCount = backtrace( stacks, MIN((int)depth, MAX_CALLSTACK_DEPTH) );
   if ( frameCount ) {
      
      char ** symbols = backtrace_symbols( stacks, (int)frameCount );
      if ( symbols ) {
         
         for ( int i = 0; i < frameCount; ++i ) {
            
            NSString * line = [NSString stringWithUTF8String:(const char *)symbols[i]];
            if ( 0 == [line length] )
               continue;
            
            IDEAEventKitCallFrame * frame = [IDEAEventKitCallFrame parse:line];
            if ( frame ) {
               
               [array addObject:frame];
            }
         }
         
         free( symbols );
      }
   }
   
   return array;
}

- (void)trap {
   
#if __IDEA_EVENT_KIT_DEBUG__
#if defined(__ppc__)
   asm("trap");
#elif defined(__i386__) ||  defined(__amd64__)
   asm("int3");
#endif
#endif
}

- (void)trace {
   
   [self trace:MAX_CALLSTACK_DEPTH];
}

- (void)trace:(NSInteger)depth {
   
   NSArray * callstack = [self callstack:depth];
   
   if ( callstack && callstack.count ) {
      
      PRINT( [callstack description] );
   }
}

@end

#pragma mark -

@implementation NSObject(Debug)

//- (id)debugQuickLookObject {
//   
//#if __IDEA_EVENT_KIT_DEBUG__
//   
//   IDEAEventKitLogger  *stLogger   = [IDEAEventKitLogger sharedInstance];
//   
//   [stLogger outputCapture];
//   
//   [self dump];
//   
//   [stLogger outputRelease];
//   
//   return stLogger.output;
//   
//#else   // #if __IDEA_EVENT_KIT_DEBUG__
//   
//   return nil;
//   
//#endif   // #if __IDEA_EVENT_KIT_DEBUG__
//}

- (void)dump {
   
   return;
}

@end

// ----------------------------------
// Unit test
// ----------------------------------

#pragma mark -

#if __IDEA_EVENT_KIT_TESTING__

#endif   // #if __IDEA_EVENT_KIT_TESTING__

#import "IDEAEventKit/__pragma_pop.h"
