//
//  NSObject+Null.h
//  IDEALitter
//
//  Created by Harry on 14-8-12.
//  Copyright (c) 2014年 Idea.Mobi. All rights reserved.
//
//  Mail:iidioter@gmail.com
//  TEL :+(86)18668032582
//

#import <Foundation/Foundation.h>

#define kObjectIsNull(OBJ)                   ((!OBJ) || ([(OBJ) isNull]))

@interface NSObject (Null)

- (BOOL)isNull;

@end

#define kStringIsEmpty(STR)                   ((!STR) || ([(STR) isEmpty]))

@interface NSString (Empty)

- (BOOL)isEmpty;

@end

#define kStringIsBlank(STR)                   ((!STR) || ([(STR) isBlank]))

@interface NSString (Blank)

- (BOOL)isBlank;

@end
