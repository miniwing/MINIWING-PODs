//
//  UILabel+Night.m
//  UILabel+Night
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UILabel+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UILabel ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKPicker> *pickers;

@end

@implementation UILabel (Night)

- (DKColorPicker)textColorPicker {
   
   return objc_getAssociatedObject(self, @selector(textColorPicker));
}

- (void)setTextColorPicker:(DKColorPicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(textColorPicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);
   
   if (nil != aPicker) {
      
      [self.pickers setValue:[aPicker copy] forKey:@"setTextColor:"];

      self.textColor = aPicker(self.themeManager.themeVersion);

   } /* End if () */
   else {
            
      [self.pickers removeObjectForKey:@"setTextColor:"];
      
   } /* End else */

   return;
}

- (DKColorPicker)shadowColorPicker {
   
   return objc_getAssociatedObject(self, @selector(shadowColorPicker));
}

- (void)setShadowColorPicker:(DKColorPicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(shadowColorPicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);
   
   if (nil != aPicker) {
      
      self.shadowColor = aPicker(self.themeManager.themeVersion);
      [self.pickers setValue:[aPicker copy] forKey:@"setShadowColor:"];

   } /* End if () */
   else {
            
      [self.pickers removeObjectForKey:@"setShadowColor:"];
      
   } /* End else */
   
   return;
}

- (DKColorPicker)highlightedTextColorPicker {
   
   return objc_getAssociatedObject(self, @selector(highlightedTextColorPicker));
}

- (void)setHighlightedTextColorPicker:(DKColorPicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(highlightedTextColorPicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);
   
   if (nil != aPicker) {

      self.highlightedTextColor = aPicker(self.themeManager.themeVersion);
      [self.pickers setValue:[aPicker copy] forKey:@"setHighlightedTextColor:"];

   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:@"setHighlightedTextColor:"];

   } /* End else */

   return;
}

@end
