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

@interface UITableViewCellX : UITableViewCell

@property (nonatomic, weak)   IBOutlet       UIView                              * containerView;

@end

@interface UITableViewCellX ()

- (void)setRectCorner:(UIRectCorner)aRectCorner;

@end

NS_ASSUME_NONNULL_END
