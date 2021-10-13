//
//  NSString+Java.h
//  Idea
//
//  Created by Harry on 15/11/23.
//  Copyright © 2015年 Harry. All rights reserved.
//
//  Mail:iidioter@gmail.com
//  TEL :+(86)18668032582
//

#import <Foundation/Foundation.h>

@interface NSString(Java)

/**  Return the char value at the specified index. */
- (unichar) charAt:(NSInteger)index;

/**
 * Compares two strings lexicographically.
 * the value 0 if the argument string is equal to this string;
 * a value less than 0 if this string is lexicographically less than the string argument;
 * and a value greater than 0 if this string is lexicographically greater than the string argument.
 */
- (int) compareTo:(NSString*) anotherString;

- (int) compareToIgnoreCase:(NSString*) str;

- (BOOL) contains:(NSString*) str;

- (BOOL) startsWith:(NSString*)prefix;

- (BOOL) endsWith:(NSString*)suffix;

- (BOOL) equals:(NSString*) anotherString;

- (BOOL) equalsIgnoreCase:(NSString*) anotherString;

- (int) indexOfChar:(unichar)ch;

- (int) indexOfChar:(unichar)ch fromIndex:(int)index;

- (NSInteger) indexOfString:(NSString*)str;

- (NSInteger) indexOfString:(NSString*)str fromIndex:(int)index;

- (NSInteger) lastIndexOfChar:(unichar)ch;

- (NSInteger) lastIndexOfChar:(unichar)ch fromIndex:(NSInteger)index;

- (NSInteger) lastIndexOfString:(NSString*)str;

- (NSInteger) lastIndexOfString:(NSString*)str fromIndex:(int)index;

- (NSString *) substringFromIndex:(int)beginIndex toIndex:(int)endIndex;

- (NSString *) toLowerCase;

- (NSString *) toUpperCase;

- (NSString *) trim;

- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement;

- (NSArray *) split:(NSString*) separator;

+ (BOOL) isEmpty:(NSString *)aStr;

@end






