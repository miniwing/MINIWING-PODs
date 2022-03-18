//
//  IDEAEventKitAssert.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKit/IDEAEventKitProperty.h"
#import "IDEAEventKit/IDEAEventKitSingleton.h"

#pragma mark -

#if __IDEA_EVENT_KIT_DEBUG__
#  define ASSERT( __expr ) [[IDEAEventKitAsserter sharedInstance] file:__FILE__ line:__LINE__ func:__PRETTY_FUNCTION__ flag:((__expr) ? YES : NO) expr:#__expr];
#else
#  define ASSERT( __expr )
#endif

#pragma mark -

/**
 *  「武士」·「斷言」
 */

@interface IDEAEventKitAsserter : NSObject

@singleton( IDEAEventKitAsserter );

@prop_assign( BOOL,   enabled );

/**
 *  若已開啟則關閉，若已關閉則開啟
 */

- (void)toggle;

/**
 *  開啟，使之有效
 */

- (void)enable;

/**
 *  關閉，使之失效
 */

- (void)disable;

/**
 *  觸發斷言
 *
 *  @param file 文件名稱
 *  @param line 文件行號
 *  @param func 方法名稱
 *  @param flag 斷言結果
 *  @param expr 斷言表達式
 */

- (void)file:(const char *)file line:(NSUInteger)line func:(const char *)func flag:(BOOL)flag expr:(const char *)expr;

@end

#pragma mark -

#if __cplusplus
extern "C" {
#endif
   
/**
 *  觸發斷言 · C語言方式
 *
 *  @param file 文件名稱
 *  @param line 文件行號
 *  @param func 方法名稱
 *  @param flag 斷言結果
 *  @param expr 斷言表達式
 */

void IDEAEventKitAssert( const char * file, NSUInteger line, const char * func, BOOL flag, const char * expr );

#if __cplusplus
}
#endif
