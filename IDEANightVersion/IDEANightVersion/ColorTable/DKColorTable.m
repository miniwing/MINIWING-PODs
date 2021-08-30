//
//  DKColorTable.m
//  DKNightVersion
//
//  Created by Draveness on 15/12/11.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "DKColorTable.h"

#if __has_include("IDEANightVersion/IDEAColorTable.h")
#     import "IDEANightVersion/IDEAColorTable.h"
#endif

@interface NSString (Trimming)

@end

@implementation NSString (Trimming)

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)aCharacterSet {
   
   NSUInteger   nLocation              = 0;
   NSUInteger   nLength                = [self length];
   unichar      awCharBuffer[nLength];
   
   bzero(awCharBuffer, sizeof(awCharBuffer));
   
   [self getCharacters:awCharBuffer];
   
   for (; nLength > 0; nLength--) {
      
      if (![aCharacterSet characterIsMember:awCharBuffer[nLength - 1]]) {
         
         break;
      }
   }
   
   return [self substringWithRange:NSMakeRange(nLocation, nLength - nLocation)];
}

@end

@interface DKColorTable ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, UIColor *> *> *table;

@property (nonatomic, strong, readwrite) NSArray<DKThemeVersion *> *themes;

@end

@implementation DKColorTable

UIColor *DKColorFromRGB(NSUInteger aHex) {
   
   return [UIColor colorWithRed:((CGFloat)((aHex >> 16) & 0xFF)/255.0) green:((CGFloat)((aHex >> 8) & 0xFF)/255.0) blue:((CGFloat)(aHex & 0xFF)/255.0) alpha:1.0];
}

UIColor *DKColorFromRGBA(NSUInteger aHex) {
   
   return [UIColor colorWithRed:((CGFloat)((aHex >> 24) & 0xFF)/255.0) green:((CGFloat)((aHex >> 16) & 0xFF)/255.0) blue:((CGFloat)((aHex >> 8) & 0xFF)/255.0) alpha:((CGFloat)(aHex & 0xFF)/255.0)];
}

+ (instancetype)sharedColorTable {
   
   static DKColorTable     *sharedInstance   = nil;
   static dispatch_once_t   oncePredicate;
   
   dispatch_once(&oncePredicate, ^{
      
      sharedInstance = [[DKColorTable alloc] init];
      
#if __has_include("IDEANightVersion/IDEAColorTable.h")
      sharedInstance.file = [IDEAColorTable pathForColorTable:@"ColorTable"
                                                       ofType:@"txt"
                                                   fromBundle:IDEAColorTable.bundle];
#else
      sharedInstance.file = @"ColorTable.txt";
#endif
   });
   
   return sharedInstance;
}

- (void)reloadColorTable {
   
   // Clear previos color table
   self.table  = nil;
   self.themes = nil;
   
   NSString    *szFilePath = szFilePath = self.file;
   
// Load color table file
//#if __has_include("IDEANightVersion/IDEAColorTable.h")
//   szFilePath  = self.file;
//#else
//   szFilePath  = [[NSBundle mainBundle] pathForResource:self.file.stringByDeletingPathExtension ofType:self.file.pathExtension];
//#endif

//   if (stURL.isFileURL)
//   {
//      szFilePath = self.file;
//
//   } /* End if () */
//   else
//   {
//      szFilePath  = [[NSBundle mainBundle] pathForResource:self.file.stringByDeletingPathExtension ofType:self.file.pathExtension];
//
//   } /* End if () */
   
   NSError  *stError    = nil;
   
   NSString *szContents = [NSString stringWithContentsOfFile:szFilePath
                                                    encoding:NSUTF8StringEncoding
                                                       error:&stError];
   
   if (stError || nil == szContents) {
      
      LogError((@"Error reading file: %@", stError.localizedDescription));

      szFilePath  = [[NSBundle mainBundle] pathForResource:self.file.stringByDeletingPathExtension ofType:self.file.pathExtension];
      
      szContents = [NSString stringWithContentsOfFile:szFilePath
                                             encoding:NSUTF8StringEncoding
                                                error:&stError];
      
   } /* End if () */
   
   if (stError || nil == szContents) {
      
      LogError((@"Error reading file: %@", stError.localizedDescription));

      return;
      
   } /* End if () */
   
//#ifdef DEBUG
//   LogDebug((@"DKColorTable:\n%@", szContents));
//#endif /* DEBUG */
   
   NSMutableArray *stTempEntries = [[szContents componentsSeparatedByString:@"\n"] mutableCopy];
   
   // Fixed whitespace error in txt file, fix https://github.com/Draveness/DKNightVersion/issues/64
   NSMutableArray *stEntries     = [NSMutableArray array];
   
   [stTempEntries enumerateObjectsUsingBlock:^(NSString * _Nonnull aEntry, NSUInteger aIndex, BOOL * _Nonnull aStop) {
      
      NSString *trimmingEntry = [aEntry stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      
      [stEntries addObject:trimmingEntry];
   }];
   
   [stEntries filterUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
   
   [stEntries removeObjectAtIndex:0]; // Remove theme entry
   
   NSMutableArray<DKThemeVersion *> *stThemes = [[self themesFromContents:szContents] mutableCopy];
   [stThemes removeObjectAtIndex:0]; // 删除 NAME
   
   self.themes = stThemes;
   
   // Add entry to color table
   for (NSString *szEntry in stEntries) {
      
      if ([[szEntry stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] hasPrefix:@"//"]) {
         
         continue;
         
      } /* End if () */
      
      NSString *keys = [self keyFromEntry:szEntry];
      
      NSArray *colors = [self colorsFromEntry:szEntry];
      
      [self addEntryWithKey:keys colors:colors themes:self.themes];
      
   } /* End for () */
   
   return;
}

- (NSArray *)themesFromContents:(NSString *)aContent {
   
   NSString *rawThemes = [aContent componentsSeparatedByString:@"\n"].firstObject;
   
   return [self separateString:rawThemes];
}

- (NSArray *)colorsFromEntry:(NSString *)aEntry {
   
   NSMutableArray *stColors   = [[self separateString:aEntry] mutableCopy];
   
//   [colors removeLastObject];
   [stColors removeObjectAtIndex:0];  // NAME
   
   NSMutableArray *stResult   = [NSMutableArray array];
   
   for (NSString *szNumber in stColors) {
      
      [stResult addObject:[self colorFromString:szNumber]];
      
   } /* End for () */
   
   return stResult;
}

- (NSString *)keyFromEntry:(NSString *)aEntry {
   
//   return [self separateString:entry].lastObject;
   return [self separateString:aEntry].firstObject;
}

- (void)addEntryWithKey:(NSString *)aKey colors:(NSArray *)aColors themes:(NSArray *)aThemes {
   
   NSParameterAssert(aThemes.count == aColors.count);
   
   __block NSMutableDictionary   *stThemeToColorDictionary  = [NSMutableDictionary dictionary];
   
   [aThemes enumerateObjectsUsingBlock:^(NSString * _Nonnull aTheme, NSUInteger aIndex, BOOL * _Nonnull aStop) {
      
      [stThemeToColorDictionary setValue:aColors[aIndex] forKey:aTheme];
   }];
   
   [self.table setValue:stThemeToColorDictionary forKey:aKey];
   
   return;
}

- (DKColorPicker)pickerWithKey:(NSString *)aKey {
   
   NSParameterAssert(aKey);
   
   NSDictionary   *stThemeToColorDictionary  = [self.table valueForKey:aKey];
   DKColorPicker   stPicker                  = ^(DKThemeVersion *themeVersion) {
      
      return [stThemeToColorDictionary valueForKey:themeVersion];
   };
   
   return stPicker;
}

#pragma mark - Getter/Setter

- (NSMutableDictionary *)table {
   
   if (!_table) {
      
      _table = [NSMutableDictionary dictionary];
      
   } /* End if () */
   
   return _table;
}

- (void)setFile:(NSString *)aFile {
   
   _file = aFile;
   
   [self reloadColorTable];
   
   return;
}

#pragma mark - Helper

- (UIColor*)colorFromString:(NSString*)aHexStr {
   
   aHexStr = [aHexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
   
   if ([aHexStr hasPrefix:@"0x"]) {
      
      aHexStr = [aHexStr substringFromIndex:2];
      
   } /* End if () */
   
   if ([aHexStr hasPrefix:@"#"]) {
      
      aHexStr = [aHexStr substringFromIndex:1];
      
   } /* End if () */
   
   NSUInteger   nHex = [self intFromHexString:aHexStr];
   
   if (aHexStr.length > 6) {
      
      return DKColorFromRGBA(nHex);
      
   } /* End if () */
   
   return DKColorFromRGB(nHex);
}

- (NSUInteger)intFromHexString:(NSString *)aHexStr {
   
   unsigned int nHexInt    = 0;
   
   NSScanner   *stScanner  = [NSScanner scannerWithString:aHexStr];
   
   [stScanner scanHexInt:&nHexInt];
   
   return nHexInt;
}

- (NSArray *)separateString:(NSString *)aString {
   
   NSArray *array = [aString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
   
   return [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
}

@end
