//
//  IDEAView.m
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2024 Harry. All rights reserved.
//

#import "IDEAView.h"

@interface NSObject ()

- (void)night_updateColor:(NSNotification *)aNotification;

@end

@implementation IDEAView

- (void)night_updateColor:(NSNotification *)aNotification {
      
   [super night_updateColor:aNotification];
      
   if ([self respondsToSelector:@selector(onThemeUpdate:)]) {
      
      [self performSelector:@selector(onThemeUpdate:) withObject:aNotification];
      
   } /* End if () */
   
   return;
}

@end
