//
//  NSMutableArray+EventKit.h
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

#import <IDEAEventKit/NSArray+EventKit.h>

#pragma mark -

@protocol NSMutableArrayProtocol <NSObject>
@required
- (void)addObject:(id)aObject;
@optional
- (void)insertObject:(id)aObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
@end

#pragma mark -

@interface NSMutableArray (EventKit)<NSMutableArrayProtocol>

+ (NSMutableArray *)nonRetainingArray;         // copy from Three20

- (void)addUniqueObject:(id)aObject compare:(NSArrayCompareBlock)aCompare;
- (void)addUniqueObjects:(const id [])aObjects count:(NSUInteger)aCount compare:(NSArrayCompareBlock)aCompare;
- (void)addUniqueObjectsFromArray:(NSArray *)aArray compare:(NSArrayCompareBlock)aCompare;

- (void)unique;
- (void)unique:(NSArrayCompareBlock)aCompare;

- (void)sort;
- (void)sort:(NSArrayCompareBlock)aCompare;

- (void)shrink:(NSUInteger)aCount;
- (void)append:(id)aObject;

- (NSMutableArray *)pushHead:(NSObject *)aObject;
- (NSMutableArray *)pushHeadN:(NSArray *)all;
- (NSMutableArray *)popTail;
- (NSMutableArray *)popTailN:(NSUInteger)n;

- (NSMutableArray *)pushTail:(NSObject *)aObject;
- (NSMutableArray *)pushTailN:(NSArray *)all;
- (NSMutableArray *)popHead;
- (NSMutableArray *)popHeadN:(NSUInteger)n;

- (NSMutableArray *)keepHead:(NSUInteger)n;
- (NSMutableArray *)keepTail:(NSUInteger)n;

@end
