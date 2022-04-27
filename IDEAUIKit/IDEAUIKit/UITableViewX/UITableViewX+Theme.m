//
//  UITableViewX+Theme.m
//  IDEAUIKit
//
//  Created by Harry on 2022/4/10.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "UITableViewX+Theme.h"

#pragma mark - UITheme
@implementation UITableViewX (Theme)

// #if DK_NIGHT_VERSION
// #endif /* DK_NIGHT_VERSION */
- (void)onThemeUpdate:(NSNotification *)aNotification {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   LogDebug((@"-[UITableViewX onThemeUpdate:] : Notification : %@", aNotification));

   __CATCH(nErr);

   return;
}

@end
