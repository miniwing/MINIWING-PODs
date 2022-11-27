//
//  CALayer+Night.m
//  DKNightVersion
//
//  Created by Draveness on 16/1/29.
//  Copyright © 2016年 DeltaX. All rights reserved.
//

#import "CALayer+Night.h"
#import <objc/runtime.h>

@interface CALayer ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *pickers;

@end

@implementation CALayer (Night)

- (DKColorPicker)shadowColorPicker {
   return objc_getAssociatedObject(self, @selector(shadowColorPicker));
}

- (void)setShadowColorPicker:(DKColorPicker)picker {
   objc_setAssociatedObject(self, @selector(shadowColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
   self.shadowColor = picker(self.themeManager.themeVersion).CGColor;
   [self.pickers setValue:[picker copy] forKey:NSStringFromSelector(@selector(setShadowColor:))];
}

- (DKColorPicker)borderColorPicker {
   return objc_getAssociatedObject(self, @selector(borderColorPicker));
}

- (void)setBorderColorPicker:(DKColorPicker)picker {
   objc_setAssociatedObject(self, @selector(borderColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
   self.borderColor = picker(self.themeManager.themeVersion).CGColor;
   [self.pickers setValue:[picker copy] forKey:NSStringFromSelector(@selector(setBorderColor:))];
}

- (DKColorPicker)backgroundColorPicker {
   return objc_getAssociatedObject(self, @selector(backgroundColorPicker));
}

- (void)setBackgroundColorPicker:(DKColorPicker)picker {
   objc_setAssociatedObject(self, @selector(backgroundColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
   self.backgroundColor = picker(self.themeManager.themeVersion).CGColor;
   [self.pickers setValue:[picker copy] forKey:NSStringFromSelector(@selector(setBackgroundColor:))];
}

- (void)night_updateColor:(NSNotification *)aNotification {

   [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, DKColorPicker  _Nonnull picker, BOOL * _Nonnull stop) {
      CGColorRef result = picker(self.themeManager.themeVersion).CGColor;
      [UIView animateWithDuration:DKNightVersionAnimationDuration
                       animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
         if ([selector isEqualToString:NSStringFromSelector(@selector(setShadowColor:))]) {
            [self setShadowColor:result];
         }
         else if ([selector isEqualToString:NSStringFromSelector(@selector(setBorderColor:))]) {
            [self setBorderColor:result];
         }
         else if ([selector isEqualToString:NSStringFromSelector(@selector(setBackgroundColor:)) ]) {
            [self setBackgroundColor:result];
         }
#pragma clang diagnostic pop
      }];
   }];
}

@end
