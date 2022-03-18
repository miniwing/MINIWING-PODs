//
//  IDEAEventKitSignalBus.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <Foundation/Foundation.h>

#import <IDEAEventKit/IDEAEventKitSignal.h>

#pragma mark -

@interface IDEAEventKitSignalBus : NSObject

@singleton( IDEAEventKitSignalBus )

- (BOOL)send   :(IDEAEventKitSignal *)aSignal;
- (BOOL)forward:(IDEAEventKitSignal *)aSignal;
- (BOOL)forward:(IDEAEventKitSignal *)aSignal to:(id)aTarget;

- (void)routes :(IDEAEventKitSignal *)aSignal;
- (void)routes :(IDEAEventKitSignal *)aSignal to:(NSObject *)aTarget forClasses:(NSArray *)aClasses;

@end
