//
//  GitHub: https://github.com/iphone5solo/IDEASearch
//  Created by CoderKo1o.
//  Copyright © 2016 iphone5solo. All rights reserved.
//

#import "NSBundle+IDEASearchExtension.h"
#import "IDEASearchController.h"

@implementation NSBundle (IDEASearchExtension)

+ (NSBundle *)searchBundle {
   
   static NSBundle         *g_SEARCH_BUNDLE  = nil;
   static dispatch_once_t   oneToken;
   
   dispatch_once(&oneToken, ^{
      NSBundle *stBaseBundle  = [NSBundle bundleForClass:[IDEASearchController class]];
      //Default use `[NSBundle mainBundle]`.
      g_SEARCH_BUNDLE = [NSBundle bundleWithPath:[stBaseBundle pathForResource:@"IDEASearch" ofType:@"bundle"]];
   });
   
   return g_SEARCH_BUNDLE;
}

+ (NSString *)search_localizedStringForKey:(NSString *)key {
   
   return [self search_localizedStringForKey:key value:nil];
}

+ (NSString *)search_localizedStringForKey:(NSString *)aKey value:(NSString *)aValue {
   
   static NSBundle *stBundle = nil;
   
   if (nil == stBundle) {
      
      NSString *szLanguage = [NSLocale preferredLanguages].firstObject;
      
      if ([szLanguage hasPrefix:@"en"]) {
         
         szLanguage = @"en";
         
      } /* End if () */
      else if ([szLanguage hasPrefix:@"es"]) {
         
         szLanguage = @"es";
         
      } /* End else if () */
      else if ([szLanguage hasPrefix:@"fr"]) {
         
         szLanguage = @"fr";
         
      } /* End else if () */
      else if ([szLanguage hasPrefix:@"zh"]) {
         
         if ([szLanguage rangeOfString:@"Hans"].location != NSNotFound) {
            
            szLanguage = @"zh-Hans";
            
         } /* End if () */
         else {
            szLanguage = @"zh-Hant";
            
         } /* End else */
         
      } /* End else if () */
      else {
         szLanguage = @"en";
         
      } /* End else */
      
      // Find resources from `IDEASearch.bundle`
      stBundle = [NSBundle bundleWithPath:[[NSBundle searchBundle] pathForResource:szLanguage ofType:@"lproj"]];
      
   } /* End if () */
   LogDebug((@"-[NSBundle search_localizedStringForKey:] : %@", stBundle));
   
   aValue = [stBundle localizedStringForKey:aKey value:aValue table:nil];
   
   if (nil != aValue) {
      
      return aValue;
      
   } /* End if () */
   
   return [[NSBundle mainBundle] localizedStringForKey:aKey value:aValue table:nil];
}

+ (UIImage *)search_imageNamed:(NSString *)aName {
   
   //   CGFloat scale = [[UIScreen mainScreen] scale];
   //   aName = 3.0 == scale ? [NSString stringWithFormat:@"%@@3x.png", aName] : [NSString stringWithFormat:@"%@@2x.png", aName];
   //   UIImage *image = [UIImage imageWithContentsOfFile:[[[NSBundle searchBundle] resourcePath] stringByAppendingPathComponent:aName]];
   //   return image;
   NSBundle *stBundle   = [NSBundle searchBundle];
   
   return [UIImage imageNamed:aName inBundle:stBundle compatibleWithTraitCollection:nil];
}

@end
