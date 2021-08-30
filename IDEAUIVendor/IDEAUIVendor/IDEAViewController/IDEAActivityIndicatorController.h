//
//  IDEAActivityIndicatorController.h
//  IDEAUIVendor
//
//  Created by Harry on 2021/6/8.
//

#import <UIKit/UIKit.h>

#import <IDEAUIVendor/IDEAViewController.h>

#if __has_include(<MaterialComponents/MaterialActivityIndicator.h>)
#  import <MaterialComponents/MaterialActivityIndicator.h>
#elif __has_include("MaterialComponents/MaterialActivityIndicator.h")
#  import "MaterialComponents/MaterialActivityIndicator.h"
#elif __has_include("MaterialActivityIndicator.h")
#  import "MaterialActivityIndicator.h"
#else
#endif

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface IDEAActivityIndicatorController : IDEAViewController

#if MATERIAL_COMPONENTS
//@property (nullable, nonatomic, copy) IBInspectable
@property (nonatomic, strong) IBOutlet       MDCActivityIndicator                * activityIndicator;
#else /* MATERIAL_COMPONENTS */
@property (nonatomic, strong) IBOutlet       UIActivityIndicatorView             * activityIndicator;
#endif /* !MATERIAL_COMPONENTS */

@property (nonatomic, assign) IBInspectable  CGFloat                               activityIndicatorRadius;

@end

@interface IDEAActivityIndicatorController ()

@end

NS_ASSUME_NONNULL_END
