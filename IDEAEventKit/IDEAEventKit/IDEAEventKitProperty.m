//
//  IDEAEventKitProperty.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKit/IDEAEventKitProperty.h"
#import "IDEAEventKit/NSObject+EventKit.h"
#import "IDEAEventKit/NSArray+EventKit.h"
#import "IDEAEventKit/NSString+EventKit.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation NSObject(Property)

+ (const char *)attributesForProperty:(NSString *)property {
   
   Class baseClass = [self baseClass];
   
   if ( nil == baseClass ) {
      
      baseClass = [NSObject class];
   }
   
   for ( Class clazzType = self; clazzType != baseClass; ) {
      
      objc_property_t prop = class_getProperty( clazzType, [property UTF8String] );
      if ( prop ) {
         
         return property_getAttributes( prop );
      }
      
      clazzType = class_getSuperclass( clazzType );
      if ( nil == clazzType ) {
         break;
      }
   }
   
   return NULL;
}

- (const char *)attributesForProperty:(NSString *)property {
   
   return [[self class] attributesForProperty:property];
}

+ (NSDictionary *)extentionForProperty:(NSString *)property {
   
   SEL fieldSelector = NSSelectorFromString( [NSString stringWithFormat:@"property_%@", property] );
   if ( [self respondsToSelector:fieldSelector] ) {
      
      __autoreleasing NSString * field = nil;
      
      NSMethodSignature * signature = [self methodSignatureForSelector:fieldSelector];
      NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
      
      [invocation setTarget:self];
      [invocation setSelector:fieldSelector];
      [invocation invoke];
      [invocation getReturnValue:&field];
      
//      field = [self performSelector:fieldSelector];
      
      if ( field && [field length] ) {
         
         NSMutableDictionary * dict = [NSMutableDictionary dictionary];
         
         NSArray * attributes = [field componentsSeparatedByString:@"____"];
         for ( NSString * attrGroup in attributes ) {
            
            NSArray *   groupComponents = [attrGroup componentsSeparatedByString:@"=>"];
            NSString *   groupName = [[[groupComponents safeObjectAtIndex:0] trim] unwrap];
            NSString *   groupValue = [[[groupComponents safeObjectAtIndex:1] trim] unwrap];
            
            if ( groupName && groupValue ) {
               
               [dict setObject:groupValue forKey:groupName];
            }
         }
         
         return dict;
      }
   }
   
   return nil;
}

- (NSDictionary *)extentionForProperty:(NSString *)property {
   
   return [[self class] extentionForProperty:property];
}

+ (NSString *)extentionForProperty:(NSString *)property stringValueWithKey:(NSString *)key {
   
   NSDictionary * extension = [self extentionForProperty:property];
   if ( nil == extension ) {
      return nil;
   }
   
   return [extension objectForKey:key];
}

- (NSString *)extentionForProperty:(NSString *)property stringValueWithKey:(NSString *)key {
   
   return [[self class] extentionForProperty:property stringValueWithKey:key];
}

+ (NSArray *)extentionForProperty:(NSString *)property arrayValueWithKey:(NSString *)key {
   
   NSDictionary * extension = [self extentionForProperty:property];
   if ( nil == extension ) {
      return nil;
   }
   
   NSString * value = [extension objectForKey:key];
   if ( nil == value ) {
      return nil;
   }
   
   return [value componentsSeparatedByString:@"|"];
}

- (NSArray *)extentionForProperty:(NSString *)property arrayValueWithKey:(NSString *)key {
   
   return [[self class] extentionForProperty:property arrayValueWithKey:key];
}

- (id)getAssociatedObjectForKey:(const char *)key {
   
   const char * propName = key; // [[NSString stringWithFormat:@"%@.%s", NSStringFromClass([self class]), key] UTF8String];
   
   id currValue = objc_getAssociatedObject( self, propName );
   return currValue;
}

- (id)copyAssociatedObject:(id)obj forKey:(const char *)key {
   
   const char * propName = key; // [[NSString stringWithFormat:@"%@.%s", NSStringFromClass([self class]), key] UTF8String];
   
   id oldValue = objc_getAssociatedObject( self, propName );
   objc_setAssociatedObject( self, propName, obj, OBJC_ASSOCIATION_COPY );
   
   return oldValue;
}

- (id)retainAssociatedObject:(id)obj forKey:(const char *)key; {
   
   const char * propName = key; // [[NSString stringWithFormat:@"%@.%s", NSStringFromClass([self class]), key] UTF8String];
   
   id oldValue = objc_getAssociatedObject( self, propName );
   objc_setAssociatedObject( self, propName, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
   
   return oldValue;
}

#if FOUNDATION_EXTENSION
#else
- (id)assignAssociatedObject:(id)obj forKey:(const char *)key {
   
   const char * propName = key; // [[NSString stringWithFormat:@"%@.%s", NSStringFromClass([self class]), key] UTF8String];
   
   id oldValue = objc_getAssociatedObject( self, propName );
   objc_setAssociatedObject( self, propName, obj, OBJC_ASSOCIATION_ASSIGN );
   
   return oldValue;
}

- (void)removeAssociatedObjectForKey:(const char *)key {
   
   const char * propName = key; // [[NSString stringWithFormat:@"%@.%s", NSStringFromClass([self class]), key] UTF8String];
   
   objc_setAssociatedObject( self, propName, nil, OBJC_ASSOCIATION_ASSIGN );
   
   return;
}
#endif

- (void)removeAllAssociatedObjects {
   
   objc_removeAssociatedObjects( self );
   
   return;
}

@end

#if __IDEA_EVENT_KIT_TESTING__

#endif // #if __IDEA_EVENT_KIT_TESTING__

#import "IDEAEventKit/__pragma_pop.h"
