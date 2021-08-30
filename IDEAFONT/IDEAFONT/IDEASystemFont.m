//
//  IDEASystemFont.m
//  IDEAFONT
//
//  Created by Harry on 2021/3/4.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAFONT.h"
#import "IDEASystemFont.h"

@interface IDEASystemFont () <IDEAFONTDelegate>

@property (nonatomic, strong)                NSCache                             * fontCache;

@end

@implementation IDEASystemFont

+ (instancetype)shareInstance {
   
   static   IDEASystemFont *g_IDEA_FONT         = nil;
   dispatch_once_t          stOnceToken;
   
   dispatch_once(&stOnceToken, ^{
      g_IDEA_FONT = [[IDEASystemFont alloc] init];
   });
   
   return g_IDEA_FONT;
}

- (instancetype)init {
   
   self = [super init];
   
   if (self) {
      
      _fontCache  = [[NSCache alloc] init];
      
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(didChangeContentSize)
                                                   name:UIContentSizeCategoryDidChangeNotification
                                                 object:nil];
   } /* End if () */
   
   return self;
}

- (void)didChangeContentSize {
   
   [_fontCache removeAllObjects];
   
   return;
}

/** Asks the receiver to return a font with a light weight. FontSize must be larger tha 0. */
+ (nullable UIFont *)lightFontOfSize:(CGFloat)fontSize {
   
   return [[IDEASystemFont shareInstance] lightFontOfSize:fontSize];
}

/** Asks the receiver to return a font with a normal weight. FontSize must be larger tha 0. */
+ (nonnull UIFont *)regularFontOfSize:(CGFloat)fontSize {
   
   return [[IDEASystemFont shareInstance] regularFontOfSize:fontSize];
}

/** Asks the receiver to return a font with a medium weight. FontSize must be larger tha 0. */
+ (nullable UIFont *)mediumFontOfSize:(CGFloat)fontSize {
   
   return [[IDEASystemFont shareInstance] mediumFontOfSize:fontSize];
}

/** Asks the receiver to return a font with a bold weight. FontSize must be larger tha 0. */
+ (nonnull UIFont *)boldFontOfSize:(CGFloat)fontSize {
   
   return [[IDEASystemFont shareInstance] boldFontOfSize:fontSize];
}

/** Asks the receiver to return an italic font. FontSize must be larger tha 0. */
+ (nonnull UIFont *)italicFontOfSize:(CGFloat)fontSize {
   
   return [[IDEASystemFont shareInstance] italicFontOfSize:fontSize];
}

/** Asks the receiver to return a font with an italic bold weight. FontSize must be larger tha 0. */
+ (nullable UIFont *)boldItalicFontOfSize:(CGFloat)fontSize {
   
   return [[IDEASystemFont shareInstance] boldItalicFontOfSize:fontSize];
}

#pragma mark - implementation
- (nullable UIFont *)lightFontOfSize:(CGFloat)aFontSize {
   
   NSString *szCacheKey = [NSString stringWithFormat:@"%@-%06f", NSStringFromSelector(_cmd), aFontSize];
   UIFont   *stFont     = [self.fontCache objectForKey:szCacheKey];
   if (stFont) {
      
      return stFont;
      
   } /* End if () */
   
   stFont = [UIFont systemFontOfSize:aFontSize weight:UIFontWeightLight];
   if (stFont) {
      [self.fontCache setObject:stFont forKey:szCacheKey];
      
   } /* End if () */
   
   return stFont;
}

- (UIFont *)regularFontOfSize:(CGFloat)aFontSize {
   
   NSString *szCacheKey = [NSString stringWithFormat:@"%@-%06f", NSStringFromSelector(_cmd), aFontSize];
   UIFont   *stFont     = [self.fontCache objectForKey:szCacheKey];
   if (stFont) {
      
      return stFont;
      
   } /* End if () */
   
   stFont = [UIFont systemFontOfSize:aFontSize weight:UIFontWeightRegular];
   [self.fontCache setObject:stFont forKey:szCacheKey];
   
   return (UIFont *)stFont;
}

- (nullable UIFont *)mediumFontOfSize:(CGFloat)aFontSize {
   
   NSString *szCacheKey = [NSString stringWithFormat:@"%@-%06f", NSStringFromSelector(_cmd), aFontSize];
   UIFont   *stFont     = [self.fontCache objectForKey:szCacheKey];
   if (stFont) {
      
      return stFont;
      
   } /* End if () */
   
   stFont = [UIFont systemFontOfSize:aFontSize weight:UIFontWeightMedium];
   if (stFont) {
      
      [self.fontCache setObject:stFont forKey:szCacheKey];
      
   } /* End if () */
   
   return stFont;
}

- (UIFont *)boldFontOfSize:(CGFloat)aFontSize {
   
   NSString *szCacheKey = [NSString stringWithFormat:@"%@-%06f", NSStringFromSelector(_cmd), aFontSize];
   UIFont   *stFont     = [self.fontCache objectForKey:szCacheKey];
   if (stFont) {
      
      return stFont;
      
   } /* End if () */
   
   stFont = [UIFont systemFontOfSize:aFontSize weight:UIFontWeightSemibold];
   
   [self.fontCache setObject:stFont forKey:szCacheKey];
   
   return stFont;
}

- (UIFont *)italicFontOfSize:(CGFloat)aFontSize {
   
   NSString *szCacheKey = [NSString stringWithFormat:@"%@-%06f", NSStringFromSelector(_cmd), aFontSize];
   UIFont   *stFont     = [self.fontCache objectForKey:szCacheKey];
   if (stFont) {
      
      return stFont;
      
   } /* End if () */
   
   stFont = [UIFont italicSystemFontOfSize:aFontSize];
   
   [self.fontCache setObject:stFont forKey:szCacheKey];
   
   return stFont;
}

- (nullable UIFont *)boldItalicFontOfSize:(CGFloat)aFontSize {
   
   NSString *szCacheKey = [NSString stringWithFormat:@"%@-%06f", NSStringFromSelector(_cmd), aFontSize];
   UIFont   *stFont     = [self.fontCache objectForKey:szCacheKey];
   if (stFont) {
      
      return stFont;
      
   } /* End if () */
   
   UIFont   *stRegular  = [self regularFontOfSize:aFontSize];
   UIFontDescriptor *_Nullable stDescriptor  = [stRegular.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold | UIFontDescriptorTraitItalic];
   if (!stDescriptor) {
      
      return nil;
      
   } /* End if () */
   
   UIFontDescriptor *stNonnullDescriptor = stDescriptor;
   stFont = [UIFont fontWithDescriptor:stNonnullDescriptor size:aFontSize];
   
   [self.fontCache setObject:stFont forKey:szCacheKey];
   
   return stFont;
}

@end

@implementation IDEASystemFont (Size)

+ (CGFloat)appFontTitleSize {
   
   return 20;
}

+ (CGFloat)appFontSearchBarSize {
   
   return 14;
}

+ (CGFloat)appFontTabTitleSize {
   
   return 12;
}

@end
