//
//  IDEAPopController.h
//  IDEAPopController
//
//  Copyright © 2020 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <IDEAPopController/IDEAPopControllerAnimationProtocol.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IDEAPopPosition) {
	IDEAPopPositionCenter,
	IDEAPopPositionTop,
	IDEAPopPositionBottom,
};

typedef NS_ENUM(NSInteger, IDEAPopState) {
    IDEAPopStatePop,      // present
    IDEAPopStateDismiss,  // dismiss
};

typedef NS_ENUM(NSInteger, IDEAPopType) {
    IDEAPopTypeNone,
    IDEAPopTypeFadeIn,
    IDEAPopTypeGrowIn,
    IDEAPopTypeShrinkIn,
    IDEAPopTypeSlideInFromTop,
    IDEAPopTypeSlideInFromBottom,
    IDEAPopTypeSlideInFromLeft,
    IDEAPopTypeSlideInFromRight,
    IDEAPopTypeBounceIn,
    IDEAPopTypeBounceInFromTop,
    IDEAPopTypeBounceInFromBottom,
    IDEAPopTypeBounceInFromLeft,
    IDEAPopTypeBounceInFromRight,
};

typedef NS_ENUM(NSInteger, IDEADismissType) {
    IDEADismissTypeNone,
    IDEADismissTypeFadeOut,
    IDEADismissTypeGrowOut,
    IDEADismissTypeShrinkOut,
    IDEADismissTypeSlideOutToTop,
    IDEADismissTypeSlideOutToBottom,
    IDEADismissTypeSlideOutToLeft,
    IDEADismissTypeSlideOutToRight,
    IDEADismissTypeBounceOut,
    IDEADismissTypeBounceOutToTop,
    IDEADismissTypeBounceOutToBottom,
    IDEADismissTypeBounceOutToLeft,
    IDEADismissTypeBounceOutToRight,
};

@interface IDEAPopController : NSObject

#pragma mark - config properties

/**
 //////////////////////////////////////////////////////
 Below props should be set when you pop the controller.
 //////////////////////////////////////////////////////
 */

/**
 * pop animation style
 * default is IDEAPopTypeGrowIn
 */
@property (nonatomic, assign) IDEAPopType popType;
/**
 * dismiss animation style
 * default is IDEADismissTypeFadeOut
 */
@property (nonatomic, assign) IDEADismissType dismissType;
/**
 * animation duration
 * default is 0.2 s
 */
@property (nonatomic, assign) NSTimeInterval animationDuration;
/**
 * The pop view final position.
 * Default is IDEAPopPositionCenter
 */
@property (nonatomic, assign) IDEAPopPosition popPosition;
/**
 * The offset of the pop view.
 */
@property (nonatomic, assign) CGPoint positionOffset;
/**
 * You can custom your own animation for pop and dismiss.
 * once you set this property, and NOT nil,
 * the `popType` and `dismissType` will be ignore.
 */
@property (nonatomic, weak) id<IDEAPopControllerAnimationProtocol> animationProtocol;
@property (nonatomic, assign) UIEdgeInsets safeAreaInsets;

/**
 //////////////////////////////////////////////////////
 Below props can be set when you need.
 //////////////////////////////////////////////////////
 */

/**
 * The background when popup. You can set it as `UIImageView`, `UIVisualEffectView` such as.
 */
@property (nullable, nonatomic, strong) UIView *backgroundView;
/**
 * pop background alpha.
 * default is 0.5
 */
@property (nonatomic, assign) CGFloat backgroundAlpha;
/**
 * determine touch background to dismiss
 * Default is YES.
 */
@property (nonatomic, assign) BOOL shouldDismissOnBackgroundTouch;

#pragma mark - readonly properties

/**
 * Hold the pop view container.
 * Default the backgroundColor is White.
 * Default the corner radius is 8.0f.
 * If you want to custom corner, change containerView layer.
 */
@property (nonatomic, strong, readonly) UIView *containerView;
/**
 * Which view the popped ViewController view added.
 */
@property (nonatomic, strong, readonly) UIView *contentView;

/**
 * topViewController is the viewController which is presented.
 */
@property (nonatomic, strong, readonly) UIViewController *topViewController;
@property (nonatomic, assign, readonly) BOOL presented;

/**
 * init PopController
 * @param presentedViewController the controller which will be presented
 */
- (instancetype)initWithViewController:(UIViewController *)presentedViewController;

/**
 * pop controller
 * @param presentingViewController which controller to present.
 */
- (void)presentInViewController:(UIViewController *)presentingViewController;

- (void)presentInViewController:(UIViewController *)presentingViewController completion:(nullable void (^)(void))completion;

- (void)dismiss;

- (void)dismissWithCompletion:(nullable void (^)(void))completion;

- (void)layoutContainerView;

@end

NS_ASSUME_NONNULL_END
