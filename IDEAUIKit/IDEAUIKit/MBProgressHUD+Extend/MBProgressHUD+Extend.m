//
//  MBProgressHUD+Extend.m
//  MBProgressHUD+Extend
//
//  Created by Harry on 15/11/10.
//  Copyright © 2015年 Harry. All rights reserved.
//

#if __has_include(<MBProgressHUD/MBProgressHUD.h>) || __has_include("MBProgressHUD/MBProgressHUD.h")

#  if __has_include(<MBProgressHUD/MBProgressHUD.h>)
#     import <MBProgressHUD/MBProgressHUD.h>
#  elif __has_include("MBProgressHUD/MBProgressHUD.h")
#     import "MBProgressHUD/MBProgressHUD.h"
#  endif

#import "MBProgressHUD+Extend.h"

@implementation MBProgressHUD (Extend)

+ (NSTimeInterval)hideDelay {
   
   return 1.5;
}

+ (NSArray<MBProgressHUD *> *)allHUDsForView:(UIView *)aView {
   
   NSMutableArray<MBProgressHUD *>  *stHUDs     = [NSMutableArray array];
   NSArray<UIView *>                *stSubViews = aView.subviews;
   
   for (UIView *aView in stSubViews) {
      
      if ([aView isKindOfClass:MBProgressHUD.class]) {
         
         [stHUDs addObject:aView];
         
      } /* End if () */
      
   } /* End for () */
   
   return stHUDs;
}

- (void)setFontWithName:(NSString *)aName {
   
   [self.label setFont:[UIFont fontWithName:aName
                                       size:self.label.font.pointSize]];
   
   [self.detailsLabel setFont:[UIFont fontWithName:aName
                                              size:self.detailsLabel.font.pointSize]];

   return;
}

- (void)setLabelText:(NSString *)aText {
   
   [self.label setText:aText];
   
   return;
}

- (void)setDetailsLabelText:(NSString *)aText {
   
   [self.detailsLabel setText:aText];
   
   return;
}

- (void)hide:(BOOL)aAnimated afterDelay:(NSTimeInterval)aDelay {
   
   [self hideAnimated:aAnimated afterDelay:aDelay];
   
   return;
}

+ (MBProgressHUD *)HUDForView:(UIView *)aView ID:(NSInteger)aID {
   
   NSArray        *stHUDs  = [MBProgressHUD allHUDsForView:aView];
   
   for (MBProgressHUD *stHUD in stHUDs) {
      
      if (aID == stHUD.tag) {
         
         return stHUD;
         
      } /* End if () */
      
   } /* End for () */
   
   return nil;
}

@end

#endif /* __has_include(<MBProgressHUD/MBProgressHUD.h>) || __has_include("MBProgressHUD/MBProgressHUD.h") */
