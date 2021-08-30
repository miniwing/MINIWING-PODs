//
//  UncaughtExceptionHandler.m
//  UncaughtExceptionHandler
//
//  Created by chuzhaozhi on 2018/6/4.
//  Copyright © 2018年 JackerooChu. All rights reserved.
//

#import "UncaughtExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

NSString * const UncaughtExceptionHandlerSignalExceptionName   = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey             = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey          = @"UncaughtExceptionHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount   = 0;
const    int32_t UncaughtExceptionMaximum = 10;

static BOOL showAlertView = NO;

NS_INLINE void HandleException(NSException *exception);
NS_INLINE void SignalHandler(int signal);

NS_INLINE NSString * getAppInfo(void);

@interface UncaughtExceptionHandler()

@property (nonatomic, assign)             BOOL                                  dismissed;

@end

@implementation UncaughtExceptionHandler
/*
 *  异常的处理方法
 *
 *  @param install   是否开启捕获异常
 *  @param showAlert 是否在发生异常时弹出alertView
 */
+ (void)installUncaughtExceptionHandler:(BOOL)aInstall showAlert:(BOOL)aShowAlert {
   
   if (aInstall && aShowAlert) {
      
      [[self alloc] alertView:aShowAlert];
      
   } /* End if () */
   
   NSSetUncaughtExceptionHandler(aInstall ? HandleException : NULL);
   
   // abort()
   signal(SIGABRT, aInstall ? SignalHandler : SIG_DFL);
   
   // illegal instruction (not reset when caught)
   // 非法指令
   signal(SIGILL,  aInstall ? SignalHandler : SIG_DFL);
   
   // segmentation violation
   // 段错误
   signal(SIGSEGV, aInstall ? SignalHandler : SIG_DFL);
   
   // floating point exception
   // 浮点异常 ==> 除数为 0
   signal(SIGFPE,  aInstall ? SignalHandler : SIG_DFL);
   
   // bus error
   // 总线错误
   signal(SIGBUS,  aInstall ? SignalHandler : SIG_DFL);
   
   // write on a pipe with no one to read it
   signal(SIGPIPE, aInstall ? SignalHandler : SIG_DFL);
   
   return;
}

- (void)alertView:(BOOL)show {
   
   showAlertView = show;
   
   return;
}

//获取调用堆栈
+ (NSArray *)backtrace {
   
   //指针列表
   void     *callstack[128]      = {0};
   
   //backtrace用来获取当前线程的调用堆栈，获取的信息存放在这里的callstack中
   //128用来指定当前的buffer中可以保存多少个void*元素
   //返回值是实际获取的指针个数
   int frames = backtrace(callstack, 128);
   //backtrace_symbols将从backtrace函数获取的信息转化为一个字符串数组
   //返回一个指向字符串数组的指针
   //每个字符串包含了一个相对于callstack中对应元素的可打印信息，包括函数名、偏移地址、实际返回地址
   char **strs = backtrace_symbols(callstack, frames);
   
   NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
   
   for (int H = 0; H < frames; H++) {
      
      [backtrace addObject:[NSString stringWithUTF8String:strs[H]]];
      
   } /* End for () */
   
   free(strs);
   
   return backtrace;
}

//点击退出
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)aAlertView clickedButtonAtIndex:(NSInteger)aIndex {
   
   if (aIndex == 0) {
      
      self.dismissed = YES;
      
   } /* End if () */
   
   return;
}
#pragma clang diagnostic pop

//处理报错信息
- (void)validateAndSaveCriticalApplicationData:(NSException *)exception {
   
   NSString *exceptionInfo = [NSString stringWithFormat:@"\n--------Log Exception---------\nappInfo             :\n%@\n\nexception name      :%@\nexception reason    :%@\nexception userInfo  :%@\ncallStackSymbols    :%@\n\n--------End Log Exception-----", getAppInfo(),exception.name, exception.reason, exception.userInfo ? : @"no user info", [exception callStackSymbols]];
   
   NSLog(@"%@", exceptionInfo);
   //   [exceptionInfo writeToFile:[NSString stringWithFormat:@"%@/Documents/error.log",NSHomeDirectory()]  atomically:YES encoding:NSUTF8StringEncoding error:nil];
   
   return;
}

- (void)handleException:(NSException *)aException {
   
   [self validateAndSaveCriticalApplicationData:aException];
   
   if (!showAlertView) {
      
      return;
      
   } /* End if () */
   
#if 0
#  pragma clang diagnostic push
#  pragma clang diagnostic ignored "-Wdeprecated-declarations"
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错啦"
                                                   message:[NSString stringWithFormat:@"你可以尝试继续操作，但是应用可能无法正常运行.\n"]
                                                  delegate:self
                                         cancelButtonTitle:@"退出"
                                         otherButtonTitles:@"继续", nil];
   
   //   [alert show];
#  pragma clang diagnostic pop
#endif
   
   UIAlertController *stAlertController   = [UIAlertController alertControllerWithTitle:@"出错啦"
                                                                                message:[NSString stringWithFormat:@"你可以尝试继续操作，但是应用可能无法正常运行.\n"]
                                                                         preferredStyle:UIAlertControllerStyleAlert];
   
   UIAlertAction     *stCancelAction      = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *aAction) {
      NSLog(@"@@~ 点击了“确认”按钮 ~@@");
      self.dismissed = YES;
   }];
   
   UIAlertAction     *stContinueAction    = [UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction *aAction) {
      NSLog(@"@@~ 点击了“确认”按钮 ~@@");
   }];
   
   [stAlertController addAction:stCancelAction];
   [stAlertController addAction:stContinueAction];
   
   if ([UIApplication respondsToSelector:@selector(sharedApplication)]) {
      
      UIApplication  *stApplication = [UIApplication performSelector:@selector(sharedApplication)];
      
      [stApplication.delegate.window.rootViewController presentViewController:stAlertController animated:YES completion:nil];
      
   } /* End if () */
   
   CFRunLoopRef runLoop = CFRunLoopGetCurrent();
   CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
   
   while (!self.dismissed) {
      
      //点击继续
      for (NSString *mode in (__bridge NSArray *)allModes) {
         
         //快速切换Mode
         CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
         
      } /* End for () */
      
   } /* End while () */
   
   //点击退出
   CFRelease(allModes);
   
   NSSetUncaughtExceptionHandler(NULL);
   signal(SIGABRT, SIG_DFL);
   signal(SIGILL, SIG_DFL);
   signal(SIGSEGV, SIG_DFL);
   signal(SIGFPE, SIG_DFL);
   signal(SIGBUS, SIG_DFL);
   signal(SIGPIPE, SIG_DFL);
   
   if ([[aException name] isEqual:UncaughtExceptionHandlerSignalExceptionName]) {
      
      kill(getpid(), [[[aException userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
      
   } /* End if () */
   else {
      
      [aException raise];
      
   } /* End else */
   
   return;
}

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

void HandleException(NSException *aException) {
   
   int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
   
   // 如果太多不用处理
   if (exceptionCount > UncaughtExceptionMaximum) {
      
      return;
      
   } /* End if () */
   
   //获取调用堆栈
   NSArray *callStack = [aException callStackSymbols];
   NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[aException userInfo]];
   [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];
   
   //在主线程中，执行制定的方法, withObject是执行方法传入的参数
   [[[UncaughtExceptionHandler alloc] init] performSelectorOnMainThread:@selector(handleException:)
                                                             withObject:[NSException exceptionWithName:[aException name]
                                                                                                reason:[aException reason]
                                                                                              userInfo:userInfo]
                                                          waitUntilDone:YES];
   
   return;
}

#pragma clang diagnostic push

//处理signal报错
void SignalHandler(int signal) {
   
   int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
   
   // 如果太多不用处理
   if (exceptionCount > UncaughtExceptionMaximum) {
      
      return;
      
   } /* End if () */
   
   NSString* description = nil;
   switch (signal) {
      
   case SIGABRT:
      description = [NSString stringWithFormat:@"Signal SIGABRT was raised!\n"];
      break;
   case SIGILL:
      description = [NSString stringWithFormat:@"Signal SIGILL was raised!\n"];
      break;
   case SIGSEGV:
      description = [NSString stringWithFormat:@"Signal SIGSEGV was raised!\n"];
      break;
   case SIGFPE:
      description = [NSString stringWithFormat:@"Signal SIGFPE was raised!\n"];
      break;
   case SIGBUS:
      description = [NSString stringWithFormat:@"Signal SIGBUS was raised!\n"];
      break;
   case SIGPIPE:
      description = [NSString stringWithFormat:@"Signal SIGPIPE was raised!\n"];
      break;
   default:
      description = [NSString stringWithFormat:@"Signal %d was raised!",signal];
      
   } /* End switch () */
   
   NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
   NSArray *callStack = [UncaughtExceptionHandler backtrace];
   [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];
   [userInfo setObject:[NSNumber numberWithInt:signal] forKey:UncaughtExceptionHandlerSignalKey];
   
   //在主线程中，执行指定的方法, withObject是执行方法传入的参数
   [[[UncaughtExceptionHandler alloc] init] performSelectorOnMainThread:@selector(handleException:)
                                                             withObject:[NSException exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
                                                                                                reason: description
                                                                                              userInfo: userInfo]
                                                          waitUntilDone:YES];
   
   return;
}

NSString* getAppInfo() {
   
   NSString *appInfo = [NSString stringWithFormat:@"App : %@ %@(%@)\nDevice : %@\nOS Version : %@ %@\n",
                        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                        [UIDevice currentDevice].model,
                        [UIDevice currentDevice].systemName,
                        [UIDevice currentDevice].systemVersion];
   return appInfo;
}


