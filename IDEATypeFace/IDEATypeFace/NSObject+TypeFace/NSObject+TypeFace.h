//
//  NSObject+TypeFace.h
//  IDEATypeFace
//
//  Created by Harry on 2022/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (TypeFace)

+ (void)runtimeReplaceMethodWithSelector:(SEL)originselector
                         swizzleSelector:(SEL)swizzleSelector
                           isClassMethod:(BOOL)isClassMethod;

@end

NS_ASSUME_NONNULL_END
