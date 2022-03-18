//
//  IDEAEventKitNotificationCenter.h
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
#import <IDEAEventKit/IDEAEventKitSingleton.h>
#import <IDEAEventKit/IDEAEventKitNotification.h>

#pragma mark -

@interface IDEAEventKitNotificationCenter : NSObject

@singleton( IDEAEventKitNotificationCenter );

- (void)postNotification:(NSString *)aName;
- (void)postNotification:(NSString *)aName object:(id)aObject;

- (void)addObserver   :(id)aObserver forNotification:(NSString *)aName;
- (void)removeObserver:(id)aObserver forNotification:(NSString *)aName;
- (void)removeObserver:(id)aObserver;

- (void)handleNotification:(IDEAEventKitNotification *)aThat;

@end
