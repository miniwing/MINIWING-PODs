//
//  UIFont+IDEASearchController.m
//  IDEASearchController
//
//  Created by Harry on 2021/4/17.
//

#import "UIFont+IDEASearchController.h"

@implementation UIFont (IDEASearchController)

+ (instancetype)search_lightFontOfSize:(CGFloat)size {
#if IDEA_FONT
   return [UIFont HYLightFontOfSize:size];
#else // IDEA_FONT
   return [UIFont systemFontOfSize:size weight:UIFontWeightLight];
#endif // !IDEA_FONT
}

+ (instancetype)search_regularFontOfSize:(CGFloat)size {
#if IDEA_FONT
   return [UIFont HYRegularFontOfSize:size];
#else // IDEA_FONT
   return [UIFont systemFontOfSize:size weight:UIFontWeightRegular];
#endif // !IDEA_FONT
}

//+ (instancetype)search_boldFontOfSize:(CGFloat)size {
//#if IDEA_FONT
//   return [UIFont HYBoldFontOfSize:size];
//#else // IDEA_FONT
//   return [UIFont systemFontOfSize:size weight:UIFontWeightBold];
//#endif // !IDEA_FONT
//}

@end
