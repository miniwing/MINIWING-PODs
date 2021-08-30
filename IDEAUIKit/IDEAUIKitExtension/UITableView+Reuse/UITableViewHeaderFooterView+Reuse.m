//
//  UITableViewHeaderFooterView+Reuse.m
//  IDEAUIKit
//
//  Created by Harry on 2020/1/9.
//  Copyright © 2020 Harry. All rights reserved.
//

#import "UITableViewHeaderFooterView+Reuse.h"

@implementation UITableViewHeaderFooterView (Dynamic)

#pragma mark - Identifier
+ (NSString *)reuseIdentifier {
   
   return NSStringFromClass([self class]);
}

@end
