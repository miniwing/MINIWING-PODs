//
//  IDEATypeFaceSystemFont.m
//  IDEATypeFace
//
//  Created by Harry on 2021/3/4.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEATypeFace/IDEATypeFace.h"
#import "IDEATypeFace/IDEATypeFaceSystemFont.h"

@interface IDEATypeFaceSystemFont () <IDEATypeFaceDelegate>

@property (nonatomic, strong)                NSCache                             * fontCache;

@end

@implementation IDEATypeFaceSystemFont

+ (instancetype)shareInstance {
   
   static   IDEATypeFaceSystemFont  *g_IDEA_FONT         = nil;
   dispatch_once_t                   stOnceToken;
   
   dispatch_once(&stOnceToken, ^(void) {
      
      g_IDEA_FONT = [[IDEATypeFaceSystemFont alloc] init];
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
   
   return [[IDEATypeFaceSystemFont shareInstance] lightFontOfSize:fontSize];
}

/** Asks the receiver to return a font with a normal weight. FontSize must be larger tha 0. */
+ (nonnull UIFont *)regularFontOfSize:(CGFloat)fontSize {
   
   return [[IDEATypeFaceSystemFont shareInstance] regularFontOfSize:fontSize];
}

/** Asks the receiver to return a font with a medium weight. FontSize must be larger tha 0. */
+ (nullable UIFont *)mediumFontOfSize:(CGFloat)fontSize {
   
   return [[IDEATypeFaceSystemFont shareInstance] mediumFontOfSize:fontSize];
}

/** Asks the receiver to return a font with a bold weight. FontSize must be larger tha 0. */
+ (nonnull UIFont *)boldFontOfSize:(CGFloat)fontSize {
   
   return [[IDEATypeFaceSystemFont shareInstance] boldFontOfSize:fontSize];
}

/** Asks the receiver to return an italic font. FontSize must be larger tha 0. */
+ (nonnull UIFont *)italicFontOfSize:(CGFloat)fontSize {
   
   return [[IDEATypeFaceSystemFont shareInstance] italicFontOfSize:fontSize];
}

/** Asks the receiver to return a font with an italic bold weight. FontSize must be larger tha 0. */
+ (nullable UIFont *)boldItalicFontOfSize:(CGFloat)fontSize {
   
   return [[IDEATypeFaceSystemFont shareInstance] boldItalicFontOfSize:fontSize];
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
   
   UIFont            *stRegular     = [self regularFontOfSize:aFontSize];
   UIFontDescriptor  *stDescriptor  = [stRegular.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold | UIFontDescriptorTraitItalic];
   
   if (!stDescriptor) {
      
      return nil;
      
   } /* End if () */
   
   UIFontDescriptor *stNonnullDescriptor = stDescriptor;
   stFont = [UIFont fontWithDescriptor:stNonnullDescriptor size:aFontSize];
   
   [self.fontCache setObject:stFont forKey:szCacheKey];
   
   return stFont;
}

@end
