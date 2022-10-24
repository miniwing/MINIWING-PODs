//
//  MKAnnotationViewX.m
//  IDEAUIKit
//
//  Created by Harry on 2022/10/24.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "MKAnnotationViewX.h"

@interface MKAnnotationViewX ()

@end

@implementation MKAnnotationViewX

- (void)dealloc {

   __LOG_FUNCTION;

   // Custom dealloc

   __SUPER_DEALLOC;

   return;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)aRect {
   
   // Drawing code

   return;
}
*/

- (NSString *)reuseIdentifier {
   
   return NSStringFromClass([self class]);
}

@end
