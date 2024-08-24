//
//  UINavigationBarX+Inner.m
//  IDEAUIKit
//
//  Created by Harry on 2022/3/25.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "UINavigationBarX+Inner.h"

@implementation UINavigationBarX (Inner)

@end

@implementation UINavigationBarX (IDEANibBridge)

#pragma mark - IDEANibBridge
+ (UINib *)nib {
   
   return [UINib nibWithNibName:self.nibID
                         bundle:__BUNDLE_FROM(self.class)];
}

@end
