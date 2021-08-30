//
//  IDEAPresentationController.h
//  IDEAUIVendor
//
//  Created by Harry on 2021/2/4.
//  Copyright © 2021 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IDEAPresentationControllerDelegate <NSObject>

@optional
- (CGRect)frameOfPresented;
- (BOOL)backgroundTouchToClose;

@end

@interface IDEAPresentationController : UIPresentationController

//@property (nonatomic, weak, nullable)      id<IDEAPresentationControllerDelegate>  presentationDelegate;

@end

@interface IDEAPresentationController (UIStoryboard)

@property (class, nonatomic, readonly)       NSString                            * storyboard;

@end

@interface UIViewController (PopUp) <UIViewControllerTransitioningDelegate, IDEAPresentationControllerDelegate>

//@property (nonatomic, weak, setter = setPresentationDelegate:) id<IDEAPresentationControllerDelegate>  presentationDelegate;

- (void)popUp:(UIViewController<IDEAPresentationControllerDelegate> *)aViewController;
- (void)popUp:(UIViewController<IDEAPresentationControllerDelegate> *)aViewController animated: (BOOL)aAnimated completion:(void (^ __nullable)(void))aCompletion;

@end

NS_ASSUME_NONNULL_END
