//
//  YYWebImageManager+Operation.h
//  IDEAKit
//
//  Created by Harry on 2019/3/20.
//  Copyright © 2019年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

#if (__has_include(<YYKit/YYKit.h>) && __has_include(<YYKit/YYWebImageManager.h>))
#  import <YYKit/YYWebImageManager.h>
#  define YY_WebImageManager_Operation             (1)
#elif (__has_include("YYKit/YYKit.h") && __has_include("YYKit/YYWebImageManager.h"))
#  import "YYKit/YYWebImageManager.h"
#  define YY_WebImageManager_Operation             (1)
#elif (__has_include("YYKit.h") && __has_include("YYWebImageManager.h"))
#  import "YYWebImageManager.h"
#  define YY_WebImageManager_Operation             (1)
#else
#  define YY_WebImageManager_Operation             (0)
#endif

NS_ASSUME_NONNULL_BEGIN

#if YY_WebImageManager_Operation
@interface YYWebImageManager (Operation)

- (BOOL)containOperation:(NSString *)aURL;

@end
#endif /* YY_WebImageManager_Operation */

NS_ASSUME_NONNULL_END

