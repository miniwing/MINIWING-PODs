//
//  IDEACapsuleButton.h
//  IDEAUIVendor
//
//  Created by Harry on 2024/8/18.
//
//  Mail: miniwing.hz@gmail.com
//

#import <UIKit/UIKit.h>

#import <IDEANightVersion/DKColor.h>

NS_ASSUME_NONNULL_BEGIN

// IB_DESIGNABLE
@interface IDEACapsuleButton : UIView

@property (nonatomic, weak)   IBOutlet       UIView                              * containerView;

@property (nonatomic, weak)   IBOutlet       UIButton                            * moreButton;
@property (nonatomic, weak)   IBOutlet       UIView                              * separationView;
@property (nonatomic, weak)   IBOutlet       UIButton                            * stopButton;

@property (nonatomic, weak)   IBOutlet       UIView                              * trailingView;

@end

// IB_DESIGNABLE
@interface IDEACapsuleButton ()

@property (class, nonatomic, readonly)       CGFloat                               fixedWidth;

@end

typedef void (^IDEACapsuleActionBlock) (IDEACapsuleButton * aCapsuleButton);

// IB_DESIGNABLE
@interface IDEACapsuleButton ()

@property (nonatomic, copy)                  IDEACapsuleActionBlock                actionMoreBlock;
@property (nonatomic, copy)                  IDEACapsuleActionBlock                actionDoneBlock;

@end

// IB_DESIGNABLE
@interface IDEACapsuleButton ()

- (void)setTintColor:(UIColor *)aTintColor;
- (void)setTintColorPicker:(DKColorPicker)aTintColorPicker;

@end

NS_ASSUME_NONNULL_END
