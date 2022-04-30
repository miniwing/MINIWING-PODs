//
//  UIViewX.m
//  IDEAUIKit
//
//  Created by Harry on 2022/3/21.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "UIViewX.h"

@interface UIViewX ()

@end

@implementation UIViewX

- (void)dealloc {
   
   __LOG_FUNCTION;
   
   // Custom dealloc
   
   __SUPER_DEALLOC;
   
   return;
}

- (instancetype)initWithFrame:(CGRect)aFrame {
   
   self  = [super initWithFrame:aFrame];
   
   if (self) {

   } /* End if () */

   return self;
}

- (instancetype)initWithCoder:(NSCoder *)aCoder {

   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super initWithCoder:aCoder];
   
   if (self) {

   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (void)awakeFromNib {

   int                            nErr                                     = EFAULT;

   __TRY;

   [super awakeFromNib];
   // Initialization code
   
   __CATCH(nErr);

   return;
}

@end
