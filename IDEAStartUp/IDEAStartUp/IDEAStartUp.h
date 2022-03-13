//
//  IDEAStartUp.h
//  IDEAStartUp
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2017 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct __StartUp {
   
   char * _Nonnull key;
   void (* _Nonnull function)(void);
   
} St_StartUp;

#define __STARTUP_SECTION_NAME   "__STARTUP"
#define __STARTUP_KEY            "__main"

#define __STARTUP(key)           \
                                 static void __startup_##key(void); \
                                 __attribute__((used, section("__STARTUP," ""#key""))) \
                                 static const St_StartUp __fn_##key = (St_StartUp){(char *)(&#key), (void *)(&__startup_##key)}; \
                                 static void __startup_##key() \

#define IDEA_MAIN()              __STARTUP(__main)

@interface IDEAStartUp : NSObject

+ (void)starUp;

@end
