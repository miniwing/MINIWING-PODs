//
//  IDEAStartUp.h
//  IDEAStartUp
//
//  Created by Harry on 2017/8/2.
//  Copyright © 2024 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

__BEGIN_DECLS

typedef void * (FUNC_TYPE)(void);

typedef struct __StartUp {
   
   char        * _Nonnull key;
//   void * (* _Nonnull function)(void);
   FUNC_TYPE   * _Nonnull function;

} St_StartUp;

#define __STARTUP_SECTION_NAME   "__STARTUP"
#define __STARTUP_KEY            "__main"

//static const St_StartUp __fn_##key = (St_StartUp){(char *)(&#key), (void *)(&__startup_##key)}; \

#define __STARTUP(key)           \
                                 static void __startup_##key(void); \
                                 __attribute__((used, section("__STARTUP," ""#key""))) \
                                 static const St_StartUp __fn_##key = (St_StartUp){(char *)(&#key), (FUNC_TYPE *)(&__startup_##key)}; \
                                 static void __startup_##key() \

#define IDEA_MAIN()              __STARTUP(__main)

__END_DECLS

NS_ASSUME_NONNULL_BEGIN

//@interface IDEAStartUp : NSObject
//
//@end

NS_ASSUME_NONNULL_END
