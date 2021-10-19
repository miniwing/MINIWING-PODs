//
//  NSUserDefaults+Group.m
//  IDEAKit
//
//  Created by Harry on 2019/9/30.
//  Copyright © 2019 Harry. All rights reserved.
//

#import "IDEALitter/NSUserDefaults+Group.h"

@implementation NSUserDefaults (Extension)

+ (void)setInteger:(NSInteger)aValue forKey:(NSString *)aDefaultName {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults setInteger:aValue forKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (void)setFloat:(float)aValue forKey:(NSString *)aDefaultName {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults setFloat:aValue forKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (void)setDouble:(double)aValue forKey:(NSString *)aDefaultName {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults setDouble:aValue forKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (void)setBool:(BOOL)aValue forKey:(NSString *)aDefaultName {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults setBool:aValue forKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (void)setURL:(nullable NSURL *)aURL forKey:(NSString *)aDefaultName {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults setURL:aURL forKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (void)setObject:(nullable id)aValue forKey:(NSString *)aDefaultName {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults setObject:aValue forKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (void)removeObjectForKey:(NSString *)aDefaultName {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults removeObjectForKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (nullable id)objectForKey:(NSString *)aDefaultName {
   
   id              stObject         = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      stObject = [stUserDefaults objectForKey:aDefaultName];
      
   } /* End if () */
   
   return stObject;
}

+ (nullable NSString *)stringForKey:(NSString *)aDefaultName {
   
   NSString       *szValue          = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      szValue  = [stUserDefaults stringForKey:aDefaultName];
      
   } /* End if () */
   
   return szValue;
}

+ (nullable NSArray *)arrayForKey:(NSString *)aDefaultName {
   
   NSArray        *stValue          = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      stValue  = [stUserDefaults arrayForKey:aDefaultName];
      
   } /* End if () */
   
   return stValue;
}

+ (nullable NSDictionary<NSString *, id> *)dictionaryForKey:(NSString *)aDefaultName {
   
   NSDictionary<NSString *, id>  *stValue = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      stValue  = [stUserDefaults dictionaryForKey:aDefaultName];
      
   } /* End if () */
   
   return stValue;
}

+ (nullable NSData *)dataForKey:(NSString *)aDefaultName {
   
   NSData         *stValue          = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      stValue  = [stUserDefaults dataForKey:aDefaultName];
      
   } /* End if () */
   
   return stValue;
}

+ (nullable NSArray<NSString *> *)stringArrayForKey:(NSString *)aDefaultName {
   
   NSArray<NSString *>  *stValue    = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      stValue  = [stUserDefaults stringArrayForKey:aDefaultName];
      
   } /* End if () */
   
   return stValue;
}

+ (NSInteger)integerForKey:(NSString *)aDefaultName {
   
   NSInteger       nValue           = 0;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      nValue   = [stUserDefaults integerForKey:aDefaultName];
      
   } /* End if () */
   
   return nValue;
}

+ (float)floatForKey:(NSString *)aDefaultName {
   
   float           fValue           = 0.0f;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      fValue   = [stUserDefaults floatForKey:aDefaultName];
      
   } /* End if () */
   
   return fValue;
}

+ (double)doubleForKey:(NSString *)aDefaultName {
   
   double          dValue           = 0.0f;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      dValue   = [stUserDefaults doubleForKey:aDefaultName];
      
   } /* End if () */
   
   return dValue;
}

+ (BOOL)boolForKey:(NSString *)aDefaultName {
   
   BOOL            bValue           = NO;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      bValue   = [stUserDefaults boolForKey:aDefaultName];
      
   } /* End if () */
   
   return bValue;
}

+ (nullable NSURL *)URLForKey:(NSString *)aDefaultName {
   
   NSURL          *stURL            = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
   
   if (nil != stUserDefaults) {
      
      stURL = [stUserDefaults URLForKey:aDefaultName];
      
   } /* End if () */
   
   return stURL;
}

@end


@implementation NSUserDefaults (Group)

+ (instancetype)suite:(NSString *)aSuite {
   
   return [[NSUserDefaults alloc] initWithSuiteName:aSuite];
}

+ (void)setInteger:(NSInteger)aValue forKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults setInteger:aValue forKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (void)setFloat:(float)aValue forKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults setFloat:aValue forKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (void)setDouble:(double)aValue forKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults setDouble:aValue forKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (void)setBool:(BOOL)aValue forKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults setBool:aValue forKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (void)setURL:(nullable NSURL *)aURL forKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults setURL:aURL forKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (void)setObject:(nullable id)aValue forKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults setObject:aValue forKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (void)removeObjectForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      [stUserDefaults removeObjectForKey:aDefaultName];
      [stUserDefaults synchronize];
      
   } /* End if () */
   
   return;
}

+ (nullable id)objectForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   id              stObject         = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      stObject = [stUserDefaults objectForKey:aDefaultName];
      
   } /* End if () */
   
   return stObject;
}

+ (nullable NSString *)stringForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSString       *szValue          = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      szValue  = [stUserDefaults stringForKey:aDefaultName];
      
   } /* End if () */
   
   return szValue;
}

+ (nullable NSArray *)arrayForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSArray        *stValue          = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      stValue  = [stUserDefaults arrayForKey:aDefaultName];
      
   } /* End if () */
   
   return stValue;
}

+ (nullable NSDictionary<NSString *, id> *)dictionaryForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSDictionary<NSString *, id>  *stValue = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      stValue  = [stUserDefaults dictionaryForKey:aDefaultName];
      
   } /* End if () */
   
   return stValue;
}

+ (nullable NSData *)dataForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSData         *stValue          = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      stValue  = [stUserDefaults dataForKey:aDefaultName];
      
   } /* End if () */
   
   return stValue;
}

+ (nullable NSArray<NSString *> *)stringArrayForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSArray<NSString *>  *stValue    = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      stValue  = [stUserDefaults stringArrayForKey:aDefaultName];
      
   } /* End if () */
   
   return stValue;
}

+ (NSInteger)integerForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSInteger       nValue           = 0;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      nValue   = [stUserDefaults integerForKey:aDefaultName];
      
   } /* End if () */
   
   return nValue;
}

+ (float)floatForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   float           fValue           = 0.0f;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      fValue   = [stUserDefaults floatForKey:aDefaultName];
      
   } /* End if () */
   
   return fValue;
}

+ (double)doubleForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   double          dValue           = 0.0f;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      dValue   = [stUserDefaults doubleForKey:aDefaultName];
      
   } /* End if () */
   
   return dValue;
}

+ (BOOL)boolForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   BOOL            bValue           = NO;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      bValue   = [stUserDefaults boolForKey:aDefaultName];
      
   } /* End if () */
   
   return bValue;
}

+ (nullable NSURL *)URLForKey:(NSString *)aDefaultName withSuite:(NSString *)aSuite {
   
   NSURL          *stURL            = nil;
   NSUserDefaults *stUserDefaults   = [NSUserDefaults suite:aSuite];
   
   if (nil != stUserDefaults) {
      
      stURL = [stUserDefaults URLForKey:aDefaultName];
      
   } /* End if () */
   
   return stURL;
}

@end
