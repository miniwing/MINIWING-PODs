//
//  UINavigationBarX+Theme.m
//  IDEAUIKit
//
//  Created by Harry on 2022/3/25.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "UINavigationBarX+Theme.h"

#pragma mark - UITheme
@implementation UINavigationBarX (Theme)

- (void)onThemeUpdate:(NSNotification *)aNotification {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   LogDebug((@"-[UINavigationBarX onThemeUpdate:] : Notification : %@", aNotification));

   __CATCH(nErr);

   return;
}

@end
