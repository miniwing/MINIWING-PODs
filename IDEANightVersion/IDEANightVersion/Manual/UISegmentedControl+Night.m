//
//  UISegmentedControl+Night.m
//  DKNightVersion
//
//  Created by Draveness on 15/12/9.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "UISegmentedControl+Night.h"
#import <objc/runtime.h>

@interface UISegmentedControl ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end

@implementation UISegmentedControl (Night)

- (void)setTitleTextAttributesPicker:(DKAttributesPicker)aPicker forState:(UIControlState)aState {
   
   [self setTitleTextAttributes:aPicker(self.themeManager.themeVersion) forState:aState];
   NSString             *szKey         = [NSString stringWithFormat:@"%@", @(aState)];
   NSMutableDictionary  *stDictionary  = [self.pickers valueForKey:szKey];
   
   if (!stDictionary) {
      stDictionary = [[NSMutableDictionary alloc] init];
   }
   
   [stDictionary setValue:[aPicker copy] forKey:NSStringFromSelector(@selector(setTitleTextAttributes:forState:))];
   [self.pickers setValue:stDictionary forKey:szKey];
   
   return;
}

- (void)night_updateColor {
   
   [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull aKey, id  _Nonnull aObject, BOOL * _Nonnull aStop) {
      
      if ([aObject isKindOfClass:[NSDictionary class]]) {
         
         NSDictionary<NSString *, DKPicker>  *stDictionary  = (NSDictionary *)aObject;
         
         [stDictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull aSelector, DKPicker  _Nonnull aPicker, BOOL * _Nonnull stop) {
            
            UIControlState state = [aKey integerValue];
            [UIView animateWithDuration:DKNightVersionAnimationDuration
                             animations:^{
               
               if ([aSelector isEqualToString:NSStringFromSelector(@selector(setTitleTextAttributes:forState:))]) {
                  
                  NSDictionary   *stAttribute   = ((DKAttributesPicker)aPicker)(self.themeManager.themeVersion);
                  
                  [self setTitleTextAttributes:stAttribute forState:state];
                  
               } /* End if () */
            }];
         }];
         
      } /* End if () */
      else {
         
         SEL       stSEL      = NSSelectorFromString(aKey);
         DKPicker  stPicker   = (DKPicker)aObject;
         id        stResult   = stPicker(self.themeManager.themeVersion);
         
         [UIView animateWithDuration:DKNightVersionAnimationDuration
                          animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:stSEL withObject:stResult];
#pragma clang diagnostic pop
         }];
         
      } /* End else */
   }];
   
   return;
}

@end
