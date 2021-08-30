//
//  UITableView+Night.m
//  UITableView+Night
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UITableView+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UITableView ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *pickers;

@end

@implementation UITableView (Night)

- (DKColorPicker)separatorColorPicker {
   
   return objc_getAssociatedObject(self, @selector(separatorColorPicker));
}

- (void)setSeparatorColorPicker:(DKColorPicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(separatorColorPicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);

   if (nil != aPicker) {
      
      self.separatorColor = aPicker(self.themeManager.themeVersion);
      [self.pickers setValue:[aPicker copy] forKey:@"setSeparatorColor:"];
      
   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:@"setSeparatorColor:"];
      
   } /* End else */
   
   return;
}

- (DKColorPicker)sectionIndexColorPicker {
   
   return objc_getAssociatedObject(self, @selector(sectionIndexColorPicker));
}

- (void)setSectionIndexColorPicker:(DKColorPicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(sectionIndexColorPicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);

   if (nil != aPicker) {
      
      self.sectionIndexColor = aPicker(self.themeManager.themeVersion);
      [self.pickers setValue:[aPicker copy] forKey:@"setSectionIndexColor:"];
      
   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:@"setSectionIndexColor:"];
      
   } /* End else */
   
   return;
}

- (DKColorPicker)sectionIndexBackgroundColorPicker {
   
   return objc_getAssociatedObject(self, @selector(sectionIndexBackgroundColorPicker));
}

- (void)setSectionIndexBackgroundColorPicker:(DKColorPicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(sectionIndexBackgroundColorPicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);

   if (nil != aPicker) {
      
      self.sectionIndexBackgroundColor = aPicker(self.themeManager.themeVersion);
      [self.pickers setValue:[aPicker copy] forKey:@"setSectionIndexBackgroundColor:"];

   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:@"setSectionIndexBackgroundColor:"];
      
   } /* End else */
   
   return;
}

- (DKColorPicker)sectionIndexTrackingBackgroundColorPicker {
   
   return objc_getAssociatedObject(self, @selector(sectionIndexTrackingBackgroundColorPicker));
}

- (void)setSectionIndexTrackingBackgroundColorPicker:(DKColorPicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(sectionIndexTrackingBackgroundColorPicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);

   if (nil != aPicker) {
      
      self.sectionIndexTrackingBackgroundColor = aPicker(self.themeManager.themeVersion);
      [self.pickers setValue:[aPicker copy] forKey:@"setSectionIndexTrackingBackgroundColor:"];

   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:@"setSectionIndexTrackingBackgroundColor:"];
      
   } /* End else */
   
   return;
}

@end
