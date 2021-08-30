//
//  UISearchBar+Keyboard.m
//  DKNightVersion
//
//  Created by Draveness on 6/8/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

#import "UISearchBar+Keyboard.h"
#import "NSObject+Night.h"
#import <objc/runtime.h>

@interface NSObject ()

- (void)night_updateColor;

@end

@implementation UISearchBar (Keyboard)

+ (void)load {
   
   static dispatch_once_t onceToken;
   
   dispatch_once(&onceToken, ^{
      
      Class  stClass          = [self class];

      SEL    originalSelector = @selector(init);
      SEL    swizzledSelector = @selector(dk_init);

      Method originalMethod   = class_getInstanceMethod(stClass, originalSelector);
      Method swizzledMethod   = class_getInstanceMethod(stClass, swizzledSelector);

      BOOL   didAddMethod     = class_addMethod(stClass,
                                                originalSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod));

      if (didAddMethod) {
         
         class_replaceMethod(stClass,
                             swizzledSelector,
                             method_getImplementation(originalMethod),
                             method_getTypeEncoding(originalMethod));
         
      } /* End if () */
      else {
         
         method_exchangeImplementations(originalMethod, swizzledMethod);
         
      } /* End else */
      
      originalSelector  = @selector(initWithCoder:);
      swizzledSelector  = @selector(dk_initWithCoder:);
      
      originalMethod    = class_getInstanceMethod(stClass, originalSelector);
      swizzledMethod    = class_getInstanceMethod(stClass, swizzledSelector);
      
      didAddMethod      = class_addMethod(stClass,
                                          originalSelector,
                                          method_getImplementation(swizzledMethod),
                                          method_getTypeEncoding(swizzledMethod));
      
      if (didAddMethod) {
         
         class_replaceMethod(stClass,
                             swizzledSelector,
                             method_getImplementation(originalMethod),
                             method_getTypeEncoding(originalMethod));
         
      } /* End if () */
      else {
         
         method_exchangeImplementations(originalMethod, swizzledMethod);
         
      } /* End else */

      originalSelector  = @selector(initWithFrame:);
      swizzledSelector  = @selector(dk_initWithFrame:);
      
      originalMethod    = class_getInstanceMethod(stClass, originalSelector);
      swizzledMethod    = class_getInstanceMethod(stClass, swizzledSelector);
      
      didAddMethod      = class_addMethod(stClass,
                                          originalSelector,
                                          method_getImplementation(swizzledMethod),
                                          method_getTypeEncoding(swizzledMethod));
      
      if (didAddMethod) {
         
         class_replaceMethod(stClass,
                             swizzledSelector,
                             method_getImplementation(originalMethod),
                             method_getTypeEncoding(originalMethod));
         
      } /* End if () */
      else {
         
         method_exchangeImplementations(originalMethod, swizzledMethod);
         
      } /* End else */

   });

   return;
}

- (instancetype)dk_init {
   
   UISearchBar    *stSearchBar      = [self dk_init];
   UITextField    *stTextField      = nil;
   
   if (@available(iOS 13.0, *)) {
      
      stTextField = stSearchBar.searchTextField;
      
   } /* End if () */
   else {
      
#ifdef __IPHONE_7_0
      stTextField = [stSearchBar valueForKey:@"_searchField"];
#endif /* __IPHONE_7_0 */
      
   } /* End else */
   
   if (self.themeManager.supportsKeyboard && [self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
      
      if (nil != stTextField) {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDark;
         
      } /* End if () */
      else {
         
         stSearchBar.keyboardAppearance   = UIKeyboardAppearanceDefault;
         
      } /* End else */
   }
   else {
      
      if (nil != stTextField) {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceLight;
         
      } /* End if () */
      else {
         
         stSearchBar.keyboardAppearance   = UIKeyboardAppearanceDefault;
         
      } /* End else */
   }
   
   return stSearchBar;
}

- (instancetype)dk_initWithCoder:(NSCoder *)aCoder {
   
   UISearchBar    *stSearchBar      = [self dk_initWithCoder:aCoder];
   UITextField    *stTextField      = nil;
   
   if (@available(iOS 13.0, *)) {
      
      stTextField = stSearchBar.searchTextField;
      
   } /* End if () */
   else {
      
#ifdef __IPHONE_7_0
      stTextField = [stSearchBar valueForKey:@"_searchField"];
#endif /* __IPHONE_7_0 */
      
   } /* End else */
   
   if (self.themeManager.supportsKeyboard && [self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
      
      if (nil != stTextField) {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDark;
         
      } /* End if () */
      else {
         
         stSearchBar.keyboardAppearance   = UIKeyboardAppearanceDefault;
         
      } /* End else */
   }
   else {
      
      if (nil != stTextField) {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceLight;
         
      } /* End if () */
      else {
         
         stSearchBar.keyboardAppearance   = UIKeyboardAppearanceDefault;
         
      } /* End else */
   }
   
   return stSearchBar;
}

- (instancetype)dk_initWithFrame:(CGRect)aFrame {
   
   UISearchBar    *stSearchBar      = [self dk_initWithFrame:aFrame];
   UITextField    *stTextField      = nil;
   
   if (@available(iOS 13.0, *)) {
      
      stTextField = stSearchBar.searchTextField;
      
   } /* End if () */
   else {
      
#ifdef __IPHONE_7_0
      stTextField = [stSearchBar valueForKey:@"_searchField"];
#endif /* __IPHONE_7_0 */
      
   } /* End else */
   
   if (self.themeManager.supportsKeyboard && [self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
      
      if (nil != stTextField) {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDark;
         
      } /* End if () */
      else {
         
         stSearchBar.keyboardAppearance   = UIKeyboardAppearanceDefault;
         
      } /* End else */
   }
   else {
      
      if (nil != stTextField) {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceLight;
         
      } /* End if () */
      else {
         
         stSearchBar.keyboardAppearance   = UIKeyboardAppearanceDefault;
         
      } /* End else */
   }
   
   return stSearchBar;
}

//- (instancetype)dk_init_ex {
//
//   UISearchBar *stObject   = [self dk_init];
//
//   if (self.themeManager.supportsKeyboard && [self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
//
//#ifdef __IPHONE_7_0
//      UITextField *searchField = [stObject valueForKey:@"_searchField"];
//      searchField.keyboardAppearance = UIKeyboardAppearanceDark;
//#else
//      obj.keyboardAppearance = UIKeyboardAppearanceAlert;
//#endif
//   }
//   else {
//#ifdef __IPHONE_7_0
//      UITextField *searchField = [stObject valueForKey:@"_searchField"];
//      searchField.keyboardAppearance = UIKeyboardAppearanceDefault;
//#else
//      obj.keyboardAppearance = UIKeyboardAppearanceDefault;
//#endif
//   }
//
//   return stObject;
//}

- (void)night_updateColor {
   
   [super night_updateColor];
   
   if (self.themeManager.supportsKeyboard && [self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
      
#ifdef __IPHONE_7_0
      UITextField *searchField = [self valueForKey:@"_searchField"];
      searchField.keyboardAppearance = UIKeyboardAppearanceDark;
#else
      self.keyboardAppearance = UIKeyboardAppearanceAlert;
#endif
      
   } /* End if () */
   else {
      
#ifdef __IPHONE_7_0
      UITextField *searchField = [self valueForKey:@"_searchField"];
      searchField.keyboardAppearance = UIKeyboardAppearanceDefault;
#else
      self.keyboardAppearance = UIKeyboardAppearanceDefault;
#endif
      
   } /* End else */
   
   return;
}

@end
