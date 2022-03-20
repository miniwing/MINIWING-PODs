//
//  UITextFieldX.h
//  IDEAUIKit
//
//  Created by Harry on 2022/3/18.
//
//  Mail: miniwing.hz@gmail.com
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextFieldX : UITextField

@end

@interface UITextFieldX ()

//@property (nonatomic, assign)                UIEdgeInsets                          contentEdgeInset;
@property (nonatomic, assign)                CGFloat                               edgeX;
@property (nonatomic, assign)                CGFloat                               edgeY;

@end

NS_ASSUME_NONNULL_END
