//
//  UITextField+Keyboard.m
//  DKNightVersion
//
//  Created by Draveness on 16/4/11.
//  Copyright © 2016年 Draveness. All rights reserved.
//

#import "UITextField+Keyboard.h"
#import "NSObject+Night.h"
#import <objc/runtime.h>

@interface NSObject ()

- (void)night_updateColor:(NSNotification *)aNotification;

@end

@implementation UITextField (Keyboard)

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
   
   UITextField    *stTextField            = [self dk_init];
   
   if (self.themeManager.supportsKeyboard) {
      
      if ([self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
         
#ifdef __IPHONE_7_0
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDark;
#else
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDefault;
#endif
         
      } /* End if () */
      else {
         
#ifdef __IPHONE_7_0
         stTextField.keyboardAppearance   = UIKeyboardAppearanceLight;
#else
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDefault;
#endif
         
      } /* End else */
      
   } /* End if () */
   
   return stTextField;
}

- (instancetype)dk_initWithFrame:(CGRect)aFrame {
   
   UITextField    *stTextField            = [self dk_initWithFrame:aFrame];
   
   if (self.themeManager.supportsKeyboard) {
      
      if ([self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
         
#ifdef __IPHONE_7_0
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDark;
#else
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDefault;
#endif
         
      } /* End if () */
      else {
         
#ifdef __IPHONE_7_0
         stTextField.keyboardAppearance   = UIKeyboardAppearanceLight;
#else
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDefault;
#endif
         
      } /* End else */
      
   } /* End if () */
   
   return stTextField;
}

- (instancetype)dk_initWithCoder:(NSCoder *)aCoder {
   
   UITextField    *stTextField            = [self dk_initWithCoder:aCoder];
   
   if (self.themeManager.supportsKeyboard) {
      
      if ([self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
         
#ifdef __IPHONE_7_0
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDark;
#else
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDefault;
#endif
         
      } /* End if () */
      else {
         
#ifdef __IPHONE_7_0
         stTextField.keyboardAppearance   = UIKeyboardAppearanceLight;
#else
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDefault;
#endif
         
      } /* End else */
      
   } /* End if () */
   
   return stTextField;
}

- (void)night_updateColor:(NSNotification *)aNotification {

   [super night_updateColor:aNotification];
   
   if (self.themeManager.supportsKeyboard) {
      
      if ([self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
         
#ifdef __IPHONE_7_0
         self.keyboardAppearance = UIKeyboardAppearanceDark;
#else
         self.keyboardAppearance = UIKeyboardAppearanceDefault;
#endif
         
      } /* End if () */
      else {
         
#ifdef __IPHONE_7_0
         self.keyboardAppearance = UIKeyboardAppearanceDark;
#else
         self.keyboardAppearance = UIKeyboardAppearanceDefault;
#endif
         
      } /* End else */
      
   } /* End if () */
   
   return;
}

@end
