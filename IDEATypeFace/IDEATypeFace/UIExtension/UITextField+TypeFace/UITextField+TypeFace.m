//
//  UITextField+TypeFace.m
//  IDEATypeFace
//
//  Created by Harry on 2022/3/10.
//

#import "IDEATypeFace/NSObject+TypeFace.h"
#import "IDEATypeFace/UITextField+TypeFace.h"

@implementation UITextField (TypeFace)

+ (void)load {
   
   [[self class] runtimeReplaceMethodWithSelector:@selector(initWithCoder:)
                                  swizzleSelector:@selector(customInitWithCoder:)
                                    isClassMethod:NO];
   
   return;
}

- (instancetype)customInitWithCoder:(NSCoder *)aCoder {
   
   if ([self customInitWithCoder:aCoder]) {
      
      self.font = [UIFont fontWithName:self.font.familyName size:self.font.pointSize];
   }
   
   return self;
}

@end
