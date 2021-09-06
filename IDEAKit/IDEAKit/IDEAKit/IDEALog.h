//
//  IDEALog.h
//  IDEAKit
//
//  Created by Harry on 14-6-29.
//  Copyright (c) 2014年 Harry. All rights reserved.
//
//  Mail:miniwing.hz@gmail.com
//  TEL :+(852)53054612


#ifndef IDEALog_H
#define IDEALog_H

#include <stdarg.h>

#include "IDEADef.h"

#define LOG_BUG_SIZE                                              (1024 * 1)

#ifdef __OBJC__

typedef NS_ENUM(NSInteger, LogLevel) {

   LogLevelFatal = 0,
   LogLevelError,
   LogLevelWarn,
   LogLevelInfo,
   LogLevelDebug
};

NS_INLINE const char* __LogLevelToString(LogLevel _eLevel) {
   
   switch (_eLevel)
   {
   case LogLevelFatal:
      return ("Fatal");
   case LogLevelError:
      return ("Error");
   case LogLevelWarn:
      return (" Warn");
   case LogLevelInfo:
      return (" Info");
   case LogLevelDebug:
      return ("Debug");
   default:
      break;
      
   } /* End switch (); */
   
   return ("Unknown");
}

NS_INLINE void __Log(LogLevel _eLevel, const NSString *_aMsg) {
   
   if (LOG_BUG_SIZE >= _aMsg.length) {
      
      printf("%s :: %s\n", __LogLevelToString(_eLevel), [_aMsg UTF8String]);
      
   }
   else {

      printf("####################################################################################\n");
      printf("%s :: ", __LogLevelToString(_eLevel));

      // 在数组范围内，则循环分段
      while (LOG_BUG_SIZE < _aMsg.length) {
         
         // 按字节长度截取字符串
         NSString *szSubStr   = [_aMsg substringToIndex:LOG_BUG_SIZE]; // cutStr(bytes, maxByteNum);
         
         // 打印日志
         printf("%s\n", [szSubStr UTF8String]);
         
         // 截取出尚未打印字节数组
         _aMsg = [_aMsg substringFromIndex:LOG_BUG_SIZE];
         
      } /* End while () */

      // 打印剩余部分
      printf("%s\n", [_aMsg UTF8String]);
      printf("####################################################################################\n");

   } /* End else */

//   printf("[%s] %s :: %s\n", MODULE, __LogLevelToString(_eLevel), _cpszMsg);
      
   return;
}

NS_INLINE void LoggerFatal(NSString *aFormat, ...) {
   
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   __Log(LogLevelFatal, szMSG);
   
   __RELEASE(szMSG);
   
   return;
}

NS_INLINE void LoggerError(NSString *aFormat, ...) {
   
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   __Log(LogLevelError, szMSG);
   
   __RELEASE(szMSG);
   
   return;
}

NS_INLINE void LoggerWarn(NSString *aFormat, ...) {
   
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   __Log(LogLevelWarn, szMSG);
   
   __RELEASE(szMSG);
   
   return;
}

NS_INLINE void LoggerInfo(NSString *aFormat, ...) {
   
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   __Log(LogLevelInfo, szMSG);
   
   __RELEASE(szMSG);
   
   return;
}

NS_INLINE void LoggerDebug(NSString *aFormat, ...) {
   
   va_list      args;
   NSString    *szMSG   = nil;
   
   va_start (args, aFormat);
   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
   va_end (args);
   
   __Log(LogLevelDebug, szMSG);
   
   __RELEASE(szMSG);
   
   return;
}

NS_INLINE void LoggerClass(Class aClass) {
   
   unsigned int    nMethodCount  = 0;
   Method         *stMethods     = class_copyMethodList(aClass, &nMethodCount);
   
   NSLog(@"  method");
   for (int H = 0; H< nMethodCount; H++) {
      
      NSLog(@"    method name = %@ type = %s", NSStringFromSelector(method_getName(stMethods[H])), method_getTypeEncoding(stMethods[H]));
      
   } /* End for () */
   NSLog(@"  method");
      
   return;
}

#else

__BEGIN_DECLS

static __inline void LoggerFatal(char *_Format, ...) {
   
   va_list      args;
   static char s_MSG[LOG_BUG_SIZE]  = {0};
   
   bzero(s_MSG, sizeof(s_MSG));
   
   va_start (args, _Format);
   vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
   va_end (args);
   
   printf("%s :: %s\n", "Fatal", s_MSG);
   
   return;
}

static __inline void LoggerError(char *_Format, ...) {
   
   va_list      args;
   static char s_MSG[LOG_BUG_SIZE]  = {0};
   
   bzero(s_MSG, sizeof(s_MSG));
   
   va_start (args, _Format);
   vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
   va_end (args);
   
   printf("%s :: %s\n", "Error", s_MSG);
   
   return;
}

static __inline void LoggerWarn(char *_Format, ...) {
   
   va_list      args;
   static char s_MSG[LOG_BUG_SIZE]  = {0};
   
   bzero(s_MSG, sizeof(s_MSG));
   
   va_start (args, _Format);
   vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
   va_end (args);
   
   printf("%s :: %s\n", "Warning", s_MSG);
   
   return;
}

static __inline void LoggerInfo(char *_Format, ...) {
   
   va_list      args;
   static char s_MSG[LOG_BUG_SIZE]  = {0};
   
   bzero(s_MSG, sizeof(s_MSG));
   
   va_start (args, _Format);
   vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
   va_end (args);
   
   printf("%s :: %s\n", "Info", s_MSG);
   
   return;
}

static __inline void LoggerDebug(char *_Format, ...) {
   
   va_list      args;
   static char s_MSG[LOG_BUG_SIZE]  = {0};
   
   bzero(s_MSG, sizeof(s_MSG));
   
   va_start (args, _Format);
   vsnprintf(s_MSG, sizeof(s_MSG), _Format, args);
   va_end (args);
   
   printf("%s :: %s\n", "Debug", s_MSG);
   
   return;
}

__END_DECLS

#endif /* !__OBJC__ */


#endif /* IDEALog_H */

