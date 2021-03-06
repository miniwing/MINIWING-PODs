//
//  NSAttributedString+Shortcuts.h
//  FoundationExtension
//
//  Created by Jeong YunWon on 12. 10. 31..
//  Copyright (c) 2012 youknowone.org. All rights reserved.
//

/*!
 *  @file
 *  @brief [NSAttributedString][0] extension category collection.
 *      [0]: https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/Foundation/Classes/NSAttributedString_Class/Reference/Reference.html
 *  @see NSStringAttributeDictionary
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief NSAttributedString common shortcuts
 */
@interface NSAttributedString (IDEAKit)

+ (instancetype)attributedString;

+ (instancetype)attributedStringWithString:(NSString *)str;
+ (instancetype)attributedStringWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs;
+ (instancetype)attributedStringWithAttributedString:(NSAttributedString *)attrStr;

@end

NS_ASSUME_NONNULL_END
