//
//  MKPointAnnotationX.m
//  IDEAUIKit
//
//  Created by Harry on 2022/10/24.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "MKPointAnnotationX.h"

@interface MKPointAnnotationX ()

@end

@implementation MKPointAnnotationX

- (void)dealloc {

   __LOG_FUNCTION;

   // Custom dealloc

   __SUPER_DEALLOC;

   return;
}

- (instancetype)init {

   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super init];
   
   if (self) {
            
   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (NSString *)reuseIdentifier {
   
   return NSStringFromClass([self class]);
}

@end
