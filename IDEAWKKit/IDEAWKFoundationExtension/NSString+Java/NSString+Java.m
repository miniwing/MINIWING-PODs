//
//  NSString+Java.m
//  IDEAWKKit
//
//  Created by Tang Qiao on 12-2-4.
//  Copyright (c) 2012年 blog.devtang.com. All rights reserved.
//

#import "NSString+Java.h"

@implementation NSString(Java)

/**  Java-like method. Returns the char value at the specified index. */
- (unichar) charAt:(NSInteger)index {
   return [self characterAtIndex:index];
}

/**
 * Java-like method. Compares two strings lexicographically.
 * the value 0 if the argument string is equal to this string;
 * a value less than 0 if this string is lexicographically less than the string argument;
 * and a value greater than 0 if this string is lexicographically greater than the string argument.
 */
- (int) compareTo:(NSString*) anotherString {
   return [self compare:anotherString];
}

/** Java-like method. Compares two strings lexicographically, ignoring case differences. */
- (int) compareToIgnoreCase:(NSString*) str {
   return [self compare:str options:NSCaseInsensitiveSearch];
}

/** Java-like method. Returns true if and only if this string contains the specified sequence of char values. */
- (BOOL) contains:(NSString*) str {
   NSRange range = [self rangeOfString:str];
   return (range.location != NSNotFound);
}

- (BOOL) startsWith:(NSString*)prefix {
   return [self hasPrefix:prefix];
}

- (BOOL) endsWith:(NSString*)suffix {
   return [self hasSuffix:suffix];
}

- (BOOL) equals:(NSString*) anotherString {
   return [self isEqualToString:anotherString];
}

- (BOOL) equalsIgnoreCase:(NSString*) anotherString {
   return [[self toLowerCase] equals:[anotherString toLowerCase]];
}

- (int) indexOfChar:(unichar)ch{
   return [self indexOfChar:ch fromIndex:0];
}

- (int) indexOfChar:(unichar)ch fromIndex:(int)index{
   NSUInteger len = self.length;
   for (int i = index; i < len; ++i) {
      if (ch == [self charAt:i]) {
         return i;
      }
   }
   return JavaNotFound;
}

- (NSInteger) indexOfString:(NSString*)str {
   NSRange range = [self rangeOfString:str];
   if (range.location == NSNotFound) {
      return JavaNotFound;
   }
   return range.location;
}

- (NSInteger) indexOfString:(NSString*)str fromIndex:(int)index {
   NSRange fromRange = NSMakeRange(index, self.length - index);
   NSRange range = [self rangeOfString:str options:NSLiteralSearch range:fromRange];
   if (range.location == NSNotFound) {
      return JavaNotFound;
   }
   return range.location;
}

- (NSInteger) lastIndexOfChar:(unichar)ch {
   NSInteger len = self.length;
   for (NSInteger i = len-1; i >=0; --i) {
      if ([self charAt:i] == ch) {
         return i;
      }
   }
   return JavaNotFound;
}

- (NSInteger) lastIndexOfChar:(unichar)ch fromIndex:(NSInteger)index {
   NSInteger len = self.length;
   if (index >= len) {
      index = len - 1;
   }
   for (NSInteger i = index; i >= 0; --i) {
      if ([self charAt:i] == ch) {
         return index;
      }
   }
   return JavaNotFound;
}

- (NSInteger) lastIndexOfString:(NSString*)str {
   NSRange range = [self rangeOfString:str options:NSBackwardsSearch];
   if (range.location == NSNotFound) {
      return JavaNotFound;
   }
   return range.location;
}

- (NSInteger) lastIndexOfString:(NSString*)str fromIndex:(int)index {
   NSRange fromRange = NSMakeRange(0, index);
   NSRange range = [self rangeOfString:str options:NSBackwardsSearch range:fromRange];
   if (range.location == NSNotFound) {
      return JavaNotFound;
   }
   return range.location;
}

- (NSString *) toLowerCase {
   return [self lowercaseString];
}

- (NSString *) toUpperCase {
   return [self uppercaseString];
}

//- (NSString *) trim {
//    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//}

- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement {
   return [self stringByReplacingOccurrencesOfString:origin withString:replacement];
}

- (NSArray *) split:(NSString*) separator {
   return [self componentsSeparatedByString:separator];
}

+ (BOOL) isEmpty:(NSString *)aStr {
   
   if (nil == aStr || aStr.length == 0) {
      
      return true;
      
   } /* End if () */
   
   return false;
}

@end
