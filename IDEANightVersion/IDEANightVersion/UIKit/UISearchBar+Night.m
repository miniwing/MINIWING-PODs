//
//  UISearchBar+Night.m
//  UISearchBar+Night
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UISearchBar+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UISearchBar ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *pickers;

@end

@implementation UISearchBar (Night)

- (DKColorPicker)barTintColorPicker {
   
   return objc_getAssociatedObject(self, @selector(barTintColorPicker));
}

- (void)setBarTintColorPicker:(DKColorPicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(barTintColorPicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);

   if (nil != aPicker) {
      
      self.barTintColor = aPicker(self.themeManager.themeVersion);
      [self.pickers setValue:[aPicker copy] forKey:@"setBarTintColor:"];

   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:@"setBarTintColor:"];
      
   } /* End else */
   
   return;
}

@end
