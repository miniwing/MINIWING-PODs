//
//  IDEAStatusBar.m
//  IDEAStatusBar
//
//  Created by Harry on 2020/3/16.
//  Copyright © 2020 Harry. All rights reserved.
//

#import "IDEAStatusBar.h"

@interface IDEAStatusBar ()

@end

@implementation IDEAStatusBar

+ (CGSize)frameSize {
   
   Class UIApplicationClass = NSClassFromString(@"UIApplication");
   
   if (!UIApplicationClass || ![UIApplicationClass respondsToSelector:@selector(sharedApplication)]) {
      
      return CGSizeZero;
      
   } /* End if () */

   UIApplication  *stApplication = [UIApplication performSelector:@selector(sharedApplication)];

   return stApplication.statusBarFrame.size;
}

@end
