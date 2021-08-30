//
//  UITableViewCell+Reuse.m
//  IDEAUIKit
//
//  Created by Harry on 2020/1/9.
//  Copyright © 2020 Harry. All rights reserved.
//

#import "UITableViewCell+Reuse.h"

@implementation UITableViewCell (Reuse)

#pragma mark - Identifier
+ (NSString *)reuseIdentifier {
   
   return NSStringFromClass([self class]);
}

@end
