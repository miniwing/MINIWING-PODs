//
//  UINavigationBarX+Inner.h
//  IDEAUIKit
//
//  Created by Harry on 2022/3/25.
//
//  Mail: miniwing.hz@gmail.com
//

#import "UINavigationBarX.h"

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBarX ()

@property (nonatomic, strong)                NSLayoutConstraint                  * navigationBarT;
@property (nonatomic, strong)                NSLayoutConstraint                  * navigationBarB;
@property (nonatomic, strong)                NSLayoutConstraint                  * navigationBarL;
@property (nonatomic, strong)                NSLayoutConstraint                  * navigationBarR;

@end

@interface UINavigationBarX (Inner)

@end

NS_ASSUME_NONNULL_END
