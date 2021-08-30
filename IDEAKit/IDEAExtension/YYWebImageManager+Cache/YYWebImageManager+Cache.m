//
//  YYWebImageManager+Cache.m
//  IDEAKit
//
//  Created by Harry on 2019/3/20.
//  Copyright © 2019年 Harry. All rights reserved.
//

#import "YYWebImageManager+Cache.h"

#if YY_WebImageManager_Cache

@implementation YYWebImageManager (Cache)

- (UIImage *)getImageForURL:(NSURL *)aURL {
   
   UIImage                       *stImage                                  = nil;
   NSString                      *szKey                                    = nil;

   szKey = [self cacheKeyForURL:aURL];

   if (nil != szKey && 0 < szKey.length) {
      
      stImage  = [self.cache getImageForKey:szKey];

   } /* End if () */

   return stImage;
}

- (void)setImage:(UIImage *)aImage forURL:(NSURL *)aURL {

   UIImage                       *stImage                                  = nil;
   NSString                      *szKey                                    = nil;

   szKey = [self cacheKeyForURL:aURL];

   if ((nil != szKey && 0 < szKey.length) && nil != aImage) {
      
      [self.cache setImage:aImage forKey:szKey];

   } /* End if () */

   return;
}

- (void)setImage:(nonnull UIImage *)aImage forURL:(nonnull NSURL *)aURL withType:(YYImageCacheType)aType {
   
   UIImage                       *stImage                                  = nil;
   NSString                      *szKey                                    = nil;

   szKey = [self cacheKeyForURL:aURL];

   if ((nil != szKey && 0 < szKey.length) && nil != aImage) {
      
      [self.cache setImage:aImage forKey:szKey withType:aType];

   } /* End if () */

   return;
}

- (void)removeImageForURL:(NSURL *)aURL {
   
   NSString                      *szKey                                    = nil;

   szKey = [self cacheKeyForURL:aURL];

   if (nil != szKey && 0 < szKey.length) {
      
      [self.cache removeImageForKey:szKey];

   } /* End if () */

   return;
}

- (void)removeImageForURL:(NSURL *)aURL withType:(YYImageCacheType)aType {
   
   NSString                      *szKey                                    = nil;

   szKey = [self cacheKeyForURL:aURL];

   if (nil != szKey && 0 < szKey.length) {
      
      [self.cache removeImageForKey:szKey withType:aType];

   } /* End if () */

   return;
}

@end

#endif /* YY_WebImageManager_Cache */
