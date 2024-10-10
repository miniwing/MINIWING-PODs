//
//  UINavigationController+FullscreenPopGesture.m
//  UINavigationController+FullscreenPopGesture
//
//  Created by CiCi on 16/6/3.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import <MessageUI/MessageUI.h>

#if __has_include(<RTRootNavigationController/RTRootNavigationController-umbrella.h>)
#  import <RTRootNavigationController/RTRootNavigationController-umbrella.h>
#  define RT_ROOT_NAVIGATIONCONTROLLER                                  (1)
#elif __has_include("RTRootNavigationController/RTRootNavigationController-umbrella.h")
#  import "RTRootNavigationController/RTRootNavigationController-umbrella.h"
#  define RT_ROOT_NAVIGATIONCONTROLLER                                  (1)
#else
#  define rt_topViewController                                          topViewController
#  define rt_visibleViewController                                      visibleViewController
#  define rt_viewControllers                                            viewControllers
#  define rt_navigationController                                       navigationController
#  define RT_ROOT_NAVIGATIONCONTROLLER                                  (0)
#endif

#import "UINavigationController+FullscreenPopGesture.h"

@interface FullscreenPopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, weak)               UINavigationController              * navigationController;

@end

@implementation FullscreenPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
   
   // Ignore when no view controller is pushed into the navigation stack.
   if (self.navigationController.viewControllers.count <= 1) {
      
      return NO;
      
   } /* End if () */
   
   // Ignore when the active view controller doesn't allow interactive pop.
   UIViewController *topViewController = self.navigationController.viewControllers.lastObject;
   
   if (topViewController.interactivePopDisabled) {
      
      return NO;
      
   } /* End if () */
   
#if RT_ROOT_NAVIGATIONCONTROLLER
   if ([topViewController isKindOfClass:[RTContainerController class]]) {
      
      if (((RTContainerController *)topViewController).contentViewController.interactivePopDisabled) {
         
         return NO;
         
      } /* End if () */
      
   } /* End if () */
#endif /* RT_ROOT_NAVIGATIONCONTROLLER */
   
   // Ignore when the beginning location is beyond max allowed initial distance to left edge.
   CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
   CGFloat maxAllowedInitialDistance = topViewController.interactivePopMaxAllowedInitialDistanceToLeftEdge;
   
   if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
      
      return NO;
      
   } /* End if () */
   
   // Ignore pan gesture when the navigation controller is currently in transition.
   if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
      
      return NO;
      
   } /* End if () */
   
   // Prevent calling the handler when the gesture begins in an opposite direction.
   CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
   if (translation.x <= 0) {
      
      return NO;
      
   } /* End if () */
   
   return YES;
}

@end

typedef void (^ViewControllerWillAppearInjectBlock)(UIViewController *viewController, BOOL animated);

@interface UIViewController (FullscreenPopGesturePrivate)

@property (nonatomic, copy) ViewControllerWillAppearInjectBlock willAppearInjectBlock;

@end

@implementation UIViewController (FullscreenPopGesturePrivate)

+ (void)load {
   
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^ {
      
      Class  stClass          = [self class];
      
      LogDebug((@"+[UIViewController load] : %@", stClass));
      
      SEL    originalSelector = @selector(viewWillAppear:);
      SEL    swizzledSelector = @selector(swizzledViewWillAppear:);
      
      Method originalMethod   = class_getInstanceMethod(stClass, originalSelector);
      Method swizzledMethod   = class_getInstanceMethod(stClass, swizzledSelector);
      
      BOOL bSuccess = class_addMethod(stClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
      
      if (bSuccess) {
         
         class_replaceMethod(stClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
         
      } /* End if () */
      else {
         
         method_exchangeImplementations(originalMethod, swizzledMethod);
         
      } /* End else */
      
   });
   
   return;
}

- (void)swizzledViewWillAppear:(BOOL)animated {
   
   LogDebug((@"-[UIViewController swizzledViewWillAppear:] : %@", self));
   
   // Forward to primary implementation.
   [self swizzledViewWillAppear:animated];
   
   if (self.willAppearInjectBlock) {
      
      self.willAppearInjectBlock(self, animated);
      
   } /* End if () */
   
   return;
}

- (ViewControllerWillAppearInjectBlock)willAppearInjectBlock {
   
   return objc_getAssociatedObject(self, _cmd);
}

- (void)setWillAppearInjectBlock:(ViewControllerWillAppearInjectBlock)block {
   
   objc_setAssociatedObject(self, @selector(willAppearInjectBlock), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
   
   return;
}

@end

@implementation UINavigationController (FullscreenPopGesture)

+ (void)load {
   
   // Inject "-pushViewController:animated:"
   static dispatch_once_t onceToken;
   
   dispatch_once(&onceToken, ^ {
      
      Class  class = [self class];
      
      LogDebug((@"+[UINavigationController load] : %@", class));
      
      SEL    originalSelector = @selector(pushViewController:animated:);
      SEL    swizzledSelector = @selector(swizzledPushViewController:animated:);
      
      Method originalMethod   = class_getInstanceMethod(class, originalSelector);
      Method swizzledMethod   = class_getInstanceMethod(class, swizzledSelector);
      
      BOOL bSuccess = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
      if (bSuccess) {
         
         class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
         
      } /* End if () */
      else {
         
         method_exchangeImplementations(originalMethod, swizzledMethod);
         
      } /* End if () */
   });
   
   return;
}

- (void)swizzledPushViewController:(UIViewController *)viewController animated:(BOOL)animated {
   
   LogDebug((@"-[UINavigationController swizzledPushViewController:animated:] : %@", self));
   LogDebug((@"-[UINavigationController swizzledPushViewController:animated:] : viewController : %@", viewController));
   
   if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.fullscreenPopGestureRecognizer]) {
      
      // Add our own gesture recognizer to where the onboard screen edge pan gesture recognizer is attached to.
      [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.fullscreenPopGestureRecognizer];
      
      // Forward the gesture events to the private handler of the onboard gesture recognizer.
      NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
      id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
      SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
      self.fullscreenPopGestureRecognizer.delegate = self.popGestureRecognizerDelegate;
      [self.fullscreenPopGestureRecognizer addTarget:internalTarget action:internalAction];
      
      // Disable the onboard gesture recognizer.
      self.interactivePopGestureRecognizer.enabled = NO;
      
   } /* End if () */
   
   // Handle perferred navigation bar appearance.
   [self setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];
   
   // Forward to primary implementation.
   if (![self.viewControllers containsObject:viewController]) {
      
      [self swizzledPushViewController:viewController animated:animated];
      
   } /* End if () */
   
   return;
}

- (void)setupViewControllerBasedNavigationBarAppearanceIfNeeded:(UIViewController *)appearingViewController {
   
   LogDebug((@"-[UINavigationController setupViewControllerBasedNavigationBarAppearanceIfNeeded:] : %@", self));
   LogDebug((@"-[UINavigationController setupViewControllerBasedNavigationBarAppearanceIfNeeded:] : appearingViewController : %@", appearingViewController));
   
   if (!self.viewControllerBasedNavigationBarAppearanceEnabled) {
      
      return;
   }
   
   /**
    修复短信分享，导航栏无内容。
    */
   if ([self isKindOfClass:[MFMessageComposeViewController class]]) {
      
      return;
      
   } /* End if () */
   
   //   __weak typeof(self) stWEAK_SELF = self;
   @weakify(self);
   ViewControllerWillAppearInjectBlock block = ^(UIViewController *viewController, BOOL animated) {
      
      @strongify(self);
      //      __strong typeof(stWEAK_SELF) stSTRONG_SELF = stWEAK_SELF;
      
      if (self) {
         
         [self setNavigationBarHidden:viewController.prefersNavigationBarHidden animated:animated];
         
      } /* End if () */
   };
   
   // Setup will appear inject block to appearing view controller.
   // Setup disappearing view controller as well, because not every view controller is added into
   // stack by pushing, maybe by "-setViewControllers:".
   appearingViewController.willAppearInjectBlock = block;
   UIViewController *disappearingViewController = self.viewControllers.lastObject;
   if (disappearingViewController && !disappearingViewController.willAppearInjectBlock) {
      
      disappearingViewController.willAppearInjectBlock = block;
      
   } /* End if () */
   
   return;
}

- (FullscreenPopGestureRecognizerDelegate *)popGestureRecognizerDelegate {
   
   FullscreenPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
   
   if (!delegate) {
      
      delegate = [[FullscreenPopGestureRecognizerDelegate alloc] init];
      delegate.navigationController = self;
      
      objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
      
   } /* End if () */
   
   return delegate;
}

- (UIPanGestureRecognizer *)fullscreenPopGestureRecognizer {
   
   UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
   
   if (!panGestureRecognizer) {
      
      panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
      panGestureRecognizer.maximumNumberOfTouches = 1;
      
      objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
      
   } /* End if () */
   
   return panGestureRecognizer;
}

- (BOOL)viewControllerBasedNavigationBarAppearanceEnabled {
   
   NSNumber *number = objc_getAssociatedObject(self, _cmd);
   
   if (number) {
      
      return number.boolValue;
      
   } /* End if () */
   
   self.viewControllerBasedNavigationBarAppearanceEnabled = YES;
   
   return YES;
}

- (void)setViewControllerBasedNavigationBarAppearanceEnabled:(BOOL)enabled {
   
   SEL key = @selector(viewControllerBasedNavigationBarAppearanceEnabled);
   
   objc_setAssociatedObject(self, key, @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
   
   return;
}

@end

@implementation UIViewController (FullscreenPopGesture)

- (BOOL)interactivePopDisabled {
   
   return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setInteractivePopDisabled:(BOOL)disabled {
   
   objc_setAssociatedObject(self, @selector(interactivePopDisabled), @(disabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
   
   return;
}

- (BOOL)prefersNavigationBarHidden {
   
   return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setPrefersNavigationBarHidden:(BOOL)hidden {
   
   objc_setAssociatedObject(self, @selector(prefersNavigationBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
   
   return;
}

- (CGFloat)interactivePopMaxAllowedInitialDistanceToLeftEdge {
   
#if CGFLOAT_IS_DOUBLE
   return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
   return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}

- (void)setInteractivePopMaxAllowedInitialDistanceToLeftEdge:(CGFloat)distance {
   
   SEL key = @selector(interactivePopMaxAllowedInitialDistanceToLeftEdge);
   objc_setAssociatedObject(self, key, @(MAX(0, distance)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
   
   return;
}

@end
