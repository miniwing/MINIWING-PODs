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

@end

@interface UINavigationBarX ()

@property (nonatomic, weak)   IBOutlet       NSLayoutConstraint                  * navigationBarT;
@property (nonatomic, weak)   IBOutlet       NSLayoutConstraint                  * navigationBarB;
@property (nonatomic, weak)   IBOutlet       NSLayoutConstraint                  * navigationBarL;
@property (nonatomic, weak)   IBOutlet       NSLayoutConstraint                  * navigationBarR;

@property (nonatomic, weak)   IBOutlet       NSLayoutConstraint                  * splitViewB;
@property (nonatomic, weak)   IBOutlet       NSLayoutConstraint                  * splitViewL;
@property (nonatomic, weak)   IBOutlet       NSLayoutConstraint                  * splitViewR;
@property (nonatomic, weak)   IBOutlet       NSLayoutConstraint                  * splitViewH;

@end

@interface UINavigationBarX (Inner)

@end

NS_ASSUME_NONNULL_END
