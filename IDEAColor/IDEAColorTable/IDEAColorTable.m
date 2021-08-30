//
//  IDEAColorTable.m
//  IDEANightVersion
//
//  Created by Harry on 2021/3/2.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "IDEAColorTable.h"

#import <CoreText/CoreText.h>

@interface IDEAColorTable ()

//+ (void)loadFontFile:(NSString *)fontFileName ofType:(NSString *)type fromBundle:(NSString *)bundleName;

@end

static   NSString       *g_ColorTable        = nil;

@implementation IDEAColorTable

+ (void)load
{
   static   dispatch_once_t    stOnceToken;

   dispatch_once(&stOnceToken, ^{

      NSBundle   *stBundle = [NSBundle bundleForClass:[self class]];
      NSURL      *stURL    = [stBundle URLForResource:@"ColorTable" withExtension:@"txt"];

      g_ColorTable  = [stURL.path copy];
      
      [[DKColorTable sharedColorTable] setFile:g_ColorTable];
   });

   return;
}

//+ (NSString *)pathForColorTable:(NSString *)aColorTable
//                         ofType:(NSString *)aType
//                     fromBundle:(NSString *)aBundleName
//{
//   static   NSString          *g_COLOR_TABLE    = nil;
//   static   dispatch_once_t    stOnceToken;
//   
//   dispatch_once(&stOnceToken, ^{
//
////      NSURL      *stBundleURL = [[NSBundle bundleForClass:[self class]] URLForResource:aBundleName withExtension:@"bundle"];
//
////      NSURL      *stBundleURL = [NSBundle bundleForClass:[self class]];
//
//      NSBundle   *stBundle    = [NSBundle bundleForClass:[self class]];
//      
//      NSURL      *stFontURL   = [stBundle URLForResource:aColorTable withExtension:aType];
//
//      g_COLOR_TABLE  = stFontURL.path;
//      
//   });
//   
//   return g_COLOR_TABLE;
//}
//
//+ (NSString *)bundle
//{
//   return @"IDEANightVersion";
//}

@end
