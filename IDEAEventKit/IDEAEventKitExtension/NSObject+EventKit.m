//
//  NSObject+EventKit.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKit/NSObject+EventKit.h"
#import "IDEAEventKit/NSDate+EventKit.h"
#import "IDEAEventKit/NSObject+EventKit.h"
#import "IDEAEventKit/NSDictionary+EventKit.h"
#import "IDEAEventKit/NSMutableDictionary+EventKit.h"

#import "IDEAEventKit/IDEAEventKitEncoding.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation NSObject (EventKit)

+ (Class)baseClass {
   
   return [NSObject class];
}

+ (id)unserializeForUnknownValue:(id)value {
   
   UNUSED(value)
   
   return nil;
}

+ (id)serializeForUnknownValue:(id)value {
   
   UNUSED(value)
   
   return nil;
}


- (void)deepEqualsTo:(id)aObject {
   
   Class stBaseClass = [[self class] baseClass];
   if (nil == stBaseClass) {
      
      stBaseClass = [NSObject class];
      
   } /* End if () */
   
   for (Class stClazzType = [self class]; stClazzType != stBaseClass;) {
      
      unsigned int       nPropertyCount   = 0;
      objc_property_t   *pstProperties    = class_copyPropertyList(stClazzType, &nPropertyCount);
      
      for (NSUInteger H = 0; H < nPropertyCount; H++) {
         
         const char  *cpcName = property_getName(pstProperties[H]);
         const char  *cpcAttr = property_getAttributes(pstProperties[H]);
         
         if ([IDEAEventKitEncoding isReadOnly:cpcAttr]) {
            
            continue;
            
         } /* End if () */
         
         NSString *szPropertyName   = [NSString stringWithCString:cpcName encoding:NSUTF8StringEncoding];
         NSObject *szPropertyValue  = [aObject valueForKey:szPropertyName];
         
         [self setValue:szPropertyValue forKey:szPropertyName];
         
      } /* End for () */
      
      FREE_IF(pstProperties);
      
      stClazzType = class_getSuperclass(stClazzType);
      if (nil == stClazzType) {
         
         break;
         
      } /* End if () */
      
   } /* End for () */
   
   return;
}


- (void)deepCopyFrom:(id)aObject {
   
   if (nil == aObject) {
      
      return;
      
   } /* End if () */
   
   Class  stBaseClass   = [[aObject class] baseClass];
   if (nil == stBaseClass) {
      
      stBaseClass = [NSObject class];
      
   } /* End if () */
   
   for (Class stClazzType = [aObject class]; stClazzType != stBaseClass;) {
      
      unsigned int       nPropertyCount   = 0;
      objc_property_t   *pstProperties    = class_copyPropertyList(stClazzType, &nPropertyCount);
      
      for (NSUInteger H = 0; H < nPropertyCount; H++) {
         
         const char  *cpcName = property_getName(pstProperties[H]);
         const char  *cpcAttr = property_getAttributes(pstProperties[H]);
         
         if ([IDEAEventKitEncoding isReadOnly:cpcAttr]) {
            
            continue;
            
         } /* End if () */
         
         NSString * propertyName = [NSString stringWithCString:cpcName encoding:NSUTF8StringEncoding];
         NSObject * propertyValue = [aObject valueForKey:propertyName];
         
         [self setValue:propertyValue forKey:propertyName];
         
      } /* End for () */
      
      FREE_IF(pstProperties);
      
      stClazzType = class_getSuperclass(stClazzType);
      if (nil == stClazzType) {
         
         break;
      } /* End if () */
      
   } /* End for () */
   
   return;
}

+ (id)unserialize:(id)aObject {
   
   return [self unserialize:aObject withClass:self];
}

+ (id)unserialize:(id)aObject withClass:(Class)aClass {
   
   if (nil == aObject) {
      
      return nil;
      
   } /* End if () */
   
   if (nil == aClass) {
      
      return aObject;
      
   } /* End if () */
   else if ([aObject isKindOfClass:aClass]) {
      
      return aObject;
      
   } /* End if () */
   
   EncodingType    eType   = [IDEAEventKitEncoding typeOfObject:aObject];
   
   if (EncodingType_Array == eType) {
      
      NSMutableArray *stResult = [NSMutableArray array];
      
      for (id stElem in (NSArray *)aObject) {
         
         id stSubResult = [self unserialize:stElem withClass:aClass];
         if (stSubResult) {
            
            [stResult addObject:stSubResult];
            
         } /* End if () */
         
      } /* End for () */
      
      return stResult;
      
   } /* End if () */
   else if (EncodingType_Dict == eType) {
      
      NSDictionary   *stDict  = (NSDictionary *)aObject;
      if (0 == stDict.count) {
         
         return nil;
         
      } /* End if () */
      
      id  stResult   = [[aClass alloc] init];
      if (nil == stResult) {
         
         return nil;
         
      } /* End if () */
      
      Class stBaseClass = [[aObject class] baseClass];
      if (nil == stBaseClass) {
         
         stBaseClass = [NSObject class];
         
      } /* End if () */
      
      for (Class stClassType = aClass; stClassType != stBaseClass;) {
         
         if ([IDEAEventKitEncoding isAtomClass:stClassType]) {
            
            break;
            
         } /* End if () */
         
         unsigned int       nPropertyCount   = 0;
         objc_property_t   *pstProperties    = class_copyPropertyList(stClassType, &nPropertyCount);
         
         for (NSUInteger H = 0; H < nPropertyCount; H++) {
            
            const char *cpcName     = property_getName(pstProperties[H]);
            const char *cpcAttr     = property_getAttributes(pstProperties[H]);
            
            BOOL         bReadonly  = [IDEAEventKitEncoding isReadOnly:cpcAttr];
            if (bReadonly) {
               
               continue;
               
            } /* End if () */
            
            NSString *   propertyName = [NSString stringWithCString:cpcName encoding:NSUTF8StringEncoding];
            NSObject *   tempValue = [stDict objectForKey:propertyName];
            NSObject *   value = nil;
            
            if (tempValue) {
               
               NSInteger propertyType = [IDEAEventKitEncoding typeOfAttribute:cpcAttr];
               
               if (EncodingType_Null == propertyType) {
                  
                  value = nil;
               }
               else if (EncodingType_Number == propertyType) {
                  
                  value = [tempValue toNumber];
               }
               else if (EncodingType_String == propertyType) {
                  
                  value = [tempValue toString];
               }
               else if (EncodingType_Array == propertyType) {
                  
                  value = tempValue;
                  
                  __autoreleasing Class convertClass = nil;
                  
                  if (nil == convertClass) {
                     
                     SEL convertSelector = NSSelectorFromString([NSString stringWithFormat:@"convertClass_%@", propertyName]);
                     if ([aClass respondsToSelector:convertSelector]) {
                        
                        //                        convertClass = [clazz performSelector:convertSelector];
                        
                        NSMethodSignature * signature = [aClass methodSignatureForSelector:convertSelector];
                        NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
                        
                        [invocation setTarget:aClass];
                        [invocation setSelector:convertSelector];
                        [invocation invoke];
                        [invocation getReturnValue:&convertClass];
                     }
                  }
                  
                  if (nil == convertClass) {
                     
                     NSString * convertClassName = [stClassType extentionForProperty:propertyName stringValueWithKey:@"Class"];
                     if (convertClassName) {
                        
                        convertClass = NSClassFromString(convertClassName);
                     }
                  }
                  
                  if (convertClass) {
                     
                     NSMutableArray * arrayTemp = [NSMutableArray array];
                     
                     for (NSObject * tempObject in (NSArray *)tempValue) {
                        
                        id elem = [convertClass unserialize:tempObject];
                        if (elem) {
                           
                           [arrayTemp addObject:elem];
                        }
                     }
                     
                     value = arrayTemp;
                  }
               }
               else if (EncodingType_Dict == propertyType) {
                  
                  value = tempValue;
               }
               else if (EncodingType_Date == propertyType) {
                  
                  value = [tempValue toDate];
               }
               else if (EncodingType_Data == propertyType) {
                  
                  value = [tempValue toData];
               }
               else if (EncodingType_Url == propertyType) {
                  
                  value = [tempValue toURL];
               }
               else {
                  
                  Class classType = [IDEAEventKitEncoding classOfAttribute:cpcAttr];
                  if (classType) {
                     
                     if ([tempValue isKindOfClass:classType]) {
                        
                        value = tempValue;
                     }
                     else {
                        
                        value = [classType unserialize:tempValue];
                        if (nil == value) {
                           
                           value = [classType unserializeForUnknownValue:tempValue];
                        }
                     }
                  }
               }
            }
            
            NSArray * policyValues = [stClassType extentionForProperty:propertyName arrayValueWithKey:@"Policy"];
            
            if (policyValues) {
               
               BOOL isSave = NO;
               BOOL isLoad = NO;
               BOOL isClear = NO;
               
               for (NSString * policyValue in policyValues) {
                  
                  if (NSOrderedSame == [policyValue compare:@"save" options:NSCaseInsensitiveSearch]) {
                     
                     isSave = YES;
                  }
                  else if (NSOrderedSame == [policyValue compare:@"load" options:NSCaseInsensitiveSearch]) {
                     
                     isLoad = YES;
                  }
                  else if (NSOrderedSame == [policyValue compare:@"clear" options:NSCaseInsensitiveSearch]) {
                     
                     isClear = YES;
                  }
               }
               
               if (NO == isLoad)
                  continue;
            }
            
            if (nil != value) {
               
               [stResult setValue:value forKey:propertyName];
            }
         }
         
         free(pstProperties);
         
         stClassType = class_getSuperclass(stClassType);
         if (nil == stClassType)
            break;
      }
      
      return stResult;
   }
   
   return nil;
}

- (void)unserialize:(id)obj {
   
   if (nil == obj)
      return;
   
   EncodingType type = [IDEAEventKitEncoding typeOfObject:obj];
   
   if (EncodingType_Array == type) {
      
      TODO("does not support array");
      return;
   }
   else if (EncodingType_Dict == type) {
      
      NSDictionary * dict = (NSDictionary *)obj;
      if (0 == dict.count)
         return;
      
      Class baseClass = [[obj class] baseClass];
      if (nil == baseClass) {
         
         baseClass = [NSObject class];
      }
      
      for (Class clazzType = [self class]; clazzType != baseClass;) {
         
         if ([IDEAEventKitEncoding isAtomClass:clazzType]) {
            
            break;
         }
         
         unsigned int      propertyCount = 0;
         objc_property_t *   properties = class_copyPropertyList(clazzType, &propertyCount);
         
         for (NSUInteger i = 0; i < propertyCount; i++) {
            
            const char *   name = property_getName(properties[i]);
            const char *   attr = property_getAttributes(properties[i]);
            
            BOOL readonly = [IDEAEventKitEncoding isReadOnly:attr];
            if (readonly)
               continue;
            
            NSString *   propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            NSObject *   tempValue = [dict objectForKey:propertyName];
            NSObject *   value = nil;
            
            if (tempValue) {
               
               NSInteger propertyType = [IDEAEventKitEncoding typeOfAttribute:attr];
               
               if (EncodingType_Null == propertyType) {
                  
                  value = nil;
               }
               else if (EncodingType_Number == propertyType) {
                  
                  value = [tempValue toNumber];
               }
               else if (EncodingType_String == propertyType) {
                  
                  value = [tempValue toString];
               }
               else if (EncodingType_Array == propertyType) {
                  
                  value = tempValue;
                  
                  __autoreleasing Class convertClass = nil;
                  
                  if (nil == convertClass) {
                     
                     SEL convertSelector = NSSelectorFromString([NSString stringWithFormat:@"convertClass_%@", propertyName]);
                     if ([[self class] respondsToSelector:convertSelector]) {
                        
                        //                        convertClass = [[self class] performSelector:convertSelector];
                        
                        NSMethodSignature * signature = [[self class] methodSignatureForSelector:convertSelector];
                        NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
                        
                        [invocation setTarget:[self class]];
                        [invocation setSelector:convertSelector];
                        [invocation invoke];
                        [invocation getReturnValue:&convertClass];
                     }
                  }
                  
                  if (nil == convertClass) {
                     
                     NSString * convertClassName = [clazzType extentionForProperty:propertyName stringValueWithKey:@"Class"];
                     
                     if (convertClassName) {
                        
                        convertClass = NSClassFromString(convertClassName);
                     }
                  }
                  
                  if (convertClass) {
                     
                     NSMutableArray * arrayTemp = [NSMutableArray array];
                     
                     for (NSObject * tempObject in (NSArray *)tempValue) {
                        
                        id elem = [convertClass unserialize:tempObject];
                        if (elem) {
                           
                           [arrayTemp addObject:elem];
                        }
                     }
                     
                     value = arrayTemp;
                  }
               }
               else if (EncodingType_Dict == propertyType) {
                  
                  value = tempValue;
               }
               else if (EncodingType_Date == propertyType) {
                  
                  value = [tempValue toDate];
               }
               else if (EncodingType_Data == propertyType) {
                  
                  value = [tempValue toData];
               }
               else if (EncodingType_Url == propertyType) {
                  
                  value = [tempValue toURL];
               }
               else {
                  
                  Class classType = [IDEAEventKitEncoding classOfAttribute:attr];
                  if (classType) {
                     
                     if ([tempValue isKindOfClass:classType]) {
                        
                        value = tempValue;
                     }
                     else {
                        
                        value = [classType unserialize:tempValue];
                        if (nil == value) {
                           
                           value = [classType unserializeForUnknownValue:tempValue];
                        }
                     }
                  }
               }
            }
            
            NSArray * policyValues = [clazzType extentionForProperty:propertyName arrayValueWithKey:@"Policy"];
            
            if (policyValues) {
               
               BOOL isSave = NO;
               BOOL isLoad = NO;
               BOOL isClear = NO;
               
               for (NSString * policyValue in policyValues) {
                  
                  if (NSOrderedSame == [policyValue compare:@"save" options:NSCaseInsensitiveSearch]) {
                     
                     isSave = YES;
                  }
                  else if (NSOrderedSame == [policyValue compare:@"load" options:NSCaseInsensitiveSearch]) {
                     
                     isLoad = YES;
                  }
                  else if (NSOrderedSame == [policyValue compare:@"clear" options:NSCaseInsensitiveSearch]) {
                     
                     isClear = YES;
                  }
               }
               
               if (NO == isLoad)
                  continue;
            }
            
            if (nil != value) {
               
               [self setValue:value forKey:propertyName];
            }
         }
         
         free(properties);
         
         clazzType = class_getSuperclass(clazzType);
         if (nil == clazzType)
            break;
      }
   }
}

- (id)serialize {
   
   id obj = self;
   
   if (nil == obj) {
      
      return nil;
   }
   
   EncodingType type = [IDEAEventKitEncoding typeOfObject:obj];
   
   if (EncodingType_Null == type) {
      
      return obj;
   }
   else if (EncodingType_Number == type) {
      
      return obj;
   }
   else if (EncodingType_String == type) {
      
      return obj;
   }
   else if (EncodingType_Date == type) {
      
      return [(NSDate *)obj toString:@"yyyy/MM/dd HH:mm:ss z"];
   }
   else if (EncodingType_Data == type) {
      
      return obj;
   }
   else if (EncodingType_Url == type) {
      
      return [obj toString];
   }
   else if (EncodingType_Array == type) {
      
      NSMutableArray * result = [NSMutableArray array];
      
      for (id elem in (NSArray *)obj) {
         
         id subResult = [elem serialize];
         if (subResult) {
            
            [result addObject:subResult];
         }
      }
      
      return result;
   }
   else if (EncodingType_Dict == type) {
      
      NSMutableDictionary * result = [NSMutableDictionary dictionary];
      
      for (NSString * key in [(NSDictionary *)obj allKeys]) {
         
         NSObject * value = [(NSDictionary *)obj objectForKey:key];
         if (value) {
            
            id subResult = [value serialize];
            if (subResult) {
               
               [result setObject:subResult forKey:key];
            }
         }
      }
      
      return result;
   }
   else {
      
      NSMutableDictionary * result = [NSMutableDictionary dictionary];
      
      Class baseClass = [[obj class] baseClass];
      if (nil == baseClass) {
         
         baseClass = [NSObject class];
      }
      
      for (Class clazzType = [self class]; clazzType != baseClass;) {
         
         if ([IDEAEventKitEncoding isAtomClass:clazzType]) {
            
            break;
         }
         
         unsigned int      propertyCount = 0;
         objc_property_t *   properties = class_copyPropertyList(clazzType, &propertyCount);
         
         for (NSUInteger i = 0; i < propertyCount; i++) {
            
            const char *   name = property_getName(properties[i]);
            //            const char *   attr = property_getAttributes(properties[i]);
            NSString *      propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            
            NSArray * policyValues = [clazzType extentionForProperty:propertyName arrayValueWithKey:@"Policy"];
            
            if (policyValues) {
               
               BOOL isSave = NO;
               BOOL isLoad = NO;
               BOOL isClear = NO;
               
               for (NSString * policyValue in policyValues) {
                  
                  if (NSOrderedSame == [policyValue compare:@"save" options:NSCaseInsensitiveSearch]) {
                     
                     isSave = YES;
                  }
                  else if (NSOrderedSame == [policyValue compare:@"load" options:NSCaseInsensitiveSearch]) {
                     
                     isLoad = YES;
                  }
                  else if (NSOrderedSame == [policyValue compare:@"clear" options:NSCaseInsensitiveSearch]) {
                     
                     isClear = YES;
                  }
               }
               
               if (NO == isSave)
                  continue;
            }
            
            NSObject * value = [self valueForKey:propertyName];
            
            if (value) {
               
               id subResult = [value serialize];
               if (subResult) {
                  
                  [result setObject:subResult forKey:propertyName];
               }
            }
         }
         
         free(properties);
         
         clazzType = class_getSuperclass(clazzType);
         if (nil == clazzType)
            break;
      }
      
      return result.count ? result : nil;
   }
   
   return nil;
}

- (void)zerolize {
   
   id obj = self;
   
   Class baseClass = [[obj class] baseClass];
   if (nil == baseClass) {
      
      baseClass = [NSObject class];
   }
   
   if ([IDEAEventKitEncoding isAtomObject:self]) {
      
      return;
   }
   
   for (Class clazzType = [self class]; clazzType != baseClass;) {
      
      if ([IDEAEventKitEncoding isAtomClass:clazzType]) {
         
         break;
      }
      
      unsigned int      propertyCount = 0;
      objc_property_t *   properties = class_copyPropertyList(clazzType, &propertyCount);
      
      for (NSUInteger i = 0; i < propertyCount; i++) {
         
         const char *   name = property_getName(properties[i]);
         const char *   attr = property_getAttributes(properties[i]);
         
         NSString *      propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
         EncodingType   propertyType = [IDEAEventKitEncoding typeOfAttribute:attr];
         
         NSArray * policyValues = [clazzType extentionForProperty:propertyName arrayValueWithKey:@"Policy"];
         
         if (policyValues) {
            
            BOOL isSave = NO;
            BOOL isLoad = NO;
            BOOL isClear = NO;
            
            for (NSString * policyValue in policyValues) {
               
               if (NSOrderedSame == [policyValue compare:@"save" options:NSCaseInsensitiveSearch]) {
                  
                  isSave = YES;
               }
               else if (NSOrderedSame == [policyValue compare:@"load" options:NSCaseInsensitiveSearch]) {
                  
                  isLoad = YES;
               }
               else if (NSOrderedSame == [policyValue compare:@"clear" options:NSCaseInsensitiveSearch]) {
                  
                  isClear = YES;
               }
            }
            
            if (NO == isClear)
               continue;
         }
         
         if (EncodingType_Number == propertyType) {
            
            [self setValue:nil forKey:propertyName];
         }
         else if (EncodingType_String == propertyType) {
            
            [self setValue:nil forKey:propertyName];
         }
         else if (EncodingType_Date == propertyType) {
            
            [self setValue:nil forKey:propertyName];
         }
         else if (EncodingType_Data == propertyType) {
            
            [self setValue:nil forKey:propertyName];
         }
         else if (EncodingType_Url == propertyType) {
            
            [self setValue:nil forKey:propertyName];
         }
         else if (EncodingType_Array == propertyType) {
            
            [self setValue:[NSMutableArray array] forKey:propertyName];
         }
         else if (EncodingType_Dict == propertyType) {
            
            [self setValue:[NSMutableDictionary dictionary] forKey:propertyName];
         }
         else {
            
            Class clazz = [IDEAEventKitEncoding classOfAttribute:attr];
            if (clazz) {
               
               NSObject * newObj = [[clazz alloc] init];
               if (newObj) {
                  
                  [self setValue:newObj forKey:propertyName];
               }
               else {
                  
                  [self setValue:nil forKey:propertyName];
               }
            }
            else {
               
               [self setValue:nil forKey:propertyName];
            }
         }
      }
      
      free(properties);
      
      clazzType = class_getSuperclass(clazzType);
      if (nil == clazzType) {
         
         break;
      }
   }
}

- (id)clone {
   
   id newObject = [[[self class] alloc] init];
   
   if (newObject) {
      
      [newObject deepCopyFrom:self];
   }
   
   return newObject;
}

#pragma mark -

- (id)JSONEncoded {
   
   NSError * error = nil;
   NSData * result = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
   if (nil == result) {
      
      LogError((@"%@", error));
      
      return nil;
   }
   
   return result;
}

- (id)JSONDecoded {
   
   NSError * error = nil;
   NSObject * result = [NSJSONSerialization JSONObjectWithData:[self toData] options:NSJSONReadingAllowFragments error:&error];
   if (nil == result) {
      
      LogError((@"%@", error));
      
      return nil;
   }
   
   return result;
}

- (BOOL)toBool {
   
   return [[self toNumber] boolValue];
}

- (float)toFloat {
   
   return [[self toNumber] floatValue];
}

- (double)toDouble {
   
   return [[self toNumber] doubleValue];
}

- (NSInteger)toInteger {
   
   return [[self toNumber] integerValue];
}

- (NSUInteger)toUnsignedInteger {
   
   return [[self toNumber] unsignedIntegerValue];
}

- (NSURL *)toURL {
   
   NSString * string = [self toString];
   if (nil == string) {
      
      return nil;
   }
   
   return [NSURL URLWithString:string];
}

- (NSDate *)toDate {
   
   EncodingType encoding = [IDEAEventKitEncoding typeOfObject:self];
   
   if (EncodingType_Null == encoding) {
      
      return nil;
   }
   else if (EncodingType_Number == encoding) {
      
      NSNumber * number = (NSNumber *)self;
      return [NSDate dateWithTimeIntervalSince1970:[number doubleValue]];
   }
   else if (EncodingType_String == encoding) {
      
      return [NSDate fromString:(NSString *)self];
   }
   else if (EncodingType_Date == encoding) {
      
      return (NSDate *)self;
   }
   else if (EncodingType_Data == encoding) {
      
      NSData *   data = (NSData *)self;
      NSString *   string = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
      
      return [NSDate fromString:string];
   }
   else if (EncodingType_Url == encoding) {
      
      return nil;
   }
   else if (EncodingType_Array == encoding) {
      
      return nil;
   }
   else if (EncodingType_Dict == encoding) {
      
      return nil;
   }
   
   return nil;
}

- (NSData *)toData {
   
   EncodingType encoding = [IDEAEventKitEncoding typeOfObject:self];
   
   if (EncodingType_Null == encoding) {
      
      return nil;
   }
   else if (EncodingType_Number == encoding) {
      
      NSString * string = [(NSNumber *)self description];
      return [string dataUsingEncoding:NSUTF8StringEncoding];
   }
   else if (EncodingType_String == encoding) {
      
      NSString * string = (NSString *)self;
      return [string dataUsingEncoding:NSUTF8StringEncoding];
   }
   else if (EncodingType_Date == encoding) {
      
      NSString * string = [(NSDate *)self toString:@"yyyy/MM/dd HH:mm:ss z"];
      return [string dataUsingEncoding:NSUTF8StringEncoding];
   }
   else if (EncodingType_Data == encoding) {
      
      return (NSData *)self;
   }
   else if (EncodingType_Url == encoding) {
      
      NSURL * url = (NSURL *)self;
      return [[url absoluteString] dataUsingEncoding:NSUTF8StringEncoding];
   }
   else if (EncodingType_Array == encoding) {
      
      NSMutableArray * array = [NSMutableArray array];
      
      for (NSObject * elem in (NSArray *)self) {
         
         id serializedObject = [elem serialize];
         if (serializedObject) {
            
            [array addObject:serializedObject];
         }
      }
      
      return [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:NULL];
   }
   else if (EncodingType_Dict == encoding) {
      
      id serializedObject = [self serialize];
      if (serializedObject) {
         
         return [NSJSONSerialization dataWithJSONObject:serializedObject options:kNilOptions error:NULL];
      }
   }
   else {
      
      id serializedObject = [self serialize];
      if (serializedObject) {
         
         return [NSJSONSerialization dataWithJSONObject:serializedObject options:kNilOptions error:NULL];
      }
   }
   
   return nil;
}

- (NSNumber *)toNumber {
   
   EncodingType encoding = [IDEAEventKitEncoding typeOfObject:self];
   
   if (EncodingType_Null == encoding) {
      
      return [NSNumber numberWithInt:0];
   }
   else if (EncodingType_Number == encoding) {
      
      return (NSNumber *)self;
   }
   else if (EncodingType_String == encoding) {
      
      NSString * string = (NSString *)self;
      
      if (NSOrderedSame == [string compare:@"yes" options:NSCaseInsensitiveSearch] ||
          NSOrderedSame == [string compare:@"true" options:NSCaseInsensitiveSearch] ||
          NSOrderedSame == [string compare:@"on" options:NSCaseInsensitiveSearch] ||
          NSOrderedSame == [string compare:@"1" options:NSCaseInsensitiveSearch]) {
         
         return [NSNumber numberWithBool:YES];
      }
      else if (NSOrderedSame == [string compare:@"no" options:NSCaseInsensitiveSearch] ||
               NSOrderedSame == [string compare:@"off" options:NSCaseInsensitiveSearch] ||
               NSOrderedSame == [string compare:@"false" options:NSCaseInsensitiveSearch] ||
               NSOrderedSame == [string compare:@"0" options:NSCaseInsensitiveSearch]) {
         
         return [NSNumber numberWithBool:NO];
      }
      else {
         
         return [NSNumber numberWithInteger:[string integerValue]];
      }
   }
   else if (EncodingType_Date == encoding) {
      
      NSDate * date = (NSDate *)self;
      return [NSNumber numberWithDouble:[date timeIntervalSince1970]];
   }
   else if (EncodingType_Data == encoding) {
      
      NSData * data = (NSData *)self;
      NSString * string = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
      if (string) {
         
         return [NSNumber numberWithInteger:[string integerValue]];
      }
   }
   else if (EncodingType_Url == encoding) {
      
      return nil;
   }
   else if (EncodingType_Array == encoding) {
      
      return nil;
   }
   else if (EncodingType_Dict == encoding) {
      
      return nil;
   }
   
   return nil;
}

- (NSString *)toString {
   
   EncodingType    encoding = [IDEAEventKitEncoding typeOfObject:self];
   
   if (EncodingType_Null == encoding) {
      
      return nil;
   }
   else if (EncodingType_Number == encoding) {
      
      return [self description];
   }
   else if (EncodingType_String == encoding) {
      
      return (NSString *)self;
   }
   else if (EncodingType_Date == encoding) {
      
      return [(NSDate *)self toString:@"yyyy/MM/dd HH:mm:ss z"];
   }
   else if (EncodingType_Data == encoding) {
      
      NSData *   data = (NSData *)self;
      NSString *   text = nil;
      
      text = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
      if (nil == text) {
         
         text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         if (nil == text) {
            
            text = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
         }
      }
      
      return text;
   }
   else if (EncodingType_Url == encoding) {
      
      NSURL * url = (NSURL *)self;
      return [url absoluteString];
   }
   else if (EncodingType_Array == encoding) {
      
      NSMutableArray * array = [NSMutableArray array];
      
      for (NSObject * elem in (NSArray *)self) {
         
         id serializedObject = [elem serialize];
         if (serializedObject) {
            
            [array addObject:serializedObject];
         }
      }
      
      NSData * result = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:NULL];
      if (result) {
         
         return [result toString];
      }
   }
   else if (EncodingType_Dict == encoding) {
      
      id serializedObject = [self serialize];
      if (serializedObject) {
         
         NSData * result = [NSJSONSerialization dataWithJSONObject:serializedObject options:kNilOptions error:NULL];
         if (result) {
            
            return [result toString];
         }
      }
   }
   else {
      
      id serializedObject = [self serialize];
      if (serializedObject) {
         
         NSData * result = [NSJSONSerialization dataWithJSONObject:serializedObject options:kNilOptions error:NULL];
         if (result) {
            
            return [result toString];
         }
      }
   }
   
   return nil;
}


@end

// ----------------------------------
// Unit test
// ----------------------------------

#pragma mark -

#if __IDEA_EVENT_KIT_TESTING__

#endif // #if __IDEA_EVENT_KIT_TESTING__

#import "IDEAEventKit/__pragma_pop.h"
