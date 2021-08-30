//
//  UIImpactFeedbackGenerator+Shortcut.h
//  IDEAUIKit
//
//  Created by Harry on 2021/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImpactFeedbackGenerator (Shortcut)

// UIImpactFeedbackStyleLight,
// UIImpactFeedbackStyleMedium,
// UIImpactFeedbackStyleHeavy,
// UIImpactFeedbackStyleSoft     API_AVAILABLE(ios(13.0)),
// UIImpactFeedbackStyleRigid    API_AVAILABLE(ios(13.0))

/// call when your UI element impacts something else
+ (void)impactOccurredWithStyle:(UIImpactFeedbackStyle)aStyle API_AVAILABLE(ios(10.0));;

#ifdef __IPHONE_13_0
/// call when your UI element impacts something else with a specific intensity [0.0, 1.0]
+ (void)impactOccurredWithStyle:(UIImpactFeedbackStyle)aStyle Intensity:(CGFloat)aIntensity API_AVAILABLE(ios(13.0));
#endif /* __IPHONE_13_0 */

@end

NS_ASSUME_NONNULL_END
