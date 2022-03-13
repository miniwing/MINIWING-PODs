//
//  IDEAServiceManager.h
//  IDEAServiceManager
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define __SERVICE_SECTION_NAME               "__SERVICE"
#define __SECTION_DATA(sectname)             __attribute((used, section("__DATA," #sectname)))

#define __EXPORT_SERVICE(servicename, impl)  char * k_##servicename##_service __SECTION_DATA(__SERVICE) = "{ \""#servicename"\" : \""#impl"\"}";

@interface IDEAServiceManager : NSObject

+ (instancetype)sharedManager;

- (id)createService:(Protocol *)service;

@end

@protocol IDEAIService <NSObject>

@optional
+ (id<IDEAIService>)sharedInstance;

@end
