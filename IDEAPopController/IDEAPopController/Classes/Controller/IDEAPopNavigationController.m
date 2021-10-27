//
//  IDEAPopNavigationController.m
//  IDEAPopController
//
//  Copyright © 2020 Harry. All rights reserved.
//

#import "IDEAPopController/IDEAPopNavigationController.h"
#import "IDEAPopController/IDEANavAnimatedTransitioning.h"
#import "IDEAPopController/UIViewController+PopController.h"

@interface IDEAPopNavigationController () <UINavigationControllerDelegate>

@property (nonatomic, strong) IDEANavAnimatedTransitioning *animatedTransitioning;

@property (nonatomic, assign) CGSize originContentSizeInPop;
@property (nonatomic, assign) CGSize originContentSizeInPopWhenLandscape;

@end

@implementation IDEAPopNavigationController

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view.
   self.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
   [super viewWillAppear:animated];
   self.originContentSizeInPop = self.contentSizeInPop;
   self.originContentSizeInPopWhenLandscape = self.contentSizeInPopWhenLandscape;
}

#pragma mark - overwrite

- (void)adjustContentSizeBy:(UIViewController *)controller {
   
   switch ([UIApplication sharedApplication].statusBarOrientation) {
      case UIInterfaceOrientationLandscapeLeft:
      case UIInterfaceOrientationLandscapeRight: {
         CGSize contentSize = controller.contentSizeInPopWhenLandscape;
         if (!CGSizeEqualToSize(contentSize, CGSizeZero)) {
            self.contentSizeInPopWhenLandscape = contentSize;
         } else {
            self.contentSizeInPopWhenLandscape = self.originContentSizeInPopWhenLandscape;
         }
      }
         break;
      default: {
         CGSize contentSize = controller.contentSizeInPop;
         if (!CGSizeEqualToSize(contentSize, CGSizeZero)) {
            self.contentSizeInPop = contentSize;
         } else {
            self.contentSizeInPop = self.originContentSizeInPop;
         }
      }
         break;
   }
   
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
   // call this to perform viewDidLoad
   [toVC view];
   [self adjustContentSizeBy:toVC];
   self.animatedTransitioning.state = operation == UINavigationControllerOperationPush ? IDEAPopStatePop : IDEAPopStateDismiss;
   return self.animatedTransitioning;
}

#pragma mark - Getter


- (IDEANavAnimatedTransitioning *)animatedTransitioning {
   if (!_animatedTransitioning) {
      _animatedTransitioning = [[IDEANavAnimatedTransitioning alloc] initWithState:IDEAPopStatePop];
   }
   return _animatedTransitioning;
}

@end
