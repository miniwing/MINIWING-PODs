//
//  IDEAEventBus.m
//  IDEAEventBus
//
//  Created by Harry on 2022/3/18.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventBus.h"

@interface IDEAEventBus ()

@end

@implementation IDEAEventBus

+ (instancetype)getDefault {
   
   static   IDEAEventBus      *g_EventBus = nil;
   static   dispatch_once_t    stOnceToken;
   
   dispatch_once(&stOnceToken, ^{
      
      g_EventBus  = [[IDEAEventBus alloc] __init];
   });
   
   return nil;
}

+ (instancetype)eventBusWithBuilder:(IDEAEventBusBuilder *)aBuilder {
      
   return [[IDEAEventBus alloc] __initWithBuilder:aBuilder];
}

- (void)dealloc {

   __LOG_FUNCTION;

   // Custom dealloc

   __SUPER_DEALLOC;

   return;
}

- (instancetype)__init {

   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super init];
   
   if (self) {
            
   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (instancetype)__initWithBuilder:(IDEAEventBusBuilder *)aBuider {

   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super init];
   
   if (self) {
            
   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

@end
