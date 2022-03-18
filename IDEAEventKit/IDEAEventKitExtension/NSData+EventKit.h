//
//  NSData+EventKit.h
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

#pragma mark -

@interface NSData (EventKit)

@prop_readonly( NSString*, MD5String );
@prop_readonly( NSData  *, MD5Data );

@prop_readonly( NSString*, SHA1String );
@prop_readonly( NSData  *, SHA1Data );

@prop_readonly( NSString*, BASE64Encrypted );

@end
