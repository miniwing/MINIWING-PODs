//
//  IDEACapsuleButton+Inner.m
//  Pods
//
//  Created by Harry on 2024/8/18.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEACapsuleButton.h"
#import "IDEACapsuleButton+Inner.h"
#import "IDEACapsuleButton+Action.h"

@implementation IDEACapsuleButton (Inner)

@end

@implementation IDEACapsuleButton (IDEANibBridge)

#pragma mark - IDEANibBridge
+ (UINib *)nib {
   
   return [UINib nibWithNibName:self.nibID
                         bundle:__BUNDLE_FROM(self.class)];
}

@end
