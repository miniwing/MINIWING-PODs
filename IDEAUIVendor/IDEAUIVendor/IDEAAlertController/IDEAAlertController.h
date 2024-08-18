//
//  IDEAAlertController.h
//  IDEAUIVendor
//
//  Created by Harry on 2022/6/21.
//
//  Mail: miniwing.hz@gmail.com
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEAAlertController : UIAlertController

@end

#if TARGET_OS_IOS
typedef void (^IDEAAlertControllerPopoverPresentationControllerBlock) (UIPopoverPresentationController * aPopover);
#endif
typedef void (^IDEAAlertControllerThemeBlock) (IDEAAlertController * aController, NSArray<UIAlertAction *> *aActions);
typedef void (^IDEAAlertControllerCompletionBlock) (IDEAAlertController * aController, UIAlertAction * aAction, NSInteger aButtonIndex);

@interface IDEAAlertController ()

+ (instancetype)showInViewController:(UIViewController *)aViewController
                  userInterfaceStyle:(UIUserInterfaceStyle)aUserInterfaceStyle
                           withTitle:(NSString *)aTitle
                             message:(NSString *)aMessage
                      preferredStyle:(UIAlertControllerStyle)aPreferredStyle
                   cancelButtonTitle:(NSString *)aCancelButtonTitle
              destructiveButtonTitle:(NSString *)aDestructiveButtonTitle
                   otherButtonTitles:(NSArray<NSString *> *)aOtherButtonTitles
#if TARGET_OS_IOS
  popoverPresentationControllerBlock:(IDEAAlertControllerPopoverPresentationControllerBlock)aPopoverPresentationControllerBlock
#endif
                          themeBlock:(IDEAAlertControllerThemeBlock)aThemeBlock
                            tapBlock:(IDEAAlertControllerCompletionBlock)aTapBlock;

+ (instancetype)showAlertInViewController:(UIViewController *)aViewController
                       userInterfaceStyle:(UIUserInterfaceStyle)aUserInterfaceStyle
                                withTitle:(NSString *)aTitle
                                  message:(NSString *)aMessage
                        cancelButtonTitle:(NSString *)aCancelButtonTitle
                   destructiveButtonTitle:(NSString *)aDestructiveButtonTitle
                        otherButtonTitles:(NSArray<NSString *> *)aOtherButtonTitles
                               themeBlock:(IDEAAlertControllerThemeBlock)aThemeBlock
                                 tapBlock:(IDEAAlertControllerCompletionBlock)aTapBlock;

+ (instancetype)showActionSheetInViewController:(UIViewController *)aViewController
                             userInterfaceStyle:(UIUserInterfaceStyle)aUserInterfaceStyle
                                      withTitle:(NSString *)aTitle
                                        message:(NSString *)aMessage
                              cancelButtonTitle:(NSString *)aCancelButtonTitle
                         destructiveButtonTitle:(NSString *)aDestructiveButtonTitle
                              otherButtonTitles:(NSArray<NSString *> *)aOtherButtonTitles
#if TARGET_OS_IOS
             popoverPresentationControllerBlock:(IDEAAlertControllerPopoverPresentationControllerBlock)aPopoverPresentationControllerBlock
#endif
                                     themeBlock:(IDEAAlertControllerThemeBlock)aThemeBlock
                                       tapBlock:(IDEAAlertControllerCompletionBlock)aTapBlock;
@end

NS_ASSUME_NONNULL_END
