//
//  IDEAView.m
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "IDEAView.h"

@interface NSObject ()

- (void)night_updateColor:(NSNotification *)aNotification;

@end

@interface IDEAView ()

@end

@implementation IDEAView

- (void)night_updateColor:(NSNotification *)aNotification {
      
   [super night_updateColor:aNotification];
   
#if __Debug__
   if ([@"ChatKeyboard" isEqualToString:self.className]) {
      
      LogDebug((@"-[IDEAView night_updateColor:] : %@", self));
      
   } /* End if () */
#endif /* __Debug__ */
   
   if ([self respondsToSelector:@selector(onThemeUpdate:)]) {
      
      [self performSelector:@selector(onThemeUpdate:) withObject:aNotification];
      
   } /* End if () */
   
   return;
}

@end
