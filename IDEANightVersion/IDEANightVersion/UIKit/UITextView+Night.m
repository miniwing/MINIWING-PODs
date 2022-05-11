//
//  UITextView+Night.m
//  UITextView+Night
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UITextView+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UITextView ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKPicker> *pickers;

@end

@implementation UITextView (Night)

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

      originalSelector  = @selector(initWithFrame:textContainer:);
      swizzledSelector  = @selector(dk_initWithFrame:textContainer:);
      
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
   
   UITextView     *stTextView       = [self dk_init];
   
   [stTextView pickers];

   if (self.themeManager.supportsKeyboard) {
      
      if ([self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
         
         stTextView.keyboardAppearance   = UIKeyboardAppearanceDark;
         
      } /* End if () */
      else {
         
         stTextView.keyboardAppearance   = UIKeyboardAppearanceLight;
         
      } /* End else */
      
   } /* End if () */
      
   return stTextView;
}

- (instancetype)dk_initWithCoder:(NSCoder *)aCoder {
   
   UITextView     *stTextView       = [self dk_initWithCoder:aCoder];
   
   [stTextView pickers];

   if (self.themeManager.supportsKeyboard) {
      
      if ([self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
         
         stTextView.keyboardAppearance   = UIKeyboardAppearanceDark;
         
      } /* End if () */
      else {
         
         stTextView.keyboardAppearance   = UIKeyboardAppearanceLight;
         
      } /* End else */
      
   } /* End if () */
   
   return stTextView;
}

- (instancetype)dk_initWithFrame:(CGRect)aFrame {
   
   UITextView     *stTextView       = [self dk_initWithFrame:aFrame];
   
   [stTextView pickers];

   if (self.themeManager.supportsKeyboard) {
      
      if ([self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
         
         stTextView.keyboardAppearance   = UIKeyboardAppearanceDark;
         
      } /* End if () */
      else {
         
         stTextView.keyboardAppearance   = UIKeyboardAppearanceLight;
         
      } /* End else */
      
   } /* End if () */
   
   return stTextView;
}

- (instancetype)dk_initWithFrame:(CGRect)aFrame textContainer:(NSTextContainer *)aTextContainer {
   
   UITextView     *stTextView       = [self dk_initWithFrame:aFrame textContainer:aTextContainer];
   
   [stTextView pickers];

   if (self.themeManager.supportsKeyboard) {
      
      if ([self.themeManager.themeVersion isEqualToString:DKThemeVersionNight]) {
         
         stTextView.keyboardAppearance   = UIKeyboardAppearanceDark;
         
      } /* End if () */
      else {
         
         stTextView.keyboardAppearance   = UIKeyboardAppearanceLight;
         
      } /* End else */
      
   } /* End if () */
   
//   [[NSNotificationCenter defaultCenter] removeObserver:stTextView
//                                                   name:DKNightVersionThemeChangingNotification
//                                                 object:nil];
//   //      [[NSNotificationCenter defaultCenter] removeObserver:self];
//
//   [[NSNotificationCenter defaultCenter] addObserver:stTextView
//                                            selector:@selector(night_updateColor:)
//                                                name:DKNightVersionThemeChangingNotification
//                                              object:nil];

   return stTextView;
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

// Harry FIXED
- (void)night_updateColor:(NSNotification *)aNotification {

   [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull aSelector, DKPicker _Nonnull aPicker, BOOL * _Nonnull aStop) {

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
      
//      if (@available(iOS 13.0, *)) {
//         
//      } /* End if () */
//      else {
//         
//#warning " 强制刷新键盘外观 "
//         [UIView performWithoutAnimation:^{
//            
//            [self resignFirstResponder];
//            [self becomeFirstResponder];
//         }];
//         
//      } /* End else */
      
   } /* End if () */

   return;
}

@end
