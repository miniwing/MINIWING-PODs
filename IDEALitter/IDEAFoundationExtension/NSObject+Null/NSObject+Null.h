//
//  NSObject+Null.h
//  Idea
//
//  Created by Harry on 14-8-12.
//  Copyright (c) 2014年 Idea.Mobi. All rights reserved.
//
//  Mail:iidioter@gmail.com
//  TEL :+(86)18668032582
//

#import <Foundation/Foundation.h>

#define IS_NULL(STR)                         ((!STR) || ([(STR) isNull]))

@interface NSObject (Null)

- (BOOL)isNull;

@end

#define IS_EMPTY(STR)                         ((!STR) || ([(STR) isEmpty]))

@interface NSString (Empty)

- (BOOL)isEmpty;

@end

