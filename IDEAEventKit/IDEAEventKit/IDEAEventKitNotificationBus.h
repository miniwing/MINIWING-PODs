//
//  IDEAKitNotificationBus.h
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

#pragma mark -

@interface IDEAEventKitNotificationBus : NSObject

@singleton( IDEAEventKitNotificationBus )

- (void)routes:(IDEAEventKitNotification *)aNotification target:(id)aTarget;

@end
