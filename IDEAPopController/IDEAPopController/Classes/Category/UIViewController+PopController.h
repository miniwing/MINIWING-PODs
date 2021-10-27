//
//  UIViewController+IDEAPopController.h
//  IDEAPopController
//
//  Copyright © 2020 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IDEAPopController/IDEAPopController.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (IDEAPopController)

/**
 * pop size for portrait orientation.
 */
@property (nonatomic, assign) IBInspectable CGSize contentSizeInPop;
/**
 * pop size for landscape orientation
 */
@property (nonatomic, assign) IBInspectable CGSize contentSizeInPopWhenLandscape;

/**
 * The pop ViewController referred IDEAPopController
 */
@property (nullable, nonatomic, weak, readonly) IDEAPopController *popController;

@end

@interface UIViewController (IDEAPop)

/**
 * The controller which will be pop call this method to popup.
 * Use default param.
 * @return IDEAPopController
 */
- (IDEAPopController *)popup;

- (IDEAPopController *)popupWithPopType:(IDEAPopType)popType
                          dismissType:(IDEADismissType)dismissType;

- (IDEAPopController *)popupWithPopType:(IDEAPopType)popType
                          dismissType:(IDEADismissType)dismissType
                             position:(IDEAPopPosition)popPosition;

- (IDEAPopController *)popupWithPopType:(IDEAPopType)popType
                          dismissType:(IDEADismissType)dismissType
                             position:(IDEAPopPosition)popPosition
             dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch;

- (IDEAPopController *)popupWithPopType:(IDEAPopType)popType
                          dismissType:(IDEADismissType)dismissType
                             position:(IDEAPopPosition)popPosition
                     inViewController:(UIViewController *)inViewController
             dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch;
@end

NS_ASSUME_NONNULL_END
