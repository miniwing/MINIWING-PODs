//
//  UIViewController+Keyboard.h
//  UIViewController+Keyboard
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail:miniwing.hz@gmail.com
//  TEL :+(852)53054612
//

#import <UIKit/UIKit.h>

//UIKIT_EXTERN NSString * const kAnimateKeyboardOpen;
//UIKIT_EXTERN NSString * const kAnimateKeyboarClose;

@interface UIView (Keyboard)

- (void)registerKeyboardNotifications;
- (void)unregisterKeyboardNotifications;

//- (void)keyboardWillShow:(NSNotification *)aNotification;
//- (void)keyboardDidShow:(NSNotification *)aNotification;
//- (void)keyboardWillHide:(NSNotification *)aNotification;
//- (void)keyboardDidHide:(NSNotification *)aNotification;

@end

@interface UIViewController (Keyboard)

- (void)registerKeyboardNotifications;
- (void)unregisterKeyboardNotifications;

//- (void)keyboardWillShow:(NSNotification *)aNotification;
//- (void)keyboardDidShow:(NSNotification *)aNotification;
//- (void)keyboardWillHide:(NSNotification *)aNotification;
//- (void)keyboardDidHide:(NSNotification *)aNotification;

@end
