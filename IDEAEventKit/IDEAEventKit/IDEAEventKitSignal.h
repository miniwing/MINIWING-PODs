//
//  IDEAEventKitSignal.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <IDEAEventKit/NSDictionary+EventKit.h>
#import <IDEAEventKit/NSMutableDictionary+EventKit.h>

#import <IDEAEventKit/IDEAEventKitProperty.h>
#import <IDEAEventKit/IDEAEventKitHandler.h>
#import <IDEAEventKit/IDEAEventKitTrigger.h>

#pragma mark -

#undef  signal
#define signal( name )                       \
        static_property( name##Signal )

#undef  def_signal
#define def_signal( name )                   \
        def_static_property2( name##Signal, @"signal", NSStringFromClass([self class]) )

#undef  def_signal_alias
#define def_signal_alias( name, alias )      \
        alias_static_property( name##Signal, alias )

#undef  signalName
#define signalName( name )                      \
        name##Signal

#undef  makeSignal
#define makeSignal( ... )                    \
        macro_string( macro_join(signal, __VA_ARGS__) )

#undef  handleSignal
#define handleSignal( ... )                  \
        - (void) macro_join( handleSignal, __VA_ARGS__):(IDEAEventKitSignal *)aSignal

#pragma mark -

typedef NSObject * (^ IDEAEventKitSignalBlock )( NSString *aName, HandlerBlockType aObject );

#pragma mark -

typedef enum {
   
   SignalState_Inited = 0,
   SignalState_Sending,
   SignalState_Arrived,
   SignalState_Dead
   
} SignalState;

@class IDEAEventKitSignal;

@interface NSObject(SignalResponder)

@prop_readonly( IDEAEventKitSignalBlock, onSignal );
@prop_readonly( NSMutableArray      *, userResponders );

- (id)signalResponders;          // override point
- (id)signalAlias;               // override point
- (NSString *)signalNamespace;   // override point
- (NSString *)signalTag;         // override point
- (NSString *)signalDescription; // override point

- (BOOL)hasSignalResponder:(id)aObj;
- (void)addSignalResponder:(id)aObj;
- (void)removeSignalResponder:(id)aObj;
- (void)removeAllSignalResponders;

- (void)handleSignal:(IDEAEventKitSignal *)aThat;

@end

#pragma mark -

@interface NSObject(SignalSender)

- (IDEAEventKitSignal *)sendSignal:(NSString *)aName;
- (IDEAEventKitSignal *)sendSignal:(NSString *)aName input:(NSDictionary *)aInput;
- (IDEAEventKitSignal *)sendSignal:(NSString *)aName withObject:(NSObject *)aObject;
- (IDEAEventKitSignal *)sendSignal:(NSString *)aName withObject:(NSObject *)aObject input:(NSDictionary *)aInput;
- (IDEAEventKitSignal *)sendSignal:(NSString *)aName from:(id)aSource;
- (IDEAEventKitSignal *)sendSignal:(NSString *)aName from:(id)aSource input:(NSDictionary *)aInput;
- (IDEAEventKitSignal *)sendSignal:(NSString *)aName from:(id)aSource withObject:(NSObject *)aObject;
- (IDEAEventKitSignal *)sendSignal:(NSString *)aName from:(id)aSource withObject:(NSObject *)aObject input:(NSDictionary *)aInput;

//- (IDEAEventKitSignal *)postSignal:(NSString *)aName;
//- (IDEAEventKitSignal *)postSignal:(NSString *)aName withObject:(NSObject *)aObject;
//- (IDEAEventKitSignal *)postSignal:(NSString *)aName from:(id)aSource;
//- (IDEAEventKitSignal *)postSignal:(NSString *)aName from:(id)aSource withObject:(NSObject *)aObject;

- (void)postSignal:(NSString *)aName onQueue:(dispatch_queue_t)aQueue;
- (void)postSignal:(NSString *)aName input:(NSDictionary *)aInput onQueue:(dispatch_queue_t)aQueue;

- (void)postSignal:(NSString *)aName withObject:(NSObject *)aObject onQueue:(dispatch_queue_t)aQueue;
- (void)postSignal:(NSString *)aName withObject:(NSObject *)aObject input:(NSDictionary *)aInput onQueue:(dispatch_queue_t)aQueue;

- (void)postSignal:(NSString *)aName from:(id)aSource onQueue:(dispatch_queue_t)aQueue;
- (void)postSignal:(NSString *)aName from:(id)aSource input:(NSDictionary *)aInput onQueue:(dispatch_queue_t)aQueue;

- (void)postSignal:(NSString *)aName from:(id)aSource withObject:(NSObject *)aObject onQueue:(dispatch_queue_t)aQueue;
- (void)postSignal:(NSString *)aName from:(id)aSource withObject:(NSObject *)aObject input:(NSDictionary *)aInput onQueue:(dispatch_queue_t)aQueue;

@end

#pragma mark -

@interface IDEAEventKitSignal : NSObject<NSDictionaryProtocol, NSMutableDictionaryProtocol>

@joint( stateChanged );

//@prop_unsafe   ( id                  , foreign );
//@prop_strong   ( NSString           *, prefix );

@prop_unsafe   ( id                  , source );
@prop_unsafe   ( id                  , target );
         
@prop_copy     ( BlockType           , stateChanged );
@prop_assign   ( SignalState         , state );
@prop_assign   ( BOOL                , sending );
@prop_assign   ( BOOL                , arrived );
@prop_assign   ( BOOL                , dead );
      
@prop_assign   ( BOOL                , hit );
@prop_assign   ( NSUInteger          , hitCount );
@prop_readonly ( NSString           *, prettyName );
      
@prop_copy     ( NSString           *, name );
@prop_strong   ( id                  , object );
@prop_strong   ( NSMutableDictionary*, input );
@prop_strong   ( NSMutableDictionary*, output );
   
@prop_assign   ( NSTimeInterval      , initTimeStamp );
@prop_assign   ( NSTimeInterval      , sendTimeStamp );
@prop_assign   ( NSTimeInterval      , arriveTimeStamp );

@prop_readonly ( NSTimeInterval      , timeElapsed );
@prop_readonly ( NSTimeInterval      , timeCostPending );
@prop_readonly ( NSTimeInterval      , timeCostExecution );

@prop_assign   ( NSInteger           , jumpCount );
@prop_strong   ( NSMutableArray     *, jumpPath );

+ (IDEAEventKitSignal *)signal;
+ (IDEAEventKitSignal *)signal:(NSString *)aName;

- (BOOL)is:(NSString *)aName;

- (BOOL)send;
- (BOOL)forward;
- (BOOL)forward:(id)aTarget;

- (void)log:(id)aSource;

- (BOOL)changeState:(SignalState)aNewState;

@end
