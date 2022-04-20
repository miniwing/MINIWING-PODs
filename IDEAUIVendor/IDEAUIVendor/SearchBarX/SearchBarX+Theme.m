//
//  SearchBarX+Theme.m
//  SearchBarX
//
//  Created by Harry on 2022/3/27.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "SearchBarX+Theme.h"

#pragma mark - UITheme
@implementation SearchBarX (Theme)

// #if DK_NIGHT_VERSION
// #endif // #if DK_NIGHT_VERSION
- (void)onThemeUpdate:(NSNotification *)aNotification {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   LogDebug((@"-[SearchBarX onThemeUpdate:] : Notification : %@", aNotification));

   __CATCH(nErr);

   return;
}

@end
