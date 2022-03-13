//
//  IDEAServiceManager.m
//  IDEAServiceManager
//
//  Created by limboy on 12/9/14.
//  Copyright (c) 2014 juangua. All rights reserved.
//

#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>
#include <objc/runtime.h>
#include <objc/message.h>
#include <mach-o/ldsyms.h>

#import "IDEAServiceManager/IDEAServiceManager.h"

@interface IDEAServiceManager()
{
   dispatch_semaphore_t _lock;
}

//@property (nonatomic, assign)                dispatch_semaphore_t                  lock;
@property (nonatomic, strong)                NSMutableDictionary                 * services;

@end

@implementation IDEAServiceManager

static dispatch_once_t      g_stOnceToken;

+ (void)install
{
   dispatch_once(&g_stOnceToken, ^(void)
                 {
      __init();
   });
   
   return;
}

+ (void)load
{
   dispatch_once(&g_stOnceToken, ^(void)
                 {
      __init();
   });
   
   return;
}

NS_INLINE void __init()
{
   _dyld_register_func_for_add_image(__dyld_callback);
}

NS_INLINE void __dyld_callback(const struct mach_header *mhp, intptr_t vmaddr_slide)
{
   //get services
   NSArray<NSString *>  *st_services   = __services_from_seg_data(__SERVICE_SECTION_NAME, mhp);
   
   for (NSString *sz_service in st_services)
   {
      NSData   *st_json_service  =  [sz_service dataUsingEncoding:NSUTF8StringEncoding];
      NSError  *st_error         = nil;
      
      id pv_json = [NSJSONSerialization JSONObjectWithData:st_json_service options:0 error:&st_error];
      
      if (!st_error)
      {
         if ([pv_json isKindOfClass:[NSDictionary class]] && [pv_json allKeys].count)
         {
            NSString *sz_protocol= [pv_json allKeys][0];
            NSString *sz_class   = [pv_json allValues][0];
            
            if (sz_protocol && sz_class)
            {
               [[IDEAServiceManager sharedManager] registerService:NSProtocolFromString(sz_protocol)
                                                         implClass:NSClassFromString(sz_class)];
               
            } /* End if () */
            
         } /* End if () */
         
      } /* End if () */
      
   } /* End for () */
   
   return;
}

NS_INLINE NSArray<NSString *> * __services_from_seg_data(char *section_name,const struct mach_header *mhp)
{
   NSMutableArray *st_services   = [NSMutableArray array];
   unsigned long   ul_size       = 0;
#ifndef __LP64__
   uintptr_t      *pst_memory = (uintptr_t*)getsectiondata(mhp, SEG_DATA, sectionName, &size);
#else
   const struct mach_header_64 *mhp64  = (const struct mach_header_64 *)mhp;
   uintptr_t      *pst_memory = (uintptr_t*)getsectiondata(mhp64, SEG_DATA, section_name, &ul_size);
#endif
   
   unsigned long ul_counter = ul_size/sizeof(void*);
   
   for (int H = 0; H < ul_counter; ++H)
   {
      char     *pc_name = (char*)pst_memory[H];
      NSString *sz_name = [NSString stringWithUTF8String:pc_name];
      if(!sz_name)
      {
         continue;
         
      } /* End if () */
      
      [st_services addObject:sz_name];
      
   } /* End for () */
   
   return st_services;
}

+ (instancetype)sharedManager
{
   static IDEAServiceManager  *g_Manager  = nil;
   static dispatch_once_t      onceToken;
   dispatch_once(&onceToken, ^
                 {
      g_Manager = [[IDEAServiceManager alloc] init];
   });
   
   return g_Manager;
}

- (instancetype)init
{
   self  = [super init];
   
   if (self)
   {
      _services   = [NSMutableDictionary dictionary];
      _lock       = dispatch_semaphore_create(1);
      
   } /* End if () */
   
   return self;
}

- (void)safeCall:(void(^)(void))aBlock
{
   if (NULL != aBlock)
   {
//      @synchronized (self)
//      {
//         aBlock();
//
//      } /* synchronized */
      
      dispatch_semaphore_wait(_lock, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC));
      aBlock();
      dispatch_semaphore_signal(_lock);

   } /* End if () */
   
   return;
}

- (BOOL)registerService:(Protocol *)aService implClass:(Class)aClass
{
   int                            nErr                                     = EFAULT;
   
   NSString                      *szService                                = NSStringFromProtocol(aService);
   NSString                      *szClass                                  = NSStringFromClass(aClass);
   __block BOOL                   bOK                                      = NO;
   
   __TRY;
   
   if (!szService || !szService.length || !szClass || !szClass.length)
   {
      break;
      
   } /* End if () */
   
   LogDebug((@"IDEAServiceManager::registerService : Service : %@ : %@", aClass, self));

   @weakify(self);
   [self safeCall:^(void)
    {
      @strongify(self);
      if (self.services[szService])
      {
         bOK = NO;
         
      } /* End if () */
      else
      {
         [self.services setObject:szClass forKey:szService];
         bOK = YES;
         
      } /* End else */
   }];
   
   __CATCH(nErr);
   
   return bOK;
}

- (id)createService:(Protocol *)service
{
   int                            nErr                                     = EFAULT;

   __block NSObject              *stInstanse                               = nil;;
   NSString                      *szService                                = NSStringFromProtocol(service);

   __TRY;
   
   if (!szService || !szService.length)
   {
      break;
      
   } /* End if () */
   
   @weakify(self);
   [self safeCall:^(void)
    {
      @strongify(self);
      NSString *szClass = self.services[szService];
      if (nil != szClass && szClass.length)
      {
         Class  stClass = NSClassFromString(szClass);
         
         if ([stClass respondsToSelector:@selector(sharedInstance)])
         {
            stInstanse = [stClass sharedInstance];
            
         } /* End if () */

         if (!stInstanse)
         {
            stInstanse = [[stClass alloc] init];
            
         } /* End if () */
         
      } /* End if () */
   }];
   
   __CATCH(nErr);
   
   return stInstanse;
}
   
@end
