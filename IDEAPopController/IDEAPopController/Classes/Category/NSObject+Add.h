//
//  NSObject+Add.h
//  IDEAPopController
//
//  Copyright © 2020 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (IDEAAdd)

+ (BOOL)hw_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)hw_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;
@end

NS_ASSUME_NONNULL_END
