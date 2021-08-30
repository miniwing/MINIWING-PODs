//
//  UICollectionViewCell+Reuse.m
//  IDEAUIKit
//
//  Created by Harry on 2020/1/9.
//  Copyright © 2020 Harry. All rights reserved.
//

#import "UICollectionViewCell+Reuse.h"

@implementation UICollectionViewCell (Reuse)

#pragma mark - Identifier
+ (NSString *)reuseIdentifier {
   
   return NSStringFromClass([self class]);
}

@end
