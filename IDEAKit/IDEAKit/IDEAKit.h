//
//  IDEAKit.h
//  IDEAKit
//
//  Created by Harry on 14-6-29.
//  Copyright (c) 2014年 Harry. All rights reserved.
//
//  Mail:miniwing.hz@gmail.com
//  TEL :+(852)53054612

#ifndef IDEAKit_H
#define IDEAKit_H

#import <objc/message.h>
#import <objc/runtime.h>

#import <IDEAKit/IDEAAvailability.h>

#import <IDEAKit/IDEADef.h>
//#import <IDEAKit/IDEADebug.h>
//#import <IDEAKit/IDEALog.h>

#ifdef __OBJC__

#import <IDEAKit/IDEAUtils.h>
#import <IDEAKit/IDEAIdentifier.h>
#import <IDEAKit/IDEAFileUtils.h>
#import <IDEAKit/IDEATimeUtils.h>
#import <IDEAKit/KeyChainStore.h>
#import <IDEAKit/LocationCoordinate2D.h>

#import <IDEAKit/NSObject+Null.h>
#import <IDEAKit/NSObject+Ivar.h>
#import <IDEAKit/NSObject+Notification.h>
#import <IDEAKit/NSObject+Bundle.h>

#import <IDEAKit/NSString+Java.h>
#import <IDEAKit/NSString+Extension.h>
#import <IDEAKit/NSString+Network.h>
#import <IDEAKit/NSLocale+Localization.h>

#import <IDEAKit/NSArray+Hash.h>
#import <IDEAKit/NSArray+Extension.h>

#import <IDEAKit/NSDictionary+Hash.h>

#import <IDEAKit/NSAttributedString+Shortcuts.h>
#import <IDEAKit/NSAttributedString+UIKit.h>

#import <IDEAKit/NSUserDefaults+Group.h>

#import <IDEAKit/NSURLRequest+NSString.h>

#import <IDEAKit/UIApplication+Path.h>
#import <IDEAKit/UIApplication+Extension.h>
#import <IDEAKit/UncaughtExceptionHandler.h>

#import <IDEAKit/UIDevice+Device.h>

#import <IDEAKit/UIImage+Effects.h>
#import <IDEAKit/UIImage+Bundle.h>

#import <IDEAKit/AFNetworking+Operations.h>

#import <IDEAKit/YYWebImageManager+Cache.h>
#import <IDEAKit/YYWebImageManager+Operation.h>

#endif /* __OBJC__ */

#endif /* IDEAKit_H */
