//
//  IDEAEventKitLog.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKitConfig.h"

#import "IDEAEventKitProperty.h"
#import "IDEAEventKitSingleton.h"

#pragma mark -

typedef enum {
    
   LogLevel_Error = 0,
   LogLevel_Warn,
   LogLevel_Info,
   LogLevel_Perf,
   LogLevel_All
    
} LogLevel;

#pragma mark -

#if __IDEA_EVENT_KIT_LOGGING__
#  if __IDEA_EVENT_KIT_DEBUG__
#     define INFO( ... )         [[IDEAEventKitLogger sharedInstance] file:@(__FILE__) line:__LINE__ func:@(__PRETTY_FUNCTION__) level:LogLevel_Info format:__VA_ARGS__];
#     define PERF( ... )         [[IDEAEventKitLogger sharedInstance] file:@(__FILE__) line:__LINE__ func:@(__PRETTY_FUNCTION__) level:LogLevel_Perf format:__VA_ARGS__];
#     define WARN( ... )         [[IDEAEventKitLogger sharedInstance] file:@(__FILE__) line:__LINE__ func:@(__PRETTY_FUNCTION__) level:LogLevel_Warn format:__VA_ARGS__];
#     define ERROR( ... )        [[IDEAEventKitLogger sharedInstance] file:@(__FILE__) line:__LINE__ func:@(__PRETTY_FUNCTION__) level:LogLevel_Error format:__VA_ARGS__];
#     define PRINT( ... )        [[IDEAEventKitLogger sharedInstance] file:@(__FILE__) line:__LINE__ func:@(__PRETTY_FUNCTION__) level:LogLevel_All format:__VA_ARGS__];
#  else
#     define INFO( ... )         [[IDEAEventKitLogger sharedInstance] file:nil line:0 func:nil level:LogLevel_Info format:__VA_ARGS__];
#     define PERF( ... )         [[IDEAEventKitLogger sharedInstance] file:nil line:0 func:nil level:LogLevel_Perf format:__VA_ARGS__];
#     define WARN( ... )         [[IDEAEventKitLogger sharedInstance] file:nil line:0 func:nil level:LogLevel_Warn format:__VA_ARGS__];
#     define ERROR( ... )        [[IDEAEventKitLogger sharedInstance] file:nil line:0 func:nil level:LogLevel_Error format:__VA_ARGS__];
#     define PRINT( ... )        [[IDEAEventKitLogger sharedInstance] file:nil line:0 func:nil level:LogLevel_All format:__VA_ARGS__];
#  endif
#else
#  define INFO( ... )
#  define PERF( ... )
#  define WARN( ... )
#  define ERROR( ... )
#  define PRINT( ... )
#endif

#undef  VAR_DUMP
#define VAR_DUMP( __obj )        PRINT( [__obj description] );

#undef  OBJ_DUMP
#define OBJ_DUMP( __obj )        PRINT( [__obj objectToDictionary] );

#pragma mark -

@interface IDEAEventKitLogger : NSObject

@singleton( IDEAEventKitLogger );

@prop_assign( BOOL             ,    enabled );

@prop_strong( NSMutableString *,    output );
@prop_strong( NSMutableArray  *,    buffer );
@prop_assign( LogLevel         ,    filter );

@prop_copy  ( BlockType        ,    outputHandler );

- (void)toggle;
- (void)enable;
- (void)disable;

- (void)indent;
- (void)indent:(NSUInteger)tabs;
- (void)unindent;
- (void)unindent:(NSUInteger)tabs;

- (void)outputCapture;
- (void)outputRelease;

- (void)file:(NSString *)file line:(NSUInteger)line func:(NSString *)func level:(LogLevel)level format:(NSString *)format, ...;
- (void)file:(NSString *)file line:(NSUInteger)line func:(NSString *)func level:(LogLevel)level format:(NSString *)format args:(va_list)args;

- (void)flush;

@end
