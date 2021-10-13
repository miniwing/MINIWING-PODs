//
//  UIView+XIB.m
//  Idea
//
//  Created by Harry on 15/10/17.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "UIView+XIB.h"

#import "IDEAUtils.h"
#import "UIDevice+Device.h"

#import "NSBundle+XIB.h"

@implementation UIView (XIB)

+ (__kindof UIView *)loadXIB:(NSString *)aXIB class:(Class)aClass {
   
   NSString             *szXIB            = [NSBundle XIB:aXIB PAD:[UIDevice isPad]];
   NSArray              *stNIBs           = [[NSBundle mainBundle] loadNibNamed:szXIB
                                                                          owner:self
                                                                        options:nil];
   UIView               *stView           = nil;
   
   for (id stSub = nil in stNIBs) {
      
      LogDebug((@"Sub Class  %@", [stSub class]));
      
      if ([stSub isKindOfClass:aClass]) {
         
         stView   = __cast(UIView *, stSub);
         
         break;
         
      } /* End if () */
      
   } /* End for () */
   
   return stView;
}

@end

