//
//  NSString+EventKit.h
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

#undef  _FORMAT
#define _FORMAT( x, ... ) \
      [NSString stringWithFormat:x, __VA_ARGS__]

#pragma mark -

@interface NSString (EventKit)

@prop_readonly( NSString   *,    MD5String );
@prop_readonly( NSData     *,    MD5Data );

@prop_readonly( NSString   *,    SHA1String );
@prop_readonly( NSData     *,    SHA1Data );

@prop_readonly( NSData     *,    BASE64Decrypted );

- (NSArray *)allURLs;

- (NSString *)urlByAppendingDict:(NSDictionary *)params;
- (NSString *)urlByAppendingDict:(NSDictionary *)params encoding:(BOOL)encoding;
- (NSString *)urlByAppendingArray:(NSArray *)params;
- (NSString *)urlByAppendingArray:(NSArray *)params encoding:(BOOL)encoding;
- (NSString *)urlByAppendingKeyValues:(id)first, ...;

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict;
+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict encoding:(BOOL)encoding;;
+ (NSString *)queryStringFromArray:(NSArray *)array;
+ (NSString *)queryStringFromArray:(NSArray *)array encoding:(BOOL)encoding;;
+ (NSString *)queryStringFromKeyValues:(id)first, ...;

- (NSString *)EK_URLEncoding;
- (NSString *)EK_URLDecoding;

- (NSString *)flat;
- (NSString *)trim;
- (NSString *)unwrap;
- (NSString *)normalize;
- (NSString *)repeat:(NSUInteger)count;

- (BOOL)match:(NSString *)expression;
- (BOOL)matchAnyOf:(NSArray *)array;

- (BOOL)empty;
- (BOOL)notEmpty;

- (BOOL)eq:(NSString *)other;
- (BOOL)equal:(NSString *)other;

- (BOOL)is:(NSString *)other;
- (BOOL)isNot:(NSString *)other;

- (BOOL)isValueOf:(NSArray *)array;
- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens;

- (BOOL)isNumber;
- (BOOL)isNumberWithUnit:(NSString *)unit;
- (BOOL)isEmail;
- (BOOL)isUrl;
- (BOOL)isIPAddress;

- (NSString *)substringFromIndex:(NSUInteger)from untilString:(NSString *)string;
- (NSString *)substringFromIndex:(NSUInteger)from untilString:(NSString *)string endOffset:(NSUInteger *)endOffset;

- (NSString *)substringFromIndex:(NSUInteger)from untilCharset:(NSCharacterSet *)charset;
- (NSString *)substringFromIndex:(NSUInteger)from untilCharset:(NSCharacterSet *)charset endOffset:(NSUInteger *)endOffset;

- (NSUInteger)countFromIndex:(NSUInteger)from inCharset:(NSCharacterSet *)charset;

- (NSArray *)pairSeparatedByString:(NSString *)separator;

@end
