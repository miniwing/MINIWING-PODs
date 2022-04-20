//
//  UIImageView+Night.m
//  DKNightVersion
//
//  Created by Draveness on 15/12/10.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "UIImageView+Night.h"
#import "NSObject+Night.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface NSObject ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end

@implementation UIImageView (Night)

- (instancetype)initWithImagePicker:(DKImagePicker)picker {
   UIImageView *imageView = [self initWithImage:picker(self.themeManager.themeVersion)];
   imageView.imagePicker = [picker copy];
   return imageView;
}

- (DKImagePicker)imagePicker {
   return objc_getAssociatedObject(self, @selector(imagePicker));
}

- (void)setImagePicker:(DKImagePicker)picker {
   objc_setAssociatedObject(self, @selector(imagePicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
   self.image = picker(self.themeManager.themeVersion);
   [self.pickers setValue:[picker copy] forKey:@"setImage:"];

   return;
}

- (DKAlphaPicker)alphaPicker {
   return objc_getAssociatedObject(self, @selector(alphaPicker));
}

- (void)setAlphaPicker:(DKAlphaPicker)picker {
   
   objc_setAssociatedObject(self, @selector(alphaPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
   self.alpha = picker(self.themeManager.themeVersion);
   [self.pickers setValue:[picker copy] forKey:@"setAlpha:"];
   
   return;
}

- (void)night_updateColor:(NSNotification *)aNotification {

   [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull aKey, id  _Nonnull aObject, BOOL * _Nonnull aStop) {
      
      if ([aKey isEqualToString:@"setAlpha:"]) {
         
         DKAlphaPicker   stPicker   = (DKAlphaPicker)aObject;
         CGFloat         fAlpha     = stPicker(self.themeManager.themeVersion);
         
         [UIView animateWithDuration:DKNightVersionAnimationDuration
                          animations:^{
            ((void (*)(id, SEL, CGFloat))objc_msgSend)(self, NSSelectorFromString(aKey), fAlpha);
         }];
      }
      else {
         SEL       stSEL      = NSSelectorFromString(aKey);
         DKPicker  stPicker   = aObject;
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
