//
//  UIAlertController+Blocks.h
//  UIAlertController+Blocks
//
//  Created by Ryan Maxwell on 11/09/14.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Ryan Maxwell
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>

#if TARGET_OS_IOS
typedef void (^UIAlertControllerPopoverPresentationControllerBlock) (UIPopoverPresentationController * aPopover);
#endif
typedef void (^UIAlertControllerCompletionBlock) (UIAlertController * aController, UIAlertAction * aAction, NSInteger aButtonIndex);

@interface UIAlertController (Blocks)

+ (instancetype)showInViewController:(UIViewController *)aViewController
                           withTitle:(NSString *)aTitle
                             message:(NSString *)aMessage
                      preferredStyle:(UIAlertControllerStyle)aPreferredStyle
                   cancelButtonTitle:(NSString *)aCancelButtonTitle
              destructiveButtonTitle:(NSString *)aDestructiveButtonTitle
                   otherButtonTitles:(NSArray *)aOtherButtonTitles
#if TARGET_OS_IOS
  popoverPresentationControllerBlock:(UIAlertControllerPopoverPresentationControllerBlock)aPopoverPresentationControllerBlock
#endif
                            tapBlock:(UIAlertControllerCompletionBlock)aTapBlock;

+ (instancetype)showAlertInViewController:(UIViewController *)aViewController
                                withTitle:(NSString *)aTitle
                                  message:(NSString *)aMessage
                        cancelButtonTitle:(NSString *)aCancelButtonTitle
                   destructiveButtonTitle:(NSString *)aDestructiveButtonTitle
                        otherButtonTitles:(NSArray *)aOtherButtonTitles
                                 tapBlock:(UIAlertControllerCompletionBlock)aTapBlock;


+ (instancetype)showActionSheetInViewController:(UIViewController *)aViewController
                                      withTitle:(NSString *)aTitle
                                        message:(NSString *)aMessage
                              cancelButtonTitle:(NSString *)aCancelButtonTitle
                         destructiveButtonTitle:(NSString *)aDestructiveButtonTitle
                              otherButtonTitles:(NSArray *)aOtherButtonTitles
#if TARGET_OS_IOS
             popoverPresentationControllerBlock:(UIAlertControllerPopoverPresentationControllerBlock)aPopoverPresentationControllerBlock
#endif
                                       tapBlock:(UIAlertControllerCompletionBlock)aTapBlock;


@property (readonly, nonatomic) BOOL visible;
@property (readonly, nonatomic) NSInteger cancelButtonIndex;
@property (readonly, nonatomic) NSInteger firstOtherButtonIndex;
@property (readonly, nonatomic) NSInteger destructiveButtonIndex;

@end
