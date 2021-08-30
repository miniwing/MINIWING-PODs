//
//  UIViewController+Separator.h
//  Interview
//
//  Created by Harry on 2021/02/25.
//  Copyright © 2021 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NAVIGATIONBAR_SEPARATOR_LEFT_MARGIN        (0)
#define NAVIGATIONBAR_SEPARATOR_RIGHT_MARGIN       (0)

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Separator)

- (void)setSeparator;
- (void)removeSeparator;

@end

NS_ASSUME_NONNULL_END
