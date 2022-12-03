//
//  UIActivityIndicatorView+Night.m
//  IDEANightVersion
//
//  Created by Harry on 2019/12/30.
//  Copyright © 2019 Harry. All rights reserved.
//

#import "UITabBar+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

#import "UIActivityIndicatorView+Night.h"

@interface UIActivityIndicatorView ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKPicker> *pickers;

@end

@implementation UIActivityIndicatorView (Night)

- (DKColorPicker)colorPicker {
   
   return objc_getAssociatedObject(self, @selector(colorPicker));
}

- (void)setColorPicker:(DKColorPicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(colorPicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);
   
   if (nil != aPicker) {

      self.color  = aPicker(self.themeManager.themeVersion);
      [self.pickers setValue:[aPicker copy] forKey:@"setColor:"];

   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:@"setColor:"];

   } /* End else */
   
   return;
}

@end
