//
//  UINotificationFeedbackGenerator+Shortcut.h
//  UINotificationFeedbackGenerator+Shortcut
//
//  Created by Harry on 2021/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINotificationFeedbackGenerator (Shortcut)

// UINotificationFeedbackTypeSuccess,
// UINotificationFeedbackTypeWarning,
// UINotificationFeedbackTypeError

+ (void)notificationOccurred:(UINotificationFeedbackType)aNotificationType API_AVAILABLE(ios(10.0));

@end

NS_ASSUME_NONNULL_END
