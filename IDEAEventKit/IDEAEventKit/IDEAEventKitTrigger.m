//
//  IDEAEventKitTrigger.m
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventKit/IDEAEventKitTrigger.h"

#import "IDEAEventKit/NSObject+EventKit.h"
#import "IDEAEventKit/NSArray+EventKit.h"
#import "IDEAEventKit/NSMutableArray+EventKit.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation NSObject(Loader)

- (void)load {
   
   return;
}

- (void)unload {
   
   return;
}

- (void)performLoad {
   
   [self performCallChainWithPrefix:@"before_load" reversed:NO];
   [self performCallChainWithSelector:@selector(load) reversed:NO];
   [self performCallChainWithPrefix:@"after_load" reversed:NO];
   
   return;
}

- (void)performUnload {
   
   [self performCallChainWithPrefix:@"before_unload" reversed:YES];
   [self performCallChainWithSelector:@selector(unload) reversed:YES];
   [self performCallChainWithPrefix:@"after_unload" reversed:YES];
   
   return;
}

@end

#pragma mark -

@implementation NSObject(Trigger)

+ (void)performSelectorWithPrefix:(NSString *)aPrefixName {
   
   unsigned int    unMethodCount = 0;
   Method         *stMethodList  = class_copyMethodList(self, &unMethodCount);
   
   if (stMethodList && unMethodCount) {
      
      for (NSUInteger H = 0; H < unMethodCount; ++H) {
         
         SEL    stSEL   = method_getName(stMethodList[H]);
         
         const char  *cpcName    = sel_getName(stSEL);
         const char  *cpcPrefix  = [aPrefixName UTF8String];
         
         if (0 == strcmp(cpcPrefix, cpcName)) {
            
            continue;
            
         } /* End if () */
         
         if (0 == strncmp(cpcName, cpcPrefix, strlen(cpcPrefix))) {
            
            ImpFuncType stIMPL = (ImpFuncType)method_getImplementation(stMethodList[H]);
            
            if (stIMPL) {
               
               stIMPL(self, stSEL, nil);
               
            } /* End if () */
            
         } /* End if () */
         
      } /* End for () */
      
   } /* End if () */
   
   FREE_IF(stMethodList);
   
   return;
}

- (void)performSelectorWithPrefix:(NSString *)aPrefixName {
   
   unsigned int    unMethodCount = 0;
   Method         *stMethodList  = class_copyMethodList([self class], &unMethodCount);
   
   if (stMethodList && unMethodCount) {
      
      for (NSUInteger i = 0; i < unMethodCount; ++i) {
         
         SEL    stSEL   = method_getName(stMethodList[i]);
         
         const char *cpcName     = sel_getName(stSEL);
         const char *cpcPrefix   = [aPrefixName UTF8String];
         
         if (0 == strcmp(cpcPrefix, cpcName)) {
            
            continue;
            
         } /* End if () */
         
         if (0 == strncmp(cpcName, cpcPrefix, strlen(cpcPrefix))) {
            
            ImpFuncType stIMPL = (ImpFuncType)method_getImplementation(stMethodList[i]);
            if (stIMPL) {
               
               stIMPL(self, stSEL, nil);
               
            } /* End if () */
            
         } /* End if () */
         
      } /* End for () */
      
   } /* End if () */
   
   FREE_IF(stMethodList);
   
   return;
}

- (id)performCallChainWithSelector:(SEL)aSEL {
   
   return [self performCallChainWithSelector:aSEL reversed:NO];
}

- (id)performCallChainWithSelector:(SEL)aSEL reversed:(BOOL)aFlag {
   
   NSMutableArray *stClassStack  = [NSMutableArray nonRetainingArray];
   
   for (Class stThisClass = [self class]; nil != stThisClass; stThisClass = class_getSuperclass(stThisClass)) {
      
      if (aFlag) {
         
         [stClassStack addObject:stThisClass];
         
      } /* End if () */
      else {
         
         [stClassStack insertObject:stThisClass atIndex:0];
         
      } /* End if () */
      
   } /* End for () */
   
   ImpFuncType  stPrevImpl    = NULL;
   
   for (Class stThisClass in stClassStack) {
      
      Method    stMethod   = class_getInstanceMethod(stThisClass, aSEL);
      if (stMethod) {
         
         ImpFuncType stIMPL = (ImpFuncType)method_getImplementation(stMethod);
         
         if (stIMPL) {
            
            if (stIMPL == stPrevImpl) {
               
               continue;
               
            } /* End if () */
            
            stIMPL(self, aSEL, nil);
            
            stPrevImpl = stIMPL;
            
         } /* End if () */
         
      } /* End if () */
      
   } /* End for () */
   
   return self;
}

- (id)performCallChainWithPrefix:(NSString *)aPrefix {
   
   return [self performCallChainWithPrefix:aPrefix reversed:YES];
}

- (id)performCallChainWithPrefix:(NSString *)aPrefixName reversed:(BOOL)aFlag {
   
   NSMutableArray *stClassStack  = [NSMutableArray nonRetainingArray];
   
   for (Class stThisClass = [self class]; nil != stThisClass; stThisClass = class_getSuperclass(stThisClass)) {
      
      if (aFlag) {
         
         [stClassStack addObject:stThisClass];
         
      } /* End if () */
      else {
         
         [stClassStack insertObject:stThisClass atIndex:0];
         
      } /* End else */
      
   } /* End for () */
   
   for (Class stThisClass in stClassStack) {
      
      unsigned int    unMethodCount = 0;
      Method         *stMethodList  = class_copyMethodList(stThisClass, &unMethodCount);
      
      if (stMethodList && unMethodCount) {
         
         for (NSUInteger H = 0; H < unMethodCount; ++H) {
            
            SEL    stSEL   = method_getName(stMethodList[H]);
            
            const char  *cpcName    = sel_getName(stSEL);
            const char  *cpcPrefix  = [aPrefixName UTF8String];
            
            if (0 == strcmp(cpcPrefix, cpcName)) {
               
               continue;
               
            } /* End if () */
            
            if (0 == strncmp(cpcName, cpcPrefix, strlen(cpcPrefix))) {
               
               ImpFuncType stIMPL = (ImpFuncType)method_getImplementation(stMethodList[H]);
               if (stIMPL) {
                  
                  stIMPL(self, stSEL, nil);
                  
               } /* End if () */
               
            } /* End if () */
            
         } /* End for () */
         
      } /* End if () */
      
      FREE_IF(stMethodList);
      
   } /* End for () */
   
   return self;
}

- (id)performCallChainWithName:(NSString *)aName {
   
   return [self performCallChainWithName:aName reversed:NO];
}

- (id)performCallChainWithName:(NSString *)aName reversed:(BOOL)aFlag {
   
   SEL    stSelector = NSSelectorFromString(aName);
   if (stSelector) {
      
      NSString *szPrefix1  = [NSString stringWithFormat:@"before_%@", aName];
      NSString *szPrefix2  = [NSString stringWithFormat:@"after_%@", aName];
      
      [self performCallChainWithPrefix:szPrefix1 reversed:aFlag];
      [self performCallChainWithSelector:stSelector reversed:aFlag];
      [self performCallChainWithPrefix:szPrefix2 reversed:aFlag];
      
   } /* End if () */
   
   return self;
}

@end

// ----------------------------------
// Unit test
// ----------------------------------

#pragma mark -

#if __IDEA_EVENT_KIT_TESTING__

#endif // #if __IDEA_EVENT_KIT_TESTING__

#import "IDEAEventKit/__pragma_pop.h"
