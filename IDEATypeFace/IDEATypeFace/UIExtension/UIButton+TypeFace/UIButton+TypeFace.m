//
//  UIButton+TypeFace.m
//  IDEATypeFace
//
//  Created by Harry on 2022/3/10.
//

#import "IDEATypeFace/NSObject+TypeFace.h"
#import "IDEATypeFace/UIButton+TypeFace.h"

@implementation UIButton (Font)

+ (void)load {
   
   [[self class] runtimeReplaceMethodWithSelector:@selector(initWithCoder:) swizzleSelector:@selector(customInitWithCoder:) isClassMethod:NO];
   
   return;
}

- (instancetype)customInitWithCoder:(NSCoder *)coder {
   
   if ([self customInitWithCoder:coder]) {
      
      if (self.titleLabel != nil) {
         
         self.titleLabel.font = [UIFont fontWithName:self.titleLabel.font.familyName size:self.titleLabel.font.pointSize];
         
      } /* End if () */
      
   } /* End if () */
   
   return self;
}

@end
