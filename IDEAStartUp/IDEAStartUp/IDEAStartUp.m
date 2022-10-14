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
   
   LogDebug((@"--[IDEAStartUp __constructor]"));
   
   return;
}

static __attribute__((destructor)) void __destructor() {

   LogDebug((@"--[IDEAStartUp __destructor]"));

   return;
}

@interface IDEAStartUp()

@end

@implementation IDEAStartUp

+ (void)startUp {
   
   __init();

   return;
}

+ (void)load {
   
   __init();

   return;
}

NS_INLINE void __init() {
   
   @synchronized (IDEAStartUp.class) {
      
      static dispatch_once_t onceToken;

      dispatch_once(&onceToken, ^(void) {
         
         _dyld_register_func_for_add_image(__dyld_callback);
      });

   } /* synchronized */
   
   return;
}

NS_INLINE void __dyld_callback(const struct mach_header *_mach_header, intptr_t _vmaddr_slide) {
   
   char           *psz_section_name = __STARTUP_KEY;
   unsigned long   ul_size          = 0;
#ifndef __LP64__
   uintptr_t      *pst_memory       = (uintptr_t*)getsectiondata(_mach_header, __STARTUP_SECTION_NAME, psz_section_name, &ul_size);
#else
   const struct mach_header_64   *mhp64 = (const struct mach_header_64 *)_mach_header;
   uintptr_t      *pst_memory       = (uintptr_t*)getsectiondata(mhp64, __STARTUP_SECTION_NAME, psz_section_name, &ul_size);
#endif
   
   unsigned long   ul_counter = ul_size / sizeof(St_StartUp);
   unsigned long   ul_offset  = sizeof(St_StartUp) / sizeof(void *);
   
   for (int H = 0; H < ul_counter; ++H) {
      
      St_StartUp st_start_up = *(St_StartUp*)(pst_memory + ul_offset * (H));
      
      if (st_start_up.key) {
         
         st_start_up.function();
         
      } /* End if () */
      
   } /* End if () */
   
   return;
}

@end
