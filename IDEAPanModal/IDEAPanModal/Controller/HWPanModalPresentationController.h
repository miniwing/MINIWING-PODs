//
//  HWPanModalPresentationController.h
//  HWPanModal
//
//  Created by heath wang on 2019/4/26.
//

#import <UIKit/UIKit.h>
#import "HWPanModalPresentable.h"

@class HWDimmedView;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PanModalPresentationController)
@interface HWPanModalPresentationController : UIPresentationController

@property (nonatomic, readonly) HWDimmedView *backgroundView;
@property (nonatomic, readonly) PresentationState currentPresentationState;

- (void)setNeedsLayoutUpdate;

- (void)updateUserHitBehavior;

- (void)transitionToState:(PresentationState)state animated:(BOOL)animated;

- (void)setScrollableContentOffset:(CGPoint)offset animated:(BOOL)animated;

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
