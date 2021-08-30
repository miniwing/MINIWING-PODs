//
//  CAMediaTimingFunction+TabBarControllerTransition.m
//  IDEATabBarControllerTransition
//
//  Created by Harry on 2021/4/8.
//

#import "CAMediaTimingFunction+TabBarControllerTransition.h"

@implementation CAMediaTimingFunction (TabBarControllerTransition)

+ (instancetype)linear {
   
   return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
}

+ (instancetype)easeIn {
   
   return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
}

+ (instancetype)easeOut {
   
   return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
}

+ (instancetype)easeInOut {
   
   return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
}

@end
