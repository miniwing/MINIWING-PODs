//
//  IDEATabBarControllerTransition.m
//  IDEATabBarControllerTransition
//
//  Created by Harry on 2021/4/8.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEATabBarControllerTransition.h"

#import "CAMediaTimingFunction+TabBarControllerTransition.h"
#import "IDEATabBarControllerAnimationFactory.h"
#import "IDEATabBarControllerTransitionAnimation.h"
#import "IDEATabBarControllerLayerContext.h"


//CA_EXTERN IDEATabBarControllerTransitionAnimationKeys const toViewAnimationKey;
//CA_EXTERN IDEATabBarControllerTransitionAnimationKeys const fromViewAnimationKey;
//CA_EXTERN IDEATabBarControllerTransitionAnimationKeys const navigationBarAnimationKey;
//CA_EXTERN IDEATabBarControllerTransitionAnimationKeys const backgroundAnimatonKey;

//CA_EXTERN IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyToView;
//CA_EXTERN IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyFromView;
//CA_EXTERN IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyNavigationBar;
//CA_EXTERN IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyBackground;

IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyBackground         = @"BackgroundAnimationKey";

IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyView               = @"viewAnimationKey";
IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyToView             = @"toViewAnimationKey";
IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyFromView           = @"fromViewAnimationKey";
IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyToNavigationBar    = @"toNavigationBarAnimationKey";
IDEATabBarControllerTransitionAnimationKeys const IDEATabBarControllerTransitionAnimationKeyFromNavigationBar  = @"fromNavigationBarAnimationKey";

@interface IDEATabBarControllerTransition ()

@end

NSNotificationName   const IDEATabBarControllerTransitionBeginNotification = @"IDEATabBarControllerTransitionBeginNotification";
NSNotificationName   const IDEATabBarControllerTransitionEndNotification   = @"IDEATabBarControllerTransitionEndNotification";

@implementation IDEATabBarControllerTransition

//- (void)viewWillAppear:(BOOL)aAnimated {
//
//   int                            nErr                                     = EFAULT;
//
//   __TRY;
//
//   [super viewWillAppear:aAnimated];
//
//   __CATCH(nErr);
//
//   return;
//}

- (TransType)transType {
   
   return TransTypeMove;
}

- (CFTimeInterval)transitionDuration {
   
   return 0.35;
}

- (CAMediaTimingFunction *)transitionTimingFunction {
   
   return [CAMediaTimingFunction easeOut];
}

- (CAAnimation *)fromTransitionAnimation:(CALayer *)aLayer direction:(IDEATabBarControllerTransitionDirection)aDirection {
   
   if (TransTypeFade == [self transType]) {
      
      return [IDEATabBarControllerTransitionAnimation fadeWithType:IDEATabBarControllerTransitionViewTypeFrom];

   } /* End if () */
   
   if (TransTypeScale == [self transType]) {
      
      return [IDEATabBarControllerTransitionAnimation scaleWithType:IDEATabBarControllerTransitionViewTypeFrom];

   } /* End if () */
   
   return [IDEATabBarControllerTransitionAnimation moveWithType:IDEATabBarControllerTransitionViewTypeFrom direction:aDirection];
}

- (CAAnimation *)toTransitionAnimation:(CALayer *)aLayer direction:(IDEATabBarControllerTransitionDirection)aDirection {

   if (TransTypeFade == [self transType]) {
      
      return [IDEATabBarControllerTransitionAnimation fadeWithType:IDEATabBarControllerTransitionViewTypeTo];

   } /* End if () */
   
   if (TransTypeScale == [self transType]) {
      
      return [IDEATabBarControllerTransitionAnimation scaleWithType:IDEATabBarControllerTransitionViewTypeTo];

   } /* End if () */

   return [IDEATabBarControllerTransitionAnimation moveWithType:IDEATabBarControllerTransitionViewTypeTo direction:aDirection];
}

- (BOOL)animateTransition:(UITabBarController *)aTabBarController shouldSelect:(UIViewController *)aToViewController {
   
   int                            nErr                                     = EFAULT;

   BOOL                           bShouldSelect                            = NO;
   
   UIViewController              *stFromViewCotroller                      = aTabBarController.selectedViewController;
   
   IDEATabBarControllerLayerContext       *stLayerContext                  = nil;
   IDEATabBarControllerTransitionDirection eDirection                      = DirectionLeft;

   NSInteger                      nSelectedIndex                           = 0;
   NSInteger                      nShouldSelectIndex                       = 0;

   CALayer                       * stToNavigationBarLayer                  = nil;
   CALayer                       * stToLayer                               = nil;
   CALayer                       * stFromNavigationBarLayer                = nil;
   CALayer                       * stFromLayer                             = nil;

   __TRY;
   
   if (nil == stFromViewCotroller || stFromViewCotroller == aToViewController) {
      
      bShouldSelect  = YES;
      nErr           = noErr;
      
      break;
      
   } /* End if () */
   
   stLayerContext = [IDEATabBarControllerLayerContext layerContext:stFromViewCotroller
                                                  toViewController:aToViewController];
   
   stToLayer   = stLayerContext.toLayer;
   LogDebug((@"-[animateTransition:shouldSelect:] : ToLayer : %@", stToLayer));

   if (stToLayer) {
      
      [aTabBarController.view.layer addSublayer:stToLayer];

//      [stToLayer setLeft:(aTabBarController.view.layer.width - stToLayer.width) / 2];

   } /* End if () */

   stFromLayer = stLayerContext.fromLayer;
   LogDebug((@"-[animateTransition:shouldSelect:] : FromLayer : %@", stFromLayer));

   if (stFromLayer) {
      
      [aTabBarController.view.layer addSublayer:stFromLayer];
      
//      [stFromLayer setLeft:(aTabBarController.view.layer.width - stFromLayer.width) / 2];

   } /* End if () */

   stToNavigationBarLayer     = stLayerContext.toNavigationBarLayer;
   LogDebug((@"-[animateTransition:shouldSelect:] : ToNavigationBarLayer : %@", stToNavigationBarLayer));

   if (stToNavigationBarLayer) {
      
      [aTabBarController.view.layer addSublayer:stToNavigationBarLayer];

   } /* End if () */

   stFromNavigationBarLayer   = stLayerContext.fromNavigationBarLayer;
   LogDebug((@"-[animateTransition:shouldSelect:] : FromNavigationBarLayer : %@", stFromNavigationBarLayer));

   if (stFromNavigationBarLayer) {
      
      [aTabBarController.view.layer addSublayer:stFromNavigationBarLayer];

   } /* End if () */
   
   nSelectedIndex       = aTabBarController.selectedIndex;
   LogDebug((@"SelectedIndex : %d", nSelectedIndex));
   
   nShouldSelectIndex   = [aTabBarController.viewControllers indexOfObject:aToViewController];
   LogDebug((@"ShouldSelectIndex : %d", nShouldSelectIndex));

   eDirection           = [IDEATabBarControllerTransition direction:nSelectedIndex shouldSelectIndex:nShouldSelectIndex];
   LogDebug((@"Direction : %d", eDirection));

//   dispatch_after(0.0, dispatch_get_main_queue(), ^{
   dispatch_async(dispatch_get_main_queue(), ^{

      if ([aTabBarController isKindOfClass:[IDEATabBarControllerTransition class]]) {

         [((IDEATabBarControllerTransition *)aTabBarController) animate:stLayerContext
                                                              direction:eDirection
                                                       tabbarController:aTabBarController];

      } /* End if () */
   });
   
   bShouldSelect  = YES;

   __CATCH(nErr);
   
   return bShouldSelect;
}

- (void)animate:(IDEATabBarControllerLayerContext *)aLayerContext
      direction:(IDEATabBarControllerTransitionDirection)aDirection tabbarController:(UITabBarController *)aTabbarController {
   
   int                            nErr                                     = EFAULT;

   CAAnimation                   *stFromAnimation                          = nil;
   CAAnimation                   *stToAnimation                            = nil;

   CAAnimation                   *stFromNavigationBarAnimation             = nil;
   CAAnimation                   *stToNavigationBarAnimation               = nil;

   CAAnimation                   *stViewLayerAnimation                     = nil;

   __TRY;
   
   stFromAnimation   = [self fromTransitionAnimation: aLayerContext.fromLayer direction: aDirection];
   stToAnimation     = [self toTransitionAnimation: aLayerContext.toLayer direction: aDirection];

   stFromNavigationBarAnimation  = [IDEATabBarControllerAnimationFactory makeAnimationWithType: AnimationTypeOpacity from: 1 to: 0];
   stToNavigationBarAnimation    = [IDEATabBarControllerAnimationFactory makeAnimationWithType: AnimationTypeOpacity from: 0 to: 1];

   stViewLayerAnimation = [IDEATabBarControllerAnimationFactory makeAnimationWithType: AnimationTypeOpacity from: 0 to: 1];

#if __Debug__
#  if TARGET_IPHONE_SIMULATOR
//   UIImage  *stImage = [aLayerContext.viewLayer snapshotImage];
//   [IDEATabBarControllerTransition saveImage:stImage withName:@"viewLayer"];
//
//   stImage = [aLayerContext.fromLayer snapshotImage];
//   [IDEATabBarControllerTransition saveImage:stImage withName:@"fromLayer"];
//
//   stImage = [aLayerContext.toLayer snapshotImage];
//   [IDEATabBarControllerTransition saveImage:stImage withName:@"toLayer"];
#  endif /* TARGET_IPHONE_SIMULATOR */
#endif /* __Debug__ */

   aLayerContext.viewLayer.opacity  = 0;
//   aLayerContext.fromLayer.opacity  = 1;
//   aLayerContext.toLayer.opacity    = 0;

   aLayerContext.fromNavigationBarLayer.opacity = 1;
   aLayerContext.toNavigationBarLayer.opacity   = 0;

   [[NSNotificationCenter defaultCenter] postNotificationName:IDEATabBarControllerTransitionBeginNotification
                                                       object:nil];
   
   [CATransaction begin];
   [CATransaction setAnimationDuration:[self transitionDuration]];
   [CATransaction setAnimationTimingFunction:[self transitionTimingFunction]];
   [CATransaction setCompletionBlock:^{

      aLayerContext.viewLayer.opacity  = 1;

      [aLayerContext reset];
      [[NSNotificationCenter defaultCenter] postNotificationName:IDEATabBarControllerTransitionEndNotification
                                                          object:nil];
      
      return;
   }];
   
   aLayerContext.viewLayer.opacity  = 1;
   aLayerContext.fromLayer.opacity  = 0;
   aLayerContext.toLayer.opacity    = 1;
   
   aLayerContext.fromNavigationBarLayer.opacity = 0;
   aLayerContext.toNavigationBarLayer.opacity   = 1;

   [aLayerContext.fromLayer addAnimation:stFromAnimation
                                  forKey:IDEATabBarControllerTransitionAnimationKeyFromView];
   [aLayerContext.toLayer addAnimation:stToAnimation
                                forKey:IDEATabBarControllerTransitionAnimationKeyToView];

   [aLayerContext.viewLayer addAnimation:stViewLayerAnimation
                                  forKey:IDEATabBarControllerTransitionAnimationKeyView];

   [aLayerContext.fromNavigationBarLayer addAnimation:stFromNavigationBarAnimation
                                               forKey:IDEATabBarControllerTransitionAnimationKeyFromNavigationBar];
   [aLayerContext.toNavigationBarLayer addAnimation:stToNavigationBarAnimation
                                             forKey:IDEATabBarControllerTransitionAnimationKeyToNavigationBar];

   [CATransaction commit];
   
   __CATCH(nErr);
   
   return;
}

#if __Debug__
#  if TARGET_IPHONE_SIMULATOR
+ (void)saveImage:(UIImage *)aImage withName:(NSString *)aName {
   
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
      
      NSError  *stError    = nil;
      NSArray  *stPaths    = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
      NSString *szFilePath = [[stPaths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", aName]];  // 保存文件的名称
      
      NSLog(@"保存路径 : %p : %@", aImage, szFilePath);
      
      BOOL      bOK        = [UIImagePNGRepresentation(aImage) writeToFile:szFilePath
                                                                   options:NSDataWritingAtomic
                                                                     error:&stError]; // 保存成功会返回YES
      if (nil == stError) {
         NSLog(@"保存成功");
      }
      
      return;
   });
   
   return;
}
#  endif /* TARGET_IPHONE_SIMULATOR */
#endif /* __Debug__ */

@end

@implementation IDEATabBarControllerTransition (IDEATabBarControllerTransitionDirection)

+ (IDEATabBarControllerTransitionDirection)direction:(NSInteger)aSelectedIndex shouldSelectIndex:(NSInteger)aShouldSelectIndex {
   
   if (aSelectedIndex > aShouldSelectIndex) {
      
      return DirectionLeft;
      
   } /* End if () */
   
   return DirectionRight;
}


@end

