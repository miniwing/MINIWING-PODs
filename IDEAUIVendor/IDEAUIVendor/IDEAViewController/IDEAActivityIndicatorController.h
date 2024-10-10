//
//  IDEAActivityIndicatorController.h
//  IDEAUIVendor
//
//  Created by Harry on 2021/6/8.
//

#import <UIKit/UIKit.h>

#import <IDEAUIVendor/IDEAViewController.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface IDEAActivityIndicatorController : IDEAViewController

#if MATERIAL_ACTIVITY_INDICATOR
//@property (nullable, nonatomic, copy) IBInspectable
@property (nonatomic, strong) IBOutlet       MDCActivityIndicator                * activityIndicator;
#else /* MATERIAL_ACTIVITY_INDICATOR */
@property (nonatomic, strong) IBOutlet       UIActivityIndicatorView             * activityIndicator;
#endif /* !MATERIAL_ACTIVITY_INDICATOR */

@property (nonatomic, assign) IBInspectable  CGFloat                               activityIndicatorRadius;

@end

NS_ASSUME_NONNULL_END
