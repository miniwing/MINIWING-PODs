//
//  IDEAIdentifier.m
//  IDEAKit
//
//  Created by Harry on 2019/9/30.
//  Copyright © 2019 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAIdentifier.h"

@implementation IDEAIdentifier

+ (NSString *)identifier {
   
//   static   NSString       *g_IDENTIFIER;
//   static   dispatch_once_t stOnceToken;
   
//   dispatch_once(&stOnceToken, ^{
//      g_IDENTIFIER         = [NSString stringWithUTF8String:APP_BUNDLE_IDENTIFIER];
//   });
   
   return @(APP_BUNDLE_IDENTIFIER);
}

+ (NSString *)identifierGroup {
   
//   static   NSString       *g_IDENTIFIER_GROUP;
//   static   dispatch_once_t stOnceToken;
//
//   dispatch_once(&stOnceToken, ^{
//      g_IDENTIFIER_GROUP   = [NSString stringWithUTF8String:APP_BUNDLE_IDENTIFIER_GROUP];
//   });

   return @(APP_BUNDLE_IDENTIFIER_GROUP);
}

+ (NSString *)identifierWidget {
   
//   static   NSString       *g_IDENTIFIER_WIDGET;
//   static   dispatch_once_t stOnceToken;
//
//   dispatch_once(&stOnceToken, ^{
//      g_IDENTIFIER_WIDGET  = [NSString stringWithUTF8String:APP_BUNDLE_IDENTIFIER_WIDGET];
//   });

   return @(APP_BUNDLE_IDENTIFIER_WIDGET);
}

+ (NSString *)scheme {
   
//   static   NSString       *g_SCHEME;
//   static   dispatch_once_t stOnceToken;
//
//   dispatch_once(&stOnceToken, ^{
//      g_SCHEME             = [NSString stringWithUTF8String:APP_SCHEME];
//   });

   return @(APP_SCHEME);
}

+ (NSString *)schemePrefix {
   
   NSURL *stURL   = [NSURL URLWithString:[IDEAIdentifier scheme]];
   
   return stURL.scheme;
}

+ (NSString *)appURL {
   
   static   NSString       *g_APP_URL;
   static   dispatch_once_t stOnceToken;
   
   dispatch_once(&stOnceToken, ^{
      
      g_APP_URL   = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%ld", APP_ID];
   });
   
   return g_APP_URL;
}

@end
