//
//  IDEALog.m
//  IDEAKit
//
//  Created by Harry on 14-6-29.
//  Copyright (c) 2014年 Harry. All rights reserved.
//


#include  <sys/time.h>

#include "IDEALog.h"

//NS_INLINE const char* __LogLevelToString(__LogLevel _eLevel)
//{
//   switch (_eLevel)
//   {
//      case LogLevelFatal:
//         return ("Fatal");
//      case LogLevelError:
//         return ("Error");
//      case LogLevelWarn:
//         return (" Warn");
//      case LogLevelInfo:
//         return (" Info");
//      case LogLevelDebug:
//         return ("Debug");
//      default:
//         break;
//         
//   } /* End switch (); */
//   
//   return ("Unknown");
//}
//
//
//
//NS_INLINE void __Log(__LogLevel _eLevel, const char *_cpszMsg)
//{
//   printf("%s :: %s\n", __LogLevelToString(_eLevel), _cpszMsg);
//   
//   return;
//}
//
//
//
//void LoggerFatal(NSString *aFormat, ...)
//{
//   va_list      args;
//   NSString    *szMSG   = nil;
//   
//   va_start (args, aFormat);
//   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
//   va_end (args);
//   
//   __Log(__LogLevelFatal, [szMSG UTF8String]);
//
//   __RELEASE(szMSG);
//
//   return;
//}
//
//
//
//
//void LoggerError(NSString *aFormat, ...)
//{
//   va_list      args;
//   NSString    *szMSG   = nil;
//   
//   va_start (args, aFormat);
//   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
//   va_end (args);
//   
//   __Log(__LogLevelError, [szMSG UTF8String]);
//
//   __RELEASE(szMSG);
//
//   return;
//}
//
//void LoggerWarn(NSString *aFormat, ...)
//{
//   va_list      args;
//   NSString    *szMSG   = nil;
//   
//   va_start (args, aFormat);
//   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
//   va_end (args);
//   
//   __Log(__LogLevelWarn, [szMSG UTF8String]);
//
//   __RELEASE(szMSG);
//
//   return;
//}
//
//void LoggerInfo(NSString *aFormat, ...)
//{
//   va_list      args;
//   NSString    *szMSG   = nil;
//   
//   va_start (args, aFormat);
//   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
//   va_end (args);
//   
//   __Log(__LogLevelInfo, [szMSG UTF8String]);
//
//   __RELEASE(szMSG);
//
//   return;
//}
//
//
//void LoggerDebug(NSString *aFormat, ...)
//{
//   va_list      args;
//   NSString    *szMSG   = nil;
//   
//   va_start (args, aFormat);
//   szMSG = [[NSString alloc] initWithFormat:aFormat  arguments:args];
//   va_end (args);
//   
//   __Log(__LogLevelDebug, [szMSG UTF8String]);
//   
//   __RELEASE(szMSG);
//   
//   return;
//}


