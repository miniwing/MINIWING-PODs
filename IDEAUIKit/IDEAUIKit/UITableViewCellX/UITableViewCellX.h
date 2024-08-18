//
//  UITableViewCellX.h
//  IDEAUIKit
//
//  Created by Harry on 2022/3/19.
//
//  Mail: miniwing.hz@gmail.com
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define UIRectCornerNone                     (0)
#define UITableViewXStyleInsetGrouped        (3)

@interface UITableViewCellX : UITableViewCell

@property (nonatomic, weak)   IBOutlet       UIView                              * containerView;
@property (nonatomic, weak)   IBOutlet       UIView                              * separatorView;

@end

@interface UITableViewCellX ()

@property (nonatomic, assign)                NSInteger                             tableViewXStyle;

@property (nonatomic, class, readonly)       CGFloat                               cornerRadii;
@property (nonatomic, class, readonly)       CGFloat                               constraintLeftInset;
@property (nonatomic, class, readonly)       CGFloat                               constraintRightInset;

@end

@interface UITableViewCellX ()

- (void)setRectCorner:(UIRectCorner)aRectCorner;

@end

NS_ASSUME_NONNULL_END
