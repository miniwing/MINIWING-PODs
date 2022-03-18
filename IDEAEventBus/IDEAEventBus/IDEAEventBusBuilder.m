//
//  IDEAEventBusBuilder.m
//  IDEAEventBus
//
//  Created by Harry on 2022/3/18.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAEventBus.h"
#import "IDEAEventBusBuilder.h"

@interface IDEAEventBusBuilder ()

@end

@implementation IDEAEventBusBuilder

- (IDEAEventBus *)build {
   
   return [IDEAEventBus eventBusWithBuilder:self];
}

- (void)dealloc {

   __LOG_FUNCTION;

   // Custom dealloc

   __SUPER_DEALLOC;

   return;
}

- (instancetype)init {

   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super init];
   
   if (self) {
            
   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

@end
