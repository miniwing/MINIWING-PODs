//
//  UIButton+Night.m
//  DKNightVersion
//
//  Created by Draveness on 15/12/9.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "UIButton+Night.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end

@implementation UIButton (Night)

- (void)setTitleColorPicker:(DKColorPicker)picker forState:(UIControlState)aState {
   
   NSString    *szKey   = [NSString stringWithFormat:@"setTitleColor:forState:%@", @(aState)];

   if (nil != picker) {
      
      [self setTitleColor:picker(self.themeManager.themeVersion)
                 forState:aState];
      
      NSMutableDictionary *dictionary = [self.pickers valueForKey:szKey];
      if (!dictionary) {
         dictionary = [[NSMutableDictionary alloc] init];
      }
      [dictionary setValue:[picker copy] forKey:NSStringFromSelector(@selector(setTitleColor:forState:))];
      [self.pickers setValue:dictionary forKey:szKey];

   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:szKey];

   } /* End else */
   
   return;
}

- (void)setBackgroundImagePicker:(DKImagePicker)aPicker forState:(UIControlState)aState {

   NSString    *szKey   = [NSString stringWithFormat:@"setBackgroundImage:forState:%@", @(aState)];

   if (nil != aPicker) {
      
      [self setBackgroundImage:aPicker(self.themeManager.themeVersion) forState:aState];
      NSMutableDictionary *dictionary = [self.pickers valueForKey:szKey];
      if (!dictionary) {
         dictionary = [[NSMutableDictionary alloc] init];
      }
      [dictionary setValue:[aPicker copy] forKey:NSStringFromSelector(@selector(setBackgroundImage:forState:))];
      [self.pickers setValue:dictionary forKey:szKey];

   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:szKey];

   } /* End else */
   
   return;
}

- (void)setImagePicker:(DKImagePicker)aPicker forState:(UIControlState)aState {

   NSString    *szKey   = [NSString stringWithFormat:@"setImage:forState:%@", @(aState)];
   
   if (nil != aPicker) {

      [self setImage:aPicker(self.themeManager.themeVersion) forState:aState];
      
      NSMutableDictionary *stDictionary = [self.pickers valueForKey:szKey];
      if (!stDictionary) {
         stDictionary = [[NSMutableDictionary alloc] init];
      }
      [stDictionary setValue:[aPicker copy] forKey:NSStringFromSelector(@selector(setImage:forState:))];

      [self.pickers setValue:stDictionary forKey:szKey];

   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:szKey];

   } /* End else */
   
   return;
}

- (void)night_updateColor:(NSNotification *)aNotification {

   [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull aKey, id  _Nonnull aObj, BOOL * _Nonnull aStop) {
      
      if ([aObj isKindOfClass:[NSDictionary class]]) {
         
         NSDictionary<NSString *, DKPicker> *stDictionary = (NSDictionary *)aObj;
         
         [stDictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull aSelector, DKPicker  _Nonnull aPicker, BOOL * _Nonnull aStop) {
            
            UIControlState eState = [aKey integerValue];
            
//            [UIView animateWithDuration:DKNightVersionAnimationDuration
//                             animations:^{
//               if ([selector isEqualToString:NSStringFromSelector(@selector(setTitleColor:forState:))]) {
//                  UIColor *resultColor = picker(self.themeManager.themeVersion);
//                  [self setTitleColor:resultColor forState:state];
//               }
//               else if ([selector isEqualToString:NSStringFromSelector(@selector(setBackgroundImage:forState:))]) {
//                  UIImage *resultImage = ((DKImagePicker)picker)(self.themeManager.themeVersion);
//                  [self setBackgroundImage:resultImage forState:state];
//               }
//               else if ([selector isEqualToString:NSStringFromSelector(@selector(setImage:forState:))]) {
//                  UIImage *resultImage = ((DKImagePicker)picker)(self.themeManager.themeVersion);
//                  [self setImage:resultImage forState:state];
//               }
//            }];
            
            if ([aSelector isEqualToString:NSStringFromSelector(@selector(setTitleColor:forState:))]) {
               
               [UIView animateWithDuration:DKNightVersionAnimationDuration
                                animations:^{
                  
                  UIColor  *stColor = ((DKColorPicker)aPicker)(self.themeManager.themeVersion);

                  [self setTitleColor:stColor forState:eState];
               }];

            } /* End if () */
            else {

               [UIView transitionWithView:self
                                 duration:DKNightVersionAnimationDuration
                                  options:UIViewAnimationOptionTransitionCrossDissolve
                               animations:^{
                  
//                  if ([aSelector isEqualToString:NSStringFromSelector(@selector(setTitleColor:forState:))]) {
//                     UIColor *resultColor = ((DKColorPicker)aPicker)(self.themeManager.themeVersion);
//                     [self setTitleColor:resultColor forState:eState];
//                  }
//                  else
                  if ([aSelector isEqualToString:NSStringFromSelector(@selector(setBackgroundImage:forState:))]) {
                     UIImage  *stImage = ((DKImagePicker)aPicker)(self.themeManager.themeVersion);
                     [self setBackgroundImage:stImage forState:eState];
                  }
                  else if ([aSelector isEqualToString:NSStringFromSelector(@selector(setImage:forState:))]) {
                     UIImage  *stImage = ((DKImagePicker)aPicker)(self.themeManager.themeVersion);
                     [self setImage:stImage forState:eState];
                  }
               }
                               completion:nil];

            } /* End else */
                        
         }];
      }
      else {
         SEL             stSEL      = NSSelectorFromString(aKey);
         DKColorPicker   stPicker   = (DKColorPicker)aObj;
         id              stResult   = stPicker(self.themeManager.themeVersion);
         
         [UIView animateWithDuration:DKNightVersionAnimationDuration
                          animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:stSEL withObject:stResult];
#pragma clang diagnostic pop
         }];

      } /* End else */
   }];
}

@end
