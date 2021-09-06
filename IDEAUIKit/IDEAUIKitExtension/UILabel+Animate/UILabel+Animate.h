//
//  UILabel+Animate.h
//  UILabel+Animate
//
//  Created by Harry on 2021/3/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Animate)

- (void)setText:(NSString *)aText animated:(BOOL)aAnimated completion:(void (^ __nullable)(void))aCompletion;

@end

NS_ASSUME_NONNULL_END
