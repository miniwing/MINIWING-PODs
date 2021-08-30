//
//  NSAttributedString+Shortcuts.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 12. 10. 31..
//  Copyright (c) 2012 youknowone.org. All rights reserved.
//

#import "NSAttributedString+Shortcuts.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSAttributedString (Shortcuts)

#if FOUNDATION_EXTENSION
#else /* FOUNDATION_EXTENSION */
+ (id)attributedString {
   
    return [[self alloc] init];
}
#endif /* !FOUNDATION_EXTENSION */

+ (instancetype)attributedStringWithString:(NSString *)str {
   
   return [[self alloc] initWithString:str];
}

+ (instancetype)attributedStringWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs {
   
   return [[self alloc] initWithString:str attributes:attrs];
}

+ (instancetype)attributedStringWithAttributedString:(NSAttributedString *)attrStr {
   
   return [[self alloc] initWithAttributedString:attrStr];
}

@end

NS_ASSUME_NONNULL_END
