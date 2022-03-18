//
//  NSArray+EventKit.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <Foundation/Foundation.h>

#pragma mark -

@protocol NSArrayProtocol <NSObject>
@required
- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;
@end

#pragma mark -

typedef NSMutableArray *   (^NSArrayElementBlock)( id aObject );
typedef NSComparisonResult (^NSArrayCompareBlock)( id aLeft, id aRight );

#pragma mark -

@interface NSArray (EventKit) <NSArrayProtocol>

- (NSMutableArray *)head:(NSUInteger)aCount;
- (NSMutableArray *)tail:(NSUInteger)aCount;

- (NSString *)join;
- (NSString *)join:(NSString *)aDelimiter;

- (id)safeObjectAtIndex:(NSUInteger)aIndex;
- (id)safeSubarrayWithRange:(NSRange)aRange;
- (id)safeSubarrayFromIndex:(NSUInteger)aIndex;
- (id)safeSubarrayWithCount:(NSUInteger)aCount;

@end
