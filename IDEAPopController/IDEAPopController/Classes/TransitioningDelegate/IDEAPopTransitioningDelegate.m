//
//  IDEAPopTransitioningDelegate.m
//  IDEAPopController
//
//  Copyright © 2020 Harry. All rights reserved.
//

#import "IDEAPopController/IDEAPopTransitioningDelegate.h"
#import "IDEAPopController/IDEAPopControllerAnimatedTransitioning.h"

@implementation IDEAPopTransitioningDelegate

- (instancetype)initWithPopController:(IDEAPopController *)popController {
   self = [super init];
   if (self) {
      _popController = popController;
   }
   
   return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
   return [[IDEAPopControllerAnimatedTransitioning alloc] initWithState:IDEAPopStatePop popController:self.popController];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
   return [[IDEAPopControllerAnimatedTransitioning alloc] initWithState:IDEAPopStateDismiss popController:self.popController];
}

@end
