//
//  IDEAEventKitDebug.h
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

#pragma mark -

#if __IDEA_EVENT_KIT_DEBUG__
#  if defined(__ppc__)
#     undef  TRAP
#     define TRAP()        asm("trap");
#  elif (defined(__i386__) || defined(__amd64__))
#     undef  TRAP
#     define TRAP()        asm("int3");
#else
#  undef  TRAP
#  define TRAP()
#endif

#else

#undef  TRAP
#define TRAP()

#endif

#undef  TRAP_
#define TRAP_( expr )      if ( expr ) { TRAP; };

#pragma mark -

#undef  TRACE
#define TRACE()            [[IDEAEventKitDebugger sharedInstance] trace];

#pragma mark -

typedef enum {
   
   CallFrameType_Unknown = 0,   /// 未知調用棧類型
   CallFrameType_ObjectC = 0,   /// Objective-C
   CallFrameType_NativeC = 0,   /// C
   
} CallFrameType;

#pragma mark -

@interface NSObject(Debug)

- (void)dump;

@end

#pragma mark -

/**
 *  「調用栈」
 */

@interface IDEAEventKitCallFrame : NSObject

@prop_assign( CallFrameType,   type );
@prop_strong( NSString *,      process );
@prop_assign( NSUInteger,      entry );
@prop_assign( NSUInteger,      offset );
@prop_strong( NSString *,      clazz );
@prop_strong( NSString *,      method );

/**
 *  解析原始调用栈数据
 *
 *  @param line 调用栈原始数据
 *
 *  @return 调用栈对象
 */

+ (id)parse:(NSString *)line;

/**
 *  创建调用栈对象
 *
 *  @return 调用栈对象
 */

+ (id)unknown;

@end

#pragma mark -

/**
 * 调试器
 */
@interface IDEAEventKitDebugger : NSObject

@singleton(IDEAEventKitDebugger)

@prop_readonly( NSArray *,   callstack );

/**
 *  @brief 获取调用栈（当前线程）
 *
 *  @return 调用栈对象数组
 */

- (NSArray *)callstack;

/**
 *  @brief 获取调用栈（当前线程）
 *
 *  @param depth 最大线深
 *
 *  @return 调用栈对象数组
 */

- (NSArray *)callstack:(NSInteger)depth;

/**
 *  软件断点
 */

- (void)trap;

/**
 *  打印调用栈
 */

- (void)trace;

/**
 *  打印调用栈
 *
 *  @param depth 最大栈深
 */

- (void)trace:(NSInteger)depth;

@end
