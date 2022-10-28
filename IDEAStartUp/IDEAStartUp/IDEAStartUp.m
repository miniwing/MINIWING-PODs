//
//  IDEADisposeBag.m
//  IDEAEventBus
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>
#include <objc/runtime.h>
#include <objc/message.h>
#include <mach-o/ldsyms.h>

#import "IDEAStartUp.h"

static __attribute__((constructor)) void __constructor() {
   
   LogDebug((@"IDEAStartUp::__constructor"));
   
   return;
}

static __attribute__((destructor)) void __destructor() {

   LogDebug((@"IDEAStartUp::__destructor"));

   return;
}

@implementation IDEAStartUp

+ (void)startUp {
   
   __init();

   return;
}

//+ (void)load {
//   
////   __init();
//
//   return;
//}

//static dispatch_once_t   onceToken;
//static IDEAStartUp      *g_INSTANCE = nil;

NS_INLINE void __init() {
   
   LogDebug((@"IDEAStartUp::__init"));

   @try {
      
      @synchronized (IDEAStartUp.class) {
         
         static dispatch_once_t   onceToken;
         dispatch_once(&onceToken, ^(void) {
            
//            g_INSTANCE  = (IDEAStartUp *)objc_getAssociatedObject([NSUserDefaults standardUserDefaults],
//                                                                     (__bridge const void *)([NSUserDefaults standardUserDefaults]) + 0x01);
//
//            if (nil == g_INSTANCE) {
//
//               g_INSTANCE = [[IDEAStartUp alloc] init];
//               LogDebug((@"+[IDEAStartUp sharedInstance] : INSTANCE : %@", g_INSTANCE));
//
//               objc_setAssociatedObject([NSUserDefaults standardUserDefaults],
//                                        (__bridge const void *)([NSUserDefaults standardUserDefaults]) + 0x01,
//                                        g_INSTANCE,
//                                        OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//               _dyld_register_func_for_add_image(__dyld_callback);
//
//            } /* End if () */

            _dyld_register_func_for_add_image(__dyld_callback);
            
            return;
         });

      } /* synchronized */

   } /* End try */
   @catch (NSException *_Exception) {
      
      LogError((@"IDEAStartUp::__init : NSException : %@", _Exception));

   } /* End catch (NSException) */
   
   return;
}

NS_INLINE void __dyld_callback(const struct mach_header *_mach_header, intptr_t _vmaddr_slide) {
   
   char           *psz_section_name = __STARTUP_KEY;
   unsigned long   ul_size          = 0;
#ifndef __LP64__
   uintptr_t      *pst_memory       = (uintptr_t*)getsectiondata(_mach_header, __STARTUP_SECTION_NAME, psz_section_name, &ul_size);
#else
   const struct mach_header_64   *mhp64 = (const struct mach_header_64 *)_mach_header;
   uintptr_t      *pst_memory       = (uintptr_t *)getsectiondata(mhp64, __STARTUP_SECTION_NAME, psz_section_name, &ul_size);
#endif

   if (0 == ul_size) {
      
      return;
   }

   unsigned long   ul_counter = ul_size / sizeof(St_StartUp);
   LogDebug((@"IDEAStartUp::__dyld_callback : ul_size : %d", ul_size));
   LogDebug((@"IDEAStartUp::__dyld_callback : ul_counter : %d", ul_counter));

   unsigned long   ul_offset  = sizeof(St_StartUp) / sizeof(St_StartUp *);
//   unsigned long   ul_offset  = sizeof(St_StartUp *);
//   LogDebug((@"IDEAStartUp::__dyld_callback : ul_offset : %d", ul_offset));

   for (int H = 0; H < ul_counter; ++H) {
      
      St_StartUp st_start_up = *(St_StartUp*)(pst_memory + ul_offset * H);
      
      LogDebug((@"IDEAStartUp::__dyld_callback : St_StartUp KEY : %s", st_start_up.key));

      if (NULL != st_start_up.key && !strcmp(__STARTUP_KEY, st_start_up.key) && NULL != st_start_up.function) {
         
         st_start_up.function();
         
      } /* End if () */
      
   } /* End if () */
   
   return;
}

NS_INLINE void __dyld_callback_ex(const struct mach_header *_mach_header, intptr_t _vmaddr_slide) {
   
   char           *psz_section_name = __STARTUP_KEY;
   unsigned long   ul_size          = 0;
#ifndef __LP64__
   uintptr_t      *pst_memory       = (uintptr_t*)getsectiondata(_mach_header, __STARTUP_SECTION_NAME, psz_section_name, &ul_size);
#else
   const struct mach_header_64   *mhp64 = (const struct mach_header_64 *)_mach_header;
   uintptr_t      *pst_memory       = (uintptr_t*)getsectiondata(mhp64, __STARTUP_SECTION_NAME, psz_section_name, &ul_size);
#endif
   
   unsigned long   ul_counter = ul_size / sizeof(St_StartUp);
   unsigned long   ul_offset  = sizeof(St_StartUp) / sizeof(St_StartUp *);
   
   for (int H = 0; H < ul_counter; ++H) {
      
//      St_StartUp st_start_up = *(St_StartUp *)(pst_memory + ul_offset * (H));
      St_StartUp *pst_start_up = (pst_memory + H);

      LogDebug((@"IDEAStartUp::__dyld_callback : St_StartUp : %p", pst_start_up));

      if (NULL != pst_start_up && pst_start_up->key) {

         LogDebug((@"IDEAStartUp::__dyld_callback : St_StartUp : %s", pst_start_up->key));

         pst_start_up->function();
         
      } /* End if () */
      
   } /* End if () */
   
   return;
}

@end
