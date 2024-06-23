//
//  UIViewController+Separator.m
//  UIViewController+Separator
//
//  Created by Harry on 2021/02/25.
//  Copyright © 2024 Harry. All rights reserved.
//

#import <IDEAColor/IDEAColor.h>
#import <IDEAColor/UIColorX+System.h>

#import "UIViewController+Separator.h"

@implementation UIViewController (Separator)

- (void)setSeparator {
   
   int                            nErr                                     = EFAULT;
   
   UIView                        *stSeparatorLine                          = nil;
   
   __TRY;
   
   if (nil != self.navigationController) {
      
//      [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//
//      stSeparatorLine   = [[UIView alloc] initWithFrame:CGRectMake(NAVIGATIONBAR_SEPARATOR_LEFT_MARGIN, self.navigationController.navigationBar.frame.size.height - 1, self.navigationController.navigationBar.frame.size.width - (NAVIGATIONBAR_SEPARATOR_LEFT_MARGIN + NAVIGATIONBAR_SEPARATOR_RIGHT_MARGIN), 0.5)];
//      stSeparatorLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//
//#if IDEA_NIGHT_VERSION_MANAGER
//      [stSeparatorLine setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor separator])];
//#else /* IDEA_NIGHT_VERSION_MANAGER */
//      [stSeparatorLine setBackgroundColor:[UIColor separatorColor]];
//#endif /* !IDEA_NIGHT_VERSION_MANAGER */
//
//      [self.navigationController.navigationBar addSubview:stSeparatorLine];
//
//      [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:UIColor.systemRedColor]];

#if IDEA_NIGHT_VERSION_MANAGER
      [self.navigationController.navigationBar setShadowImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
         
         return [UIImage imageWithColor:[IDEAColor colorWithKey:[IDEAColor opaqueSeparator]]];
      }];
#else /* IDEA_NIGHT_VERSION_MANAGER */
      [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:UIColor.systemRedColor]];
#endif /* !IDEA_NIGHT_VERSION_MANAGER */

   } /* End if () */
   
#if IDEA_NAVIGATION_BAR
   [self wr_setNavBarShadowImageHidden:YES];
#endif /* IDEA_NAVIGATION_BAR */
   
   __CATCH(nErr);
   
   return;
}

- (void)removeSeparator {
   
   int                            nErr                                     = EFAULT;
   
   UIView                        *stSeparatorLine                          = nil;
   
   __TRY;
   
   if (nil != self.navigationController) {
      
      [self.navigationController.navigationBar setShadowImage:[UIImage new]];
      
   } /* End if () */
   
#if IDEA_NAVIGATION_BAR
   [self wr_setNavBarShadowImageHidden:YES];
#endif /* IDEA_NAVIGATION_BAR */
   
   __CATCH(nErr);
   
   return;
}

@end
