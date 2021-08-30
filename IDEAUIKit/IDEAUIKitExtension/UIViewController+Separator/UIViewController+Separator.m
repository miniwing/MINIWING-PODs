//
//  UIViewController+Separator.m
//  Interview
//
//  Created by Harry on 2021/02/25.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "UIViewController+Separator.h"
#import <IDEAColor/UIColor+System.h>

@implementation UIViewController (Separator)

- (void)setSeparator {
   
   int                            nErr                                     = EFAULT;
   
   UIView                        *stSeparatorLine                          = nil;
   
   __TRY;
   
   if (nil != self.navigationController) {
      
      [self.navigationController.navigationBar setShadowImage:[UIImage new]];
      
      stSeparatorLine   = [[UIView alloc] initWithFrame:CGRectMake(NAVIGATIONBAR_SEPARATOR_LEFT_MARGIN, self.navigationController.navigationBar.frame.size.height - 1, self.navigationController.navigationBar.frame.size.width - (NAVIGATIONBAR_SEPARATOR_LEFT_MARGIN + NAVIGATIONBAR_SEPARATOR_RIGHT_MARGIN), 0.5)];
      stSeparatorLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
#if IDEA_NIGHT_VERSION_MANAGER
      [stSeparatorLine setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor separator])];
#else /* IDEA_NIGHT_VERSION_MANAGER */
      [stSeparatorLine setBackgroundColor:[UIColor separatorColor]];
#endif /* !IDEA_NIGHT_VERSION_MANAGER */
      
      [self.navigationController.navigationBar addSubview:stSeparatorLine];
      
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
