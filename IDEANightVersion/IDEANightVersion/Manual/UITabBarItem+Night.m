//
//  UITabBarItem+Night.m
//  UITabBarItem+Night
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UITabBarItem+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UITabBarItem ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end

@implementation UITabBarItem (Night)

- (DKImagePicker)imagePicker {
   
   return objc_getAssociatedObject(self, @selector(imagePicker));
}

- (void)setImagePicker:(DKImagePicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(imagePicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);
   
   if (nil != aPicker) {
      
      self.image = aPicker(self.themeManager.themeVersion);
      [self.pickers setValue:[aPicker copy] forKey:@"setImage:"];

   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:@"setImage:"];
      
   } /* End else */
   
   return;
}

- (DKImagePicker)selectedImagePicker {
   
   return objc_getAssociatedObject(self, @selector(selectedImagePicker));
}

- (void)setSelectedImagePicker:(DKImagePicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(selectedImagePicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);

   if (nil != aPicker) {
      
      self.image = aPicker(self.themeManager.themeVersion);
      [self.pickers setValue:[aPicker copy] forKey:@"selectedImage:"];
      
   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:@"selectedImage:"];
      
   } /* End else */
   
   return;
}

- (void)night_updateColor:(NSNotification *)aNotification {

   [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull aKey, id _Nonnull aObject, BOOL * _Nonnull aStop) {
      
      if ([aKey isEqualToString:@"setImage:"]) {
         
         DKImagePicker   stPicker   = (DKImagePicker)aObject;
         UIImage        *stImage    = stPicker(self.themeManager.themeVersion);
         
         [UIView animateWithDuration:DKNightVersionAnimationDuration
                          animations:^{
            
            ((void (*)(id, SEL, UIImage *))objc_msgSend)(self, NSSelectorFromString(aKey), stImage);
         }];
      } /* End if () */
      else if ([aKey isEqualToString:@"selectedImage:"]) {
         
         DKImagePicker   stPicker   = (DKImagePicker)aObject;
         UIImage        *stImage    = stPicker(self.themeManager.themeVersion);
         
         [UIView animateWithDuration:DKNightVersionAnimationDuration
                          animations:^{
            
            ((void (*)(id, SEL, UIImage *))objc_msgSend)(self, NSSelectorFromString(aKey), stImage);
         }];
      } /* End else if () */
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
      }
   }];
}

@end
