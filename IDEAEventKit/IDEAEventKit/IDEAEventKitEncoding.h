//
//  IDEAEventKitEncoding.h
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
#import <IDEAEventKit/IDEAEventKitSingleton.h>

#pragma mark -

typedef enum {
   
   EncodingType_Unknown = 0,
   EncodingType_Null,
   EncodingType_Number,
   EncodingType_String,
   EncodingType_Date,
   EncodingType_Data,
   EncodingType_Url,
   EncodingType_Array,
   EncodingType_Dict
   
} EncodingType;

#pragma mark -

@interface NSObject(Encoding)

/**
 *  对象编码
 *
 *  @param type 目标编码类型
 *
 *  @return 编码结果
 */

- (NSObject *)converToType:(EncodingType)type;

@end

#pragma mark -

/**
 *  「编码器」
 */

@interface IDEAEventKitEncoding : NSObject

/**
 *  判断对象属性是否为只读
 *
 *  @param attr 属性名称
 *
 *  @return YES 或 NO
 */

+ (BOOL)isReadOnly:(const char *)aAttr;

+ (EncodingType)typeOfAttribute:(const char *)aAttr;
+ (EncodingType)typeOfClassName:(const char *)aAttr;
+ (EncodingType)typeOfClass:(Class)aClass;
+ (EncodingType)typeOfObject:(id)aObj;

+ (NSString *)classNameOfAttribute:(const char *)aAttr;
+ (NSString *)classNameOfClass:(Class)aClass;
+ (NSString *)classNameOfObject:(id)aObj;

+ (Class)classOfAttribute:(const char *)aAttr;

+ (BOOL)isAtomAttribute:(const char *)aAttr;
+ (BOOL)isAtomClassName:(const char *)aClass;
+ (BOOL)isAtomClass:(Class)aClass;
+ (BOOL)isAtomObject:(id)aObj;

@end
