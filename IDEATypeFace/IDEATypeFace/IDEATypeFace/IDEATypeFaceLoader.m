//
//  IDEATypeFaceLoader.m
//  IDEATypeFace
//
//  Created by Harry on 2021/3/2.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "IDEATypeFace/IDEATypeFaceLoader.h"

#import <CoreText/CoreText.h>

@interface IDEATypeFaceLoader ()

//+ (void)loadFontFile:(NSString *)fontFileName ofType:(NSString *)type fromBundle:(NSString *)bundleName;

@end

@implementation IDEATypeFaceLoader

+ (void)loadFontFile:(NSString *)aFontFileName ofType:(NSString *)aType fromBundle:(NSString *)aBundleName {
   
   static   NSCache           *g_FONT_CACHE;
   static   dispatch_once_t    stOnceToken;
   dispatch_once(&stOnceToken, ^ (void) {
      
      g_FONT_CACHE   = [[NSCache alloc] init];
   });
   
   NSURL *stBundleURL      = [g_FONT_CACHE objectForKey:aFontFileName];
   
   if (nil == stBundleURL) {
      
      stBundleURL = [[NSBundle bundleForClass:[self class]] URLForResource:aBundleName withExtension:@"bundle"];
      
      NSBundle *stBundle   = [NSBundle bundleWithURL:stBundleURL];
      NSURL    *stFontURL  = [stBundle URLForResource:aFontFileName withExtension:aType];
      NSData   *stFontData = [NSData dataWithContentsOfURL:stFontURL];
      
      CGDataProviderRef  stProviderRef = CGDataProviderCreateWithCFData((CFDataRef)stFontData);
      CGFontRef          stFontRef     = CGFontCreateWithDataProvider(stProviderRef);
      
      if (stFontRef) {
         
         CFErrorRef      stErrorRef    = NULL;
         if (NO == CTFontManagerRegisterGraphicsFont(stFontRef, &stErrorRef)) {
            
            CFStringRef  szErrorDescriptionRef  = CFErrorCopyDescription(stErrorRef);
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:(__bridge NSString *)szErrorDescriptionRef
                                         userInfo:@{ NSUnderlyingErrorKey: (__bridge NSError *)stErrorRef }];
            
         } /* End if () */
         
         CFRelease(stFontRef);
         
         if (nil != stBundleURL) {
            
            [g_FONT_CACHE setObject:stBundleURL forKey:aFontFileName];
            
         } /* End if () */
         
      } /* End if () */
      
      CFRelease(stProviderRef);
      
   } /* End if () */
   
   return;
}

+ (void)loadFontFile:(NSString *)fontFileName
              ofType:(NSString *)type
          fromBundle:(NSString *)bundleName
           onceToken:(dispatch_once_t *)onceToken {
   
   dispatch_once(onceToken, ^(void) {
      
      [self loadFontFile:fontFileName ofType:type fromBundle:bundleName];
   });
   
   return;
}

//+ (NSString *)bundle {
//   
//   return @"IDEAFONT";
//}

@end
