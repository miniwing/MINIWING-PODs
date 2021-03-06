//
//  UIControl+Night.m
//  UIControl+Night
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UIControl+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UIControl ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKPicker> *pickers;

@end

@implementation UIControl (Night)

- (DKColorPicker)tintColorPicker {
   
   return objc_getAssociatedObject(self, @selector(tintColorPicker));
}

- (void)setTintColorPicker:(DKColorPicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(tintColorPicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);
   
   if (nil != aPicker) {

      self.tintColor = aPicker(self.themeManager.themeVersion);
      [self.pickers setValue:[aPicker copy] forKey:@"setTintColor:"];

   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:@"setTintColor:"];

   } /* End else */
   
   return;
}

@end
