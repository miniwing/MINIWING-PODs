//
//  UICollectionViewX.h
//  IDEAUIKit
//
//  Created by Harry on 2022/3/19.
//
//  Mail: miniwing.hz@gmail.com
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define UIRectCornerNone                     (0)
#define UICollectionViewXStyleInsetGrouped   (3)

@interface UICollectionViewCellX : UICollectionViewCell

@property (nonatomic, weak)   IBOutlet       UIView                              * containerView;

@end

@interface UICollectionViewCellX ()

@property (nonatomic, assign)                NSInteger                             collectionViewXStyle;

@end

@interface UICollectionViewCellX ()

+ (CGFloat)cornerRadii;
+ (CGFloat)constraintLeftInset;
+ (CGFloat)constraintRightInset;

- (void)setRectCorner:(UIRectCorner)aRectCorner;

@end

NS_ASSUME_NONNULL_END
