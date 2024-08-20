//
//  IDEACapsuleButton.h
//  Pods
//
//  Created by Harry on 2024/8/18.
//
//  Mail: miniwing.hz@gmail.com
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//IB_DESIGNABLE
@interface IDEACapsuleButton : UIView

@property (nonatomic, weak)   IBOutlet       UIView                              * containerView;

@property (nonatomic, weak)   IBOutlet       UIButton                            * moreButton;
@property (nonatomic, weak)   IBOutlet       UIView                              * separationView;
@property (nonatomic, weak)   IBOutlet       UIButton                            * stopButton;

@property (nonatomic, weak)   IBOutlet       UIView                              * trailingView;

@end

//IB_DESIGNABLE
@interface IDEACapsuleButton ()

@property (class, nonatomic, readonly)       CGFloat                               fixedWidth;

@end

//IB_DESIGNABLE
@interface IDEACapsuleButton (Notification)

@property (class, nonatomic, readonly)       NSString                            * moreNotification;
@property (class, nonatomic, readonly)       NSString                            * doneNotification;

@end

NS_ASSUME_NONNULL_END
