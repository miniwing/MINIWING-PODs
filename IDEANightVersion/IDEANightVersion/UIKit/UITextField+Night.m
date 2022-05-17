//
//  UITextField+Night.m
//  UITextField+Night
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UITextField+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UITextField ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *pickers;

@end

@implementation UITextField (Night)

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
      
      originalSelector  = @selector(initWithFrame:primaryAction:);
      swizzledSelector  = @selector(dk_initWithFrame:primaryAction:);
      
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
   
   UITextField    *stTextField      = [self dk_init];
   
   if (self.themeManager.supportsKeyboard) {
      
      if ([self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDark;
         
      } /* End if () */
      else {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceLight;
         
      } /* End else */
      
   } /* End if () */

   return stTextField;
}

- (instancetype)dk_initWithCoder:(NSCoder *)aCoder {
   
   UITextField    *stTextField      = [self dk_initWithCoder:aCoder];
   
   if (self.themeManager.supportsKeyboard) {
      
      if ([self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDark;
         
      } /* End if () */
      else {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceLight;
         
      } /* End else */
      
   } /* End if () */

   return stTextField;
}

- (instancetype)dk_initWithFrame:(CGRect)aFrame {
   
   UITextField    *stTextField      = [self dk_initWithFrame:aFrame];
   
   if (self.themeManager.supportsKeyboard) {
      
      if ([self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDark;
         
      } /* End if () */
      else {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceLight;
         
      } /* End else */
      
   } /* End if () */

   return stTextField;
}

- (instancetype)dk_initWithFrame:(CGRect)aFrame primaryAction:(UIAction *)aPrimaryAction API_AVAILABLE(ios(14.0)) {
   
   UITextField    *stTextField      = [self dk_initWithFrame:aFrame primaryAction:aPrimaryAction];
   
   if (self.themeManager.supportsKeyboard) {
      
      if ([self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceDark;
         
      } /* End if () */
      else {
         
         stTextField.keyboardAppearance   = UIKeyboardAppearanceLight;
         
      } /* End else */
      
   } /* End if () */

   return stTextField;
}

- (DKColorPicker)textColorPicker {
   
   return objc_getAssociatedObject(self, @selector(textColorPicker));
}

- (void)setTextColorPicker:(DKColorPicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(textColorPicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);

   if (nil != aPicker) {
      
      self.textColor = aPicker(self.themeManager.themeVersion);
      [self.pickers setValue:[aPicker copy] forKey:@"setTextColor:"];
      
   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:@"setTextColor:"];
      
   } /* End else */

   return;
}

- (DKColorPicker)placeholderColorPicker {
   
   return objc_getAssociatedObject(self, @selector(placeholderColorPicker));
}

- (void)setPlaceholderColorPicker:(DKColorPicker)aPicker {
   
   objc_setAssociatedObject(self, @selector(placeholderColorPicker), aPicker, OBJC_ASSOCIATION_COPY_NONATOMIC);

   if (nil != aPicker) {
            
      [self setPlaceholderColor:aPicker(self.themeManager.themeVersion)];
      
      [self.pickers setValue:[aPicker copy] forKey:@"setPlaceholderColor:"];

   } /* End if () */
   else {
      
      [self.pickers removeObjectForKey:@"setPlaceholderColor:"];
      
   } /* End else */
   
   return;
}

- (void)setPlaceholderColor:(UIColor *)aColor {
   
   if (nil != aColor && nil != self.placeholder) {
      
      NSAttributedString   *stPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder
                                                                            attributes:@{NSForegroundColorAttributeName:aColor}];
      [self setAttributedPlaceholder:stPlaceholder];

   } /* End if () */

   return;
}

// Harry FIXED
- (void)night_updateColor:(NSNotification *)aNotification {

   [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull aSelector, DKPicker _Nonnull aPicker, BOOL * _Nonnull aStop) {

//      if ([aSelector isEqualToString:NSStringFromSelector(@selector(setBackgroundColor:))]) {
//
//         UIColor *stColor = ((DKColorPicker)aPicker)(self.themeManager.themeVersion);
//
//         [self setBackgroundColor:stColor];
//
//      }
//      else {
//
//         SEL stSEL      = NSSelectorFromString(aSelector);
//         id  stResult   = aPicker(self.themeManager.themeVersion);
//
//         [UIView animateWithDuration:DKNightVersionAnimationDuration
//                          animations:^{
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//            [self performSelector:stSEL withObject:stResult];
//#pragma clang diagnostic pop
//         }];
//
//      } /* End else */

      SEL stSEL      = NSSelectorFromString(aSelector);
      id  stResult   = aPicker(self.themeManager.themeVersion);

      [UIView animateWithDuration:DKNightVersionAnimationDuration
                       animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
         [self performSelector:stSEL withObject:stResult];
#pragma clang diagnostic pop
      }];
   }];
   
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
         self.keyboardAppearance = UIKeyboardAppearanceLight;
#else
         self.keyboardAppearance = UIKeyboardAppearanceDefault;
#endif
      } /* End else */

      if (@available(iOS 13.0, *)) {
         
      } /* End if () */
      else {
         
#warning " 刷新键盘外观 "
//         [UIView performWithoutAnimation:^{
//
//            [self resignFirstResponder];
//            [self becomeFirstResponder];
//         }];
         
         [self resignFirstResponder];

      } /* End else */

   } /* End if () */

   return;
}

@end
