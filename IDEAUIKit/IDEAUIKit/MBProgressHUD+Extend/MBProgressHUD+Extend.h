//
//  MBProgressHUD+Extend.h
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

@interface MBProgressHUD (Extend)

@property (class, nonatomic, readonly) NSTimeInterval hideDelay;

+ (MBProgressHUD *)HUDForView:(UIView *)aView ID:(NSInteger)aID;
- (void)setFontWithName:(NSString *)aName;

- (void)setLabelText:(NSString *)aText;
- (void)setDetailsLabelText:(NSString *)aText;
- (void)hide:(BOOL)aAnimated afterDelay:(NSTimeInterval)aDelay;

@end

#endif /* __has_include(<MBProgressHUD/MBProgressHUD.h>) || __has_include("MBProgressHUD/MBProgressHUD.h") */
