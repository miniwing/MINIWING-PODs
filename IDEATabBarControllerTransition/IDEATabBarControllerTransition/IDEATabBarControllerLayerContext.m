//
//  IDEATabBarControllerLayerContext.m
//  IDEATabBarControllerTransition
//
//  Created by Harry on 2021/4/8.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "UIView+TabBarControllerTransition.h"
#import "CALayer+TabBarControllerTransition.h"

#import "IDEATabBarControllerLayerContext.h"

@interface UIViewController (Pure)

- (UIViewController *)pureViewController;

@end

@implementation UIViewController (Pure)

// 必需为 UIViewControll, 而非为其相关子类
- (UIViewController *)pureViewController {
   
#if RT_ROOT_NAVIGATIONCONTROLLER
   if ([self isKindOfClass:[RTRootNavigationController class]]) {
      
      UIViewController  *stViewController    = nil;
      
      if (nil != ((RTRootNavigationController *)self).rt_visibleViewController) {
         
         stViewController  = ((RTRootNavigationController *)self).rt_visibleViewController;
         
      } /* End if () */
      else {
         
         stViewController  = ((RTRootNavigationController *)self).rt_topViewController;
         
      } /* End else */
      
      return stViewController;
//      return stViewController.navigationController;
   } /* End if () */
#endif /* RT_ROOT_NAVIGATIONCONTROLLER */
   
   if ([self isKindOfClass:[UINavigationController class]]) {
      
      if (nil != ((UINavigationController *)self).visibleViewController) {
         
         return ((UINavigationController *)self).visibleViewController;
         
      } /* End if () */
      
      return ((UINavigationController *)self).topViewController;
      
   } /* End if () */
   
   return self;
}

@end


@interface IDEATabBarControllerLayerContext ()

@end

@implementation IDEATabBarControllerLayerContext

- (void)dealloc {
   
   __LOG_FUNCTION;
   
   // Custom dealloc
   [self reset];
   
   __SUPER_DEALLOC;
   
   return;
}

+ (instancetype)layerContext:(UIViewController *)aFromViewController toViewController:(UIViewController *)aToViewController {
   
   return [[IDEATabBarControllerLayerContext alloc] init:aFromViewController toViewController:aToViewController];
}

- (instancetype)init:(UIViewController *)aFromViewController toViewController:(UIViewController *)aToViewController {
   
   int                            nErr                                     = EFAULT;
   
   BOOL                           bViewLoaded                              = NO;
   
   __TRY;
   
   self  = [super init];
   
   if (self) {
      
      bViewLoaded = [aToViewController pureViewController].isViewLoaded;
      
      [aToViewController loadViewIfNeeded];
      [aToViewController.pureViewController loadViewIfNeeded];
      
      if (NO == bViewLoaded) {
         
         [[aToViewController pureViewController].view setNeedsLayout];
         
      } /* End if () */
      
      _viewLayer  = [aToViewController pureViewController].view.layer;
      
      _fromLayer  = [IDEATabBarControllerLayerContext makeLayer:aFromViewController.pureViewController];
      _toLayer    = [IDEATabBarControllerLayerContext makeLayer:aToViewController.pureViewController viewLoaded:bViewLoaded];
      
      _fromNavigationBarLayer = [IDEATabBarControllerLayerContext makeNavigationBarLayer:aFromViewController.pureViewController];
      _toNavigationBarLayer   = [IDEATabBarControllerLayerContext makeNavigationBarLayer:aToViewController.pureViewController viewLoaded:bViewLoaded];
      
      _fakeTabbarLayer        = nil;
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (void)reset {
   
   [_toNavigationBarLayer removeFromSuperlayer];
   _toNavigationBarLayer   = nil;
   
   [_toLayer removeFromSuperlayer];
   _toLayer = nil;
   
   [_fromNavigationBarLayer removeFromSuperlayer];
   _fromNavigationBarLayer = nil;
   
   [_fromLayer removeFromSuperlayer];
   _fromLayer  = nil;
   
   return;
}

+ (UIImage *)imageFromView:(UIView *)aSnapView {
   
//    UIGraphicsBeginImageContext(snapView.frame.size);
//   UIGraphicsBeginImageContextWithOptions(aSnapView.frame.size, NO, [UIScreen mainScreen].scale);
   UIGraphicsBeginImageContextWithOptions(aSnapView.frame.size, NO, 0.0);
   CGContextRef stContext = UIGraphicsGetCurrentContext();
   
//   if ([aSnapView respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
//
//      [aSnapView drawViewHierarchyInRect:aSnapView.bounds afterScreenUpdates:YES];
//
//   } /* End if () */
//   else {
//
//      [aSnapView.layer renderInContext:stContext];
//
//   } /* End else */
   
   [aSnapView.layer renderInContext:stContext];
   
//   stSnapshotView = [aInputView drawViewHierarchyInRect:aInputView.bounds afterScreenUpdates:NO];
   
   UIImage *stTargetImage = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   
   return stTargetImage;
}

+ (UIImage *)imageFromViewEx:(UIView *)aSnapView {
   
   //    UIGraphicsBeginImageContext(snapView.frame.size);
   UIGraphicsBeginImageContextWithOptions(aSnapView.frame.size, NO, [UIScreen mainScreen].scale);
   CGContextRef stContext = UIGraphicsGetCurrentContext();
   
   CGContextSaveGState(stContext);
   CGContextTranslateCTM(stContext, aSnapView.centerX, aSnapView.centerY);
   CGContextConcatCTM(stContext, [aSnapView transform]);
   
   CGContextTranslateCTM(stContext,
                         -[aSnapView bounds].size.width * [[aSnapView layer] anchorPoint].x,
                         -[aSnapView bounds].size.height * [[aSnapView layer] anchorPoint].y);
   
   //   if ([aSnapView respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
   //
   //      [aSnapView drawViewHierarchyInRect:aSnapView.bounds afterScreenUpdates:YES];
   //
   //   } /* End if () */
   //   else {
   //
   //      [aSnapView.layer renderInContext:stContext];
   //
   //   } /* End else */
   
   [aSnapView.layer renderInContext:stContext];
   
   CGContextRestoreGState(stContext);
   
   //   stSnapshotView = [aInputView drawViewHierarchyInRect:aInputView.bounds afterScreenUpdates:NO];
   
   UIImage *stTargetImage = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   
   return stTargetImage;
}

+ (UIView *)snapshotFromView:(UIView *)aInputView {
   
   UIImage     *stImage                      = nil;
   UIView      *stTargetView                 = nil;
   UIView      *stSnapshotView               = nil;
   
   BOOL         bAfterUpdates                = YES;
   
//   if (@available(iOS 11, *)) {
//
//#if __Debug__
//      if ([aInputView isKindOfClass:NSClassFromString(@"MDCFlexibleHeaderView")]) {
//
//         LogDebug((@"+[IDEATabBarControllerLayerContext snapshotFromView:] : [aInputView viewController] : %@", [aInputView viewController]));
//         LogDebug((@"+[IDEATabBarControllerLayerContext snapshotFromView:] : [aInputView viewController] : %@", [[aInputView viewController] parentViewController]));
//
//      } /* End if () */
//#endif /* __Debug__ */
//
////      stSnapshotView = [aInputView snapshotViewAfterScreenUpdates:YES];
//
////      LogDebug((@"+[IDEATabBarControllerLayerContext snapshotFromView:] : SnapshotView : %@", stSnapshotView));
//
////      stSnapshotView = [aInputView resizableSnapshotViewFromRect:aInputView.bounds
////                                              afterScreenUpdates:YES
////                                                   withCapInsets:UIEdgeInsetsZero];
//
//      LogDebug((@"+[IDEATabBarControllerLayerContext snapshotFromView:] : SnapshotView : %@", stSnapshotView));
//
//      if ([aInputView viewController] && [[aInputView viewController] parentViewController] && ![[[aInputView viewController] parentViewController] isKindOfClass:[UINavigationController class]]) {
//
//         bAfterUpdates  = NO;
//
//      } /* End if () */
//
//      stSnapshotView = [aInputView snapshotViewAfterScreenUpdates:bAfterUpdates];
//
////      LogDebug((@"+[IDEATabBarControllerLayerContext snapshotFromView:] : SnapshotView : %@", stSnapshotView));
//
////      stSnapshotView = [aInputView resizableSnapshotViewFromRect:aInputView.bounds
////                                              afterScreenUpdates:![aInputView isKindOfClass:NSClassFromString(@"MDCFlexibleHeaderView")]
////                                                   withCapInsets:UIEdgeInsetsZero];
//
//   } /* End if () */
//   else {
//
//      stImage        = [self imageFromView:aInputView];
//      stSnapshotView = [[UIImageView alloc] initWithImage:stImage];
//
//   } /* End else */
   
   stImage        = [self imageFromView:aInputView];
   stSnapshotView = [[UIImageView alloc] initWithImage:stImage];
   
   [stSnapshotView.layer setMasksToBounds:YES];
   [stSnapshotView setClipsToBounds:YES];
   
   return stSnapshotView;
}

+ (UIView *)navigationBarOrHeadView:(UIViewController *)aViewController {
   
   UIView            *stNavigationView    = nil;
   
   if ([aViewController respondsToSelector:@selector(navigationBarOrHeadView)]) {
      
      stNavigationView  = [aViewController performSelector:@selector(navigationBarOrHeadView)];
      
   } /* End if () */
   
   return stNavigationView;
}

+ (CALayer *)makeNavigationBarLayer:(UIViewController *)aViewController {
   
   return [self makeNavigationBarLayer:aViewController viewLoaded:YES];
}

+ (CALayer *)makeNavigationBarLayer:(UIViewController *)aViewController viewLoaded:(BOOL)aViewLoaded {
   
   int                            nErr                                     = EFAULT;
   
   CALayer                       *stLayer                                  = [CALayer layer];
   
   CALayer                       *stNavigationBarLayer                     = nil;
   UIView                        *stNavigationBar                          = nil;
   
   CGFloat                        fTop                                     = 0;
   
   __TRY;
   
#if RT_ROOT_NAVIGATIONCONTROLLER
   if ([aViewController isKindOfClass:[RTContainerNavigationController class]]) {
      
      NSAssert(NO, @"RTContainerNavigationController");
      
   } /* End if () */
   else if ([aViewController isKindOfClass:[RTRootNavigationController class]]) {
      
      NSAssert(NO, @"RTRootNavigationController");
      
   } /* End else if () */
   else
#endif /* RT_ROOT_NAVIGATIONCONTROLLER */
      if ([aViewController isKindOfClass:[UINavigationController class]]) {
         
         NSAssert(NO, @"UINavigationController");
         
      } /* End else if () */
   
   if ([aViewController respondsToSelector:@selector(navigationBarOrHeadView)]) {
      
      stNavigationBar   = [aViewController performSelector:@selector(navigationBarOrHeadView)];
      
   } /* End if () */
   LogDebug((@"NavigationBar : %@", stNavigationBar));
   
   if (NO == aViewLoaded) {
      
      [stNavigationBar setWidth:aViewController.view.width];
      
   } /* End if () */
   
   LogDebug((@"-[makeNavigationBarLayer:viewLoaded:] : NavigationBar : %@", stNavigationBar));
   
   [stLayer setWidth:stNavigationBar.width];
   
   if ([stNavigationBar isKindOfClass:[UINavigationBar class]]) {
      
      [stLayer setHeight:[UIApplication sharedApplication].statusBarFrame.size.height + stNavigationBar.height];
      
   } /* End if () */
   else {
      
      [stLayer setHeight:stNavigationBar.top + stNavigationBar.height];
      
   } /* End else */
   
   // 系统标准 NavigationBar
   if ([stNavigationBar isKindOfClass:[UINavigationBar class]]) {
      
      // 透明未隐藏, 需要偏移。
      if (NO == stNavigationBar.isHidden) {
         
         stNavigationBarLayer  = [[self class] snapshotFromView:stNavigationBar].layer;
         
         if (((UINavigationBar *)stNavigationBar).isTranslucent) {
            
            fTop  = [UIApplication sharedApplication].statusBarFrame.size.height + stNavigationBar.height;
            
         } /* End if () */
         else {
            
            fTop  = [UIApplication sharedApplication].statusBarFrame.size.height;
            
         } /* End else */
         
         fTop  = [UIApplication sharedApplication].statusBarFrame.size.height;
         
      } /* End if () */
      else {
         
         // Nothing.
         
      } /* End else */
      
   } /* End if () */
   else {
      
      // 非系统标准 NavigationBar
      stNavigationBarLayer  = [[self class] snapshotFromView:stNavigationBar].layer;
      
      stLayer.backgroundColor = stNavigationBarLayer.backgroundColor;
      
      fTop  = 0;
      
   } /* End else */
   
   [stNavigationBarLayer setTop:fTop];
   
   [stLayer addSublayer:stNavigationBarLayer];
   
   __CATCH(nErr);
   
   return stLayer;
}

+ (CALayer *)makeLayer:(UIViewController *)aViewController {
   
   return [self makeLayer:aViewController viewLoaded:YES withNavigationBar:NO tabbar:NO];
}

+ (CALayer *)makeLayer:(UIViewController *)aViewController viewLoaded:(BOOL)aViewLoaded {
   
   return [self makeLayer:aViewController viewLoaded:aViewLoaded withNavigationBar:NO tabbar:NO];
}

+ (CALayer *)makeLayer:(UIViewController *)aViewController viewLoaded:(BOOL)aViewLoaded withNavigationBar:(BOOL)aNavigationBar tabbar:(BOOL)aTabbar {
   
   int                            nErr                                     = EFAULT;
   
   CALayer                       *stLayer                                  = [CALayer layer];
   CGFloat                        fTop                                     = 0;
   CGFloat                        fBottom                                  = 0;
   
   UIView                        *stNavigationBar                          = nil;
   UITabBar                      *stTabbar                                 = nil;
   
   CALayer                       *stViewLayer                              = nil;
   CGFloat                        fViewLayerTop                            = 0;
   
   __TRY;
   
#if RT_ROOT_NAVIGATIONCONTROLLER
   if ([aViewController isKindOfClass:[RTContainerNavigationController class]]) {
      
      NSAssert(NO, @"RTContainerNavigationController");
      
   } /* End if () */
   else if ([aViewController isKindOfClass:[RTRootNavigationController class]]) {
      
      NSAssert(NO, @"RTRootNavigationController");
      
   } /* End else if () */
   else {
#endif /* RT_ROOT_NAVIGATIONCONTROLLER */
      if ([aViewController isKindOfClass:[UINavigationController class]]) {
         
         NSAssert(NO, @"UINavigationController");
         
      } /* End else if () */
#if RT_ROOT_NAVIGATIONCONTROLLER
   }
#endif /* RT_ROOT_NAVIGATIONCONTROLLER */

   if ([aViewController respondsToSelector:@selector(navigationBarOrHeadView)]) {
      
      stNavigationBar   = [aViewController performSelector:@selector(navigationBarOrHeadView)];
      
   } /* End if () */
   
   if (NO == aViewLoaded) {
      
      [stNavigationBar setWidth:aViewController.view.width];
      
   } /* End if () */
   
   LogDebug((@"-[makeLayer:viewLoaded:withNavigationBar:tabbar:] : NavigationBar : %@", stNavigationBar));
   
   if (aViewController.tabBarController.tabBar) {
      
      stTabbar = aViewController.tabBarController.tabBar;
      
   } /* End if () */
   
   LogDebug((@"-[makeLayer:viewLoaded:withNavigationBar:tabbar:] : Tabbar : %@", stTabbar));
   
   // 系统标准 NavigationBar
   if ([stNavigationBar isKindOfClass:[UINavigationBar class]]) {
      
      // 透明未隐藏, 需要偏移。
      //      if ((NO == stNavigationBar.isHidden) && ((UINavigationBar *)stNavigationBar).isTranslucent) {
      if (NO == stNavigationBar.isHidden) {
         
         if (((UINavigationBar *)stNavigationBar).isTranslucent) {
            
            fTop  = stNavigationBar.top + stNavigationBar.height;
            fViewLayerTop  = stNavigationBar.top + stNavigationBar.height;
            
         } /* End if () */
         else {
            
            if (NO == aViewLoaded) {
               
               fTop  = [UIApplication sharedApplication].statusBarFrame.size.height + stNavigationBar.height;
               fViewLayerTop  = [UIApplication sharedApplication].statusBarFrame.size.height + stNavigationBar.height;
               
               if (@available(iOS 11.0, *)) {
                  
                  LogDebug((@"-[makeLayer:viewLoaded:withNavigationBar:tabbar:] : SafeAreaInsets : (%.3f:%.3f)",
                            [[UIApplication sharedApplication].delegate.window safeAreaInsets].top,
                            [[UIApplication sharedApplication].delegate.window safeAreaInsets].bottom));
                  
                  if (0 < [[UIApplication sharedApplication].delegate.window safeAreaInsets].top || 0 < [[UIApplication sharedApplication].delegate.window safeAreaInsets].bottom) {
                     
                     fViewLayerTop  = 0 + stNavigationBar.height + 0;
                     
                  } /* End if () */
                  else {
                     
                     fViewLayerTop  = 0 + stNavigationBar.height - 12;  // 非刘海屏
                     
                  } /* End else */
                  
               } /* End if () */
               else {
                  
                  fViewLayerTop  = 0 + stNavigationBar.height - 12;  // 非刘海屏
                  
               } /* End else */
               
//               LogDebug((@"-[makeLayer:viewLoaded:withNavigationBar:tabbar:] : safeArea : (%.3f:%.3f)",
//                         [[UIApplication sharedApplication].delegate.window safeArea].top,
//                         [[UIApplication sharedApplication].delegate.window safeArea].bottom));
//
//               if (0 < [[UIApplication sharedApplication].delegate.window safeArea].top || 0 < [[UIApplication sharedApplication].delegate.window safeArea].bottom) {
//
//                  fViewLayerTop  = 0 + stNavigationBar.height + 0;
//
//               } /* End if () */
//               else {
//
//                  fViewLayerTop  = 0 + stNavigationBar.height - 12;  // 非刘海屏
//
//               } /* End else */
               
            } /* End if () */
            else {
               
               fTop  = [UIApplication sharedApplication].statusBarFrame.size.height + stNavigationBar.height;
               fViewLayerTop  = 0;
               
            } /* End else */
            
         } /* End else */
         
      } /* End if () */
      else {
         
         // Nothing.
         
      } /* End else */
      
   } /* End if () */
   else {
      
      // 非系统标准 NavigationBar
      fTop           = stNavigationBar.top + stNavigationBar.height;
      fViewLayerTop  = stNavigationBar.top + stNavigationBar.height;
      
   } /* End else */
   
   if (stTabbar.isTranslucent) {
      
      fBottom  = stTabbar.height;
      
   } /* End if () */
   
   [stLayer setMasksToBounds:YES];
   [stLayer setWidth:aViewController.view.width]; // 左 0.5 右 0.5
   [stLayer setTop:fTop];
   
   stViewLayer = [self snapshotFromView:aViewController.view].layer;
   
   if ([stNavigationBar isKindOfClass:[UINavigationBar class]]) {
      
      if (NO == aViewLoaded) {
         
         [stLayer setHeight:aViewController.view.height - ([UIApplication sharedApplication].statusBarFrame.size.height + stNavigationBar.height + fBottom)];
         
      } /* End if () */
      else {
         
         [stLayer setHeight:aViewController.view.height - (fViewLayerTop + fBottom)];
         
      } /* End else */
      
      [stViewLayer setTop:-fViewLayerTop];
      
   } /* End if () */
   else {
      
      [stLayer setHeight:aViewController.view.height - (fTop + fBottom)];
      [stViewLayer setTop:-fViewLayerTop];
      
   } /* End else */
   
   if (aViewController.view.backgroundColor) {
      
      stLayer.backgroundColor = aViewController.view.backgroundColor.CGColor;
      
//      stLayer.backgroundColor = UIColor.systemRedColor.CGColor;
      
   } /* End if () */
   
   LogDebug((@"-[makeLayer:viewLoaded:withNavigationBar:tabbar:] : Layer Height : %@", stLayer));
   LogDebug((@"-[makeLayer:viewLoaded:withNavigationBar:tabbar:] : ViewLayer Height : %@", stViewLayer));
   
   [stLayer addSublayer:stViewLayer];
//   [stViewLayer setLeft:(stLayer.width - stViewLayer.width) / 2];
//   [stViewLayer setCenterX:stLayer.width / 2];
   
   __CATCH(nErr);
   
   return stLayer;
}

+ (CALayer *)makeTabBarLayer:(UITabBarController *)aTabBarController {
   
   int                            nErr                                     = EFAULT;
   
   UITabBar                      *stTabBar                                 = nil;
   CALayer                       *stLayer                                  = [CALayer layer];
   
   UIView                        *stTabBarLayer                            = nil;
   
   CGFloat                        fTop                                     = 0;
   
   __TRY;
   
   stTabBar = aTabBarController.tabBar;
   LogDebug((@"-[makeNavigationBarLayer:viewLoaded:] : TabBar : %@", stTabBar));
   
   [stLayer setWidth:aTabBarController.tabBar.width];
   [stLayer setHeight:aTabBarController.tabBar.height];
   
   [stLayer addSublayer:stTabBarLayer];
   
   __CATCH(nErr);
   
   return stLayer;
}

@end
