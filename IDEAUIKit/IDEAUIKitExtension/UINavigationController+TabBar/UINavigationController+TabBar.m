//
//  UINavigationController+TabBar.m
//  UINavigationController+TabBar
//
//  Created by Harry on 2019/9/26.
//  Copyright © 2019 Harry. All rights reserved.
//

#import "UINavigationController+TabBar.h"

@implementation UINavigationController (TabBar)

- (void)setTabbarId:(NSNumber *)aTabbarId {
   
   objc_setAssociatedObject(self, @selector(tabbarId), aTabbarId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

   return;
}

- (NSNumber *)tabbarId {
   
   return objc_getAssociatedObject(self, _cmd);
}

@end
