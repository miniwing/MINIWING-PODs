//
//  IDEATabBarControllerLayerContext.h
//  IDEATabBarControllerTransition
//
//  Created by Harry on 2021/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEATabBarControllerLayerContext : NSObject

@property (nonatomic, weak)                  CALayer                             * viewLayer;

@property (nonatomic, strong)                CALayer                             * toNavigationBarLayer;
@property (nonatomic, strong)                CALayer                             * toLayer;
@property (nonatomic, strong)                CALayer                             * fromNavigationBarLayer;
@property (nonatomic, strong)                CALayer                             * fromLayer;

@property (nonatomic, strong)                CALayer                             * fakeTabbarLayer;

@end

@interface IDEATabBarControllerLayerContext ()

+ (instancetype)layerContext:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;
- (void)reset;

@end

@interface IDEATabBarControllerLayerContext ()

/**
 *  Unavailable initializer
 */
+ (instancetype)new NS_UNAVAILABLE;

/**
 *  Unavailable initializer
 */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
