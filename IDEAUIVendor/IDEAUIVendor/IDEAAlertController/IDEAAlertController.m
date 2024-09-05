//
//  IDEAAlertController.m
//  IDEAUIVendor
//
//  Created by Harry on 2022/6/21.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <IDEAKit/IDEAKit.h>
#import <IDEAKit/NSObject+Ivar.h>

#import "IDEAAlertController.h"
#import "IDEAAlertController+Inner.h"

static NSInteger const IDEAAlertControllerBlocksCancelButtonIndex      = 0;
static NSInteger const IDEAAlertControllerBlocksDestructiveButtonIndex = 1;
static NSInteger const IDEAAlertControllerBlocksFirstOtherButtonIndex  = 2;

@implementation IDEAAlertController

- (void)dealloc {
   
   __LOG_FUNCTION;
   
   // Custom dealloc
   __RELEASE(_themeBlock);
   
   [self removeAllNotifications];
   
   __SUPER_DEALLOC;
   
   return;
}

- (instancetype)initWithCoder:(NSCoder *)aCoder {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super initWithCoder:aCoder];
   
   if (self) {
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (void)viewDidLoad {
   
   int                            nErr                                     = EFAULT;
   
   UIVisualEffectView            *stVisualEffectView                       = nil;
   UIBlurEffectStyle              eBlurEffectStyle                         = UIBlurEffectStyleLight;
   
   NSAttributedString            *stTitle                                  = nil;
   NSAttributedString            *stMessage                                = nil;
   NSMutableDictionary<NSString *, id> *stTitleAttributes                  = [NSMutableDictionary dictionary];
   
   __TRY;
   
   [super viewDidLoad];
   
   // Do any additional setup after loading the view.
   
#if IDEA_NIGHT_VERSION_MANAGER
#  pragma clang diagnostic push
#  pragma clang diagnostic ignored "-Wundeclared-selector"
   [self addNotificationName:DKNightVersionThemeChangingNotification
                    selector:@selector(onThemeUpdate:)
                      object:nil];
#  pragma clang diagnostic pop
#endif /* IDEA_NIGHT_VERSION_MANAGER */
   
   [stTitleAttributes setObject:[IDEAColor colorWithKey:IDEAColor.label]
                         forKey:NSForegroundColorAttributeName];
   [stTitleAttributes setObject:[IDEAColor colorWithKey:IDEAColor.label]
                         forKey:UITextAttributeTextColor];
   
   stTitle     = [NSAttributedString attributedStringWithString:self.title
                                                     attributes:stTitleAttributes];
   
   stMessage   = [NSAttributedString attributedStringWithString:self.message
                                                     attributes:stTitleAttributes];
   
   [self setValue:stTitle forKey:@"attributedTitle"];
   [self setValue:stMessage forKey:@"attributedMessage"];
   
   if (@available(iOS 13.0, *)) {
      
   } /* End if () */
   else {
      
      stVisualEffectView  = [UIVisualEffectView appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]];
      
      if ([DKThemeVersionNight isEqualToString:[DKNightVersionManager sharedManager].themeVersion]) {
         
         eBlurEffectStyle  = UIBlurEffectStyleDark;
         
      } /* End if () */
      
      [stVisualEffectView setEffect:[UIBlurEffect effectWithStyle:eBlurEffectStyle]];
      
   } /* End else */
   
   __CATCH(nErr);
   
   return;
}

- (void)didReceiveMemoryWarning {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
   
   __CATCH(nErr);
   
   return;
}

- (void)viewWillAppear:(BOOL)aAnimated {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super viewWillAppear:aAnimated];
   
   __CATCH(nErr);
   
   return;
}

- (void)viewDidAppear:(BOOL)aAnimated {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super viewDidAppear:aAnimated];
   
   __CATCH(nErr);
   
   return;
}

- (void)viewWillDisappear:(BOOL)aAnimated {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super viewWillDisappear:aAnimated];
   
   __CATCH(nErr);
   
   return;
}

- (void)viewDidDisappear:(BOOL)aAnimated {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super viewDidDisappear:aAnimated];
   
   __CATCH(nErr);
   
   return;
}

#pragma mark -

+ (instancetype)showInViewController:(UIViewController *)aViewController
                  userInterfaceStyle:(UIUserInterfaceStyle)aUserInterfaceStyle
                           withTitle:(NSString *)aTitle
                             message:(NSString *)aMessage
                      preferredStyle:(UIAlertControllerStyle)aPreferredStyle
                   cancelButtonTitle:(NSString *)aCancelButtonTitle
              destructiveButtonTitle:(NSString *)aDestructiveButtonTitle
                   otherButtonTitles:(NSArray<NSString *> *)aOtherButtonTitles
#if TARGET_OS_IOS
  popoverPresentationControllerBlock:(IDEAAlertControllerPopoverPresentationControllerBlock)aPopoverPresentationControllerBlock
#endif
                          themeBlock:(IDEAAlertControllerThemeBlock)aThemeBlock
                            tapBlock:(IDEAAlertControllerCompletionBlock)aTapBlock {
   
   IDEAAlertController  *stAlertController  = [self alertControllerWithTitle:aTitle
                                                                     message:aMessage
                                                              preferredStyle:aPreferredStyle];
   
   if (aCancelButtonTitle && 0 < aCancelButtonTitle.length) {
      
      UIAlertAction  *stCancelAction   = [UIAlertAction actionWithTitle:aCancelButtonTitle
                                                                  style:UIAlertActionStyleCancel
                                                                handler:^(UIAlertAction *action) {
         if (aTapBlock) {
            
            aTapBlock(stAlertController, action, IDEAAlertControllerBlocksCancelButtonIndex);
            
         } /* End if () */
      }];
      
      [stAlertController addAction:stCancelAction];
      
   } /* End if () */
   
   for (NSUInteger H = 0; H < aOtherButtonTitles.count; H++) {
      
      NSString       *szOtherButtonTitle  = aOtherButtonTitles[H];
      
      UIAlertAction  *stOtherAction       = [UIAlertAction actionWithTitle:szOtherButtonTitle
                                                                     style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction *action) {
         if (aTapBlock) {
            
            aTapBlock(stAlertController, action, IDEAAlertControllerBlocksFirstOtherButtonIndex + H);
            
         } /* End if () */
      }];
      
      [stAlertController addAction:stOtherAction];
      
   } /* End for () */
   
#if TARGET_OS_IOS
   if (aPopoverPresentationControllerBlock) {
      
      aPopoverPresentationControllerBlock(stAlertController.popoverPresentationController);
      
   } /* End if () */
#endif // TARGET_OS_IOS
   
   if (aDestructiveButtonTitle) {
      
      UIAlertAction  *stDestructiveAction = [UIAlertAction actionWithTitle:aDestructiveButtonTitle
                                                                     style:UIAlertActionStyleDestructive
                                                                   handler:^(UIAlertAction *action) {
         
         if (aTapBlock) {
            
            aTapBlock(stAlertController, action, IDEAAlertControllerBlocksDestructiveButtonIndex);
            
         } /* End if () */
      }];
      
      [stAlertController addAction:stDestructiveAction];
      
   } /* End if () */
   
   if (nil != aThemeBlock) {
      
      stAlertController.themeBlock = aThemeBlock;
      
      aThemeBlock(stAlertController, stAlertController.actions);
      
   } /* End if () */
   
   LogDebug((@"+[IDEAAlertController showInViewController:] : %@", aViewController.topMost));
   
   [aViewController.topMost presentViewController:stAlertController
                                         animated:YES
                                       completion:nil];
   
//   if (@available(iOS 13.0, *)) {
//
//      stStrongController.overrideUserInterfaceStyle  = aUserInterfaceStyle;
//
//   } /* End if () */
   
   return stAlertController;
}

+ (instancetype)showAlertInViewController:(UIViewController *)aViewController
                       userInterfaceStyle:(UIUserInterfaceStyle)aUserInterfaceStyle
                                withTitle:(NSString *)aTitle
                                  message:(NSString *)aMessage
                        cancelButtonTitle:(NSString *)aCancelButtonTitle
                   destructiveButtonTitle:(NSString *)aDestructiveButtonTitle
                        otherButtonTitles:(NSArray<NSString *> *)aOtherButtonTitles
                               themeBlock:(IDEAAlertControllerThemeBlock)aThemeBlock
                                 tapBlock:(IDEAAlertControllerCompletionBlock)aTapBlock {
   
   return [self showInViewController:aViewController
                  userInterfaceStyle:aUserInterfaceStyle
                           withTitle:aTitle
                             message:aMessage
                      preferredStyle:UIAlertControllerStyleAlert
                   cancelButtonTitle:aCancelButtonTitle
              destructiveButtonTitle:aDestructiveButtonTitle
                   otherButtonTitles:aOtherButtonTitles
#if TARGET_OS_IOS
  popoverPresentationControllerBlock:nil
#endif
                          themeBlock:aThemeBlock
                            tapBlock:aTapBlock];
}

+ (instancetype)showActionSheetInViewController:(UIViewController *)aViewController
                             userInterfaceStyle:(UIUserInterfaceStyle)aUserInterfaceStyle
                                      withTitle:(NSString *)aTitle
                                        message:(NSString *)aMessage
                              cancelButtonTitle:(NSString *)aCancelButtonTitle
                         destructiveButtonTitle:(NSString *)aDestructiveButtonTitle
                              otherButtonTitles:(NSArray<NSString *> *)aOtherButtonTitles
#if TARGET_OS_IOS
             popoverPresentationControllerBlock:(IDEAAlertControllerPopoverPresentationControllerBlock)aPopoverPresentationControllerBlock
#endif
                                     themeBlock:(IDEAAlertControllerThemeBlock)aThemeBlock
                                       tapBlock:(IDEAAlertControllerCompletionBlock)aTapBlock {
   
   return [self showInViewController:aViewController
                  userInterfaceStyle:aUserInterfaceStyle
                           withTitle:aTitle
                             message:aMessage
                      preferredStyle:UIAlertControllerStyleActionSheet
                   cancelButtonTitle:aCancelButtonTitle
              destructiveButtonTitle:aDestructiveButtonTitle
                   otherButtonTitles:aOtherButtonTitles
#if TARGET_OS_IOS
  popoverPresentationControllerBlock:aPopoverPresentationControllerBlock
#endif
                          themeBlock:aThemeBlock
                            tapBlock:aTapBlock];
}
@end

#pragma mark - UIStoryboardSegue
@implementation IDEAAlertController (UIStoryboardSegue)

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)aSegue sender:(id)aSender {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   // Get the new view controller using [aSegue destinationViewController].
   // Pass the selected object to the new view controller.
   
   __CATCH(nErr);
   
   return;
}

@end
