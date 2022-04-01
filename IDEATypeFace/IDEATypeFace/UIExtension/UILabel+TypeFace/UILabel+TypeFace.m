//
//  UILabel+TypeFace.m
//  IDEATypeFace
//
//  Created by Harry on 2022/3/10.
//

#import "IDEATypeFace/NSObject+TypeFace.h"
#import "IDEATypeFace/UILabel+TypeFace.h"

@implementation UILabel (TypeFace)

+ (void)load {
   
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{

      [[self class] runtimeReplaceMethodWithSelector:@selector(initWithCoder:)
                                     swizzleSelector:@selector(customInitWithCoder:)
                                       isClassMethod:NO];
   });
   
   return;
}

- (instancetype)customInitWithCoder:(NSCoder *)aCoder {
   
   if ([self customInitWithCoder:aCoder]) {
      
      ///此时调用fontWithName:size:方法，实际上调用的是方法交换后的customFontWithName:size:
      self.font = [UIFont fontWithName:self.font.familyName size:self.font.pointSize];
   }
   return self;
}

@end
