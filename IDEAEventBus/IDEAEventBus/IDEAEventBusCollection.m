//
//  IDEAEventBusCollection.m
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "IDEAEventBusCollection.h"
#include <pthread.h>

@class _IDEAEventBusLinkNode;
/**
 链表节点
 */
@interface _IDEAEventBusLinkNode: NSObject

@property (weak, nonatomic) _IDEAEventBusLinkNode * previous;

@property (weak, nonatomic) _IDEAEventBusLinkNode * next;

@property (nonatomic, strong) id value;

@property (nonatomic, copy) NSString * uniqueId;

@end

@implementation _IDEAEventBusLinkNode

- (instancetype)initWithValue:(id)value uniqueId:(NSString *)uniqueId {
   if (self = [super init]) {
      _value = value;
      _uniqueId = uniqueId;
   }
   return self;
}

@end

/**
 双向链表,非线程安全,使用方式确保了不会有环
 */
@interface _IDEAEventBusLinkList: NSObject

@property (assign, nonatomic, readonly) BOOL isEmpty;

@property (nonatomic, strong) _IDEAEventBusLinkNode * head;

@property (nonatomic, strong) _IDEAEventBusLinkNode * tail;

@property (nonatomic, strong) NSMutableDictionary * registeredNodeTable;

@end

@implementation _IDEAEventBusLinkList

- (instancetype)initWithNode:(_IDEAEventBusLinkNode *)node {
   if (self = [super init]) {
      _head = node;
      _tail = node;
      _registeredNodeTable = [NSMutableDictionary new];
      [_registeredNodeTable setObject:node forKey:node.uniqueId];
   }
   return self;
}

- (BOOL)isEmpty {
   return _head == nil;
}

/**
 删除一个节点
 */
- (void)removeNodeForId:(NSString *)uniqueId {
   
   //不存在
   if (![_registeredNodeTable objectForKey:uniqueId]) {
      
      return;
   }
   
   _IDEAEventBusLinkNode * node = [_registeredNodeTable objectForKey:uniqueId];
   
   if (node == _head) {
      
      _head = _head.next;
   }
   
   if (node == _tail) {
      
      _tail = _tail.previous;
   }
   
   _IDEAEventBusLinkNode * previousNode = node.previous;
   _IDEAEventBusLinkNode * nextNode = node.next;
   node.next      = nil;
   node.previous  = nil;
   previousNode.next = nextNode;
   nextNode.previous = previousNode;
   [_registeredNodeTable removeObjectForKey:uniqueId];
   
   return;
}

- (void)appendNode:(_IDEAEventBusLinkNode *)node {
   if (_head == nil) {
      _head = node;
      _tail = node;
      return;
   }
   _IDEAEventBusLinkNode * oldNode = [_registeredNodeTable objectForKey:node.uniqueId];
   if (oldNode) {
      [self replaceNode:oldNode withNode:node];
      return;
   }
   _tail.next = node;
   node.previous = _tail;
   _tail = node;
   [_registeredNodeTable setObject:node forKey:node.uniqueId];
}

- (void)replaceNode:(_IDEAEventBusLinkNode *)old withNode:(_IDEAEventBusLinkNode *)update {
   update.next = old.next;
   update.previous = old.previous;
   old.previous.next = update;
   old.next.previous = update;
   if ([[old uniqueId] isEqualToString:_head.uniqueId]) {
      _head = update;
   }
   if ([old.uniqueId isEqualToString:_tail.uniqueId]) {
      _tail = update;
   }
   [_registeredNodeTable setObject:update forKey:update.uniqueId];
}

- (NSArray *)toArray {
   NSMutableArray * array = [[NSMutableArray alloc] init];
   _IDEAEventBusLinkNode * pointer = _head;
   while (pointer != nil) {
      if (pointer.value) {
         [array addObject:pointer.value];
      }
      pointer = pointer.next;
   }
   return [[NSArray alloc] initWithArray:array];
}

@end


@interface IDEAEventBusCollection() {
   pthread_mutex_t  _accessLock;
}

@property (nonatomic, strong) NSMutableDictionary<NSString *,_IDEAEventBusLinkList *> * linkListTable;//记录key->链表的头

@end


@implementation IDEAEventBusCollection

- (instancetype)init {
   if (self = [super init]) {
      _linkListTable = [[NSMutableDictionary alloc] init];
      pthread_mutex_init(&_accessLock, NULL);
   }
   return self;
}

- (void)lockAndDo:(void(^)(void))block {
   @try {
      pthread_mutex_lock(&_accessLock);
      block();
   }@finally {
      pthread_mutex_unlock(&_accessLock);
   }
}

- (id)lockAndFetch:(id(^)(void))block {
   id result;
   @try {
      pthread_mutex_lock(&_accessLock);
      result = block();
   }@finally {
      pthread_mutex_unlock(&_accessLock);
   }
   return result;
}

- (void)addObject:(id<IDEAEventBusContainerValue>)object forKey:(NSString *)key {
   NSString * nodeUniqueKey = [object valueUniqueId];
   [self lockAndDo:^ {
      _IDEAEventBusLinkList * linkList = [self.linkListTable objectForKey:key];
      _IDEAEventBusLinkNode * updateNode = [[_IDEAEventBusLinkNode alloc] initWithValue:object
                                                                               uniqueId:nodeUniqueKey];
      if (!linkList) {
         linkList = [[_IDEAEventBusLinkList alloc] initWithNode:updateNode];
         [self.linkListTable setObject:linkList forKey:key];
      }else {
         [linkList appendNode:updateNode];
      }
   }];
}

- (BOOL)removeUniqueId:(NSString *)uniqueId ofKey:(NSString *)key {
   
   NSNumber * result = [self lockAndFetch:^id {
      
      _IDEAEventBusLinkList * linkList = [self.linkListTable objectForKey:key];
      
      [linkList removeNodeForId:uniqueId];
      
      if (linkList.isEmpty) {
         
         [self.linkListTable removeObjectForKey:key];
      }
      
      return @(linkList.isEmpty);
   }];
   
   return result.boolValue;
}

/**
 返回一组值
 */
- (NSArray *)objectsForKey:(NSString *)key {
   NSArray * arrary = [self lockAndFetch:^id {
      _IDEAEventBusLinkList * linkList = [self.linkListTable objectForKey:key];
      return linkList.toArray;
   }];
   return arrary;
}

@end
