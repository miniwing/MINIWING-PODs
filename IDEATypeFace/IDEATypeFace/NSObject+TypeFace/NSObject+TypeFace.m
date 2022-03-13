//
//  NSObject+TypeFace.m
//  IDEATypeFace
//
//  Created by Harry on 2022/3/10.
//

#import "IDEATypeFace/NSObject+TypeFace.h"

@implementation NSObject (TypeFace)

/**
 @brief 方法替换
 @param originselector 替换的原方法
 @param swizzleSelector 替换后的方法
 @param isClassMethod 是否为类方法，YES为类方法，NO为对象方法
 */
+ (void)runtimeReplaceMethodWithSelector:(SEL)originselector
                         swizzleSelector:(SEL)swizzleSelector
                           isClassMethod:(BOOL)isClassMethod
{
   Method originMethod;
   Method swizzleMethod;
   if (isClassMethod == YES)
   {
      originMethod = class_getClassMethod([self class], originselector);
      swizzleMethod = class_getClassMethod([self class], swizzleSelector);
   }
   else
   {
      originMethod = class_getInstanceMethod([self class], originselector);
      swizzleMethod = class_getInstanceMethod([self class], swizzleSelector);
   }
   method_exchangeImplementations(originMethod, swizzleMethod);
}

@end
