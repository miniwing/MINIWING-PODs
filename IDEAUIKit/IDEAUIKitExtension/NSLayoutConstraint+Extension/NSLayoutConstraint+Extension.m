//
//  NSLayoutConstraint+Extension.m
//  NSLayoutConstraint+Extension
//
//  Created by Harry on 2021/6/14.
//

#import "NSLayoutConstraint+Extension.h"

@implementation NSLayoutConstraint (Extension)

+ (NSLayoutConstraint *)constraintWithIdentifier:(NSString *)aIdentifier fromView:(UIView *)aView {
   
   int                            nErr                                     = EFAULT;

   NSLayoutConstraint            *stLayoutConstraint                       = nil;
   
   __TRY;

   for (NSLayoutConstraint *stConstraint in aView.constraints) {
      
      if ([stConstraint.identifier isEqualToString:aIdentifier]) {
         
         stLayoutConstraint   = stConstraint;
         
         break;
         
      } /* End if () */
      
   } /* End for () */
   
   __CATCH(nErr);

   return stLayoutConstraint;
}

+ (NSArray<NSLayoutConstraint *> *)constraintsWithIdentifier:(NSString *)aIdentifier fromView:(UIView *)aView {
   
   int                            nErr                                     = EFAULT;

   NSMutableArray<NSLayoutConstraint *>   *stLayoutConstraints             = [NSMutableArray<NSLayoutConstraint *> array];
   
   __TRY;

   for (NSLayoutConstraint *stLayoutConstraint in aView.constraints) {
      
      if ([stLayoutConstraint.identifier isEqualToString:aIdentifier]) {
         
         [stLayoutConstraints addObject:stLayoutConstraint];
                  
      } /* End if () */
      
   } /* End for () */
   
   __CATCH(nErr);

   return stLayoutConstraints;
}

@end
