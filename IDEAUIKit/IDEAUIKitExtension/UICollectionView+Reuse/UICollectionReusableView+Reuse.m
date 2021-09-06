//
//  UICollectionReusableView+Reuse.m
//  UICollectionView+Reuse
//
//  Created by Harry on 2020/1/9.
//  Copyright © 2020 Harry. All rights reserved.
//

#import "UICollectionReusableView+Reuse.h"

@implementation UICollectionReusableView (Reuse)

#pragma mark - Identifier
+ (NSString *)reuseIdentifier {
   
   return NSStringFromClass([self class]);
}

@end
