//
//  NSObject+Null.h
//  IDEAKit
//
//  Created by Harry on 14-8-12.
//  Copyright (c) 2014年 Idea.Mobi. All rights reserved.
//
//  Mail:iidioter@gmail.com
//  TEL :+(852)53054612
//

#import <Foundation/Foundation.h>

#define kNumberIsEmpty(num)                  ((nil == num) || (0 >= num.intValue))

#define kObjectIsNull(OBJ)                   ((!OBJ) || ([(OBJ) isNull]))

@interface NSObject (Null)

- (BOOL)isNull;

@end

#define kStringIsEmpty(STR)                   ((!STR) || ([(STR) isEmpty]))
#define kStringIsBlank(STR)                   ((!STR) || ([(STR) isBlank]))

@interface NSString (Empty)

- (BOOL)isEmpty;
- (BOOL)isBlank;

@end

