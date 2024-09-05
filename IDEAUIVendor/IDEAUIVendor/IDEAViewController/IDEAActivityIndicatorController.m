//
//  IDEAActivityIndicatorController.m
//  IDEAUIVendor
//
//  Created by Harry on 2021/6/8.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAActivityIndicatorController.h"

#if __has_include(<MaterialComponents/MaterialPalettes.h>)
#  import <MaterialComponents/MaterialPalettes.h>
#elif __has_include("MaterialComponents/MaterialPalettes.h")
#  import "MaterialComponents/MaterialPalettes.h"
#elif __has_include("MaterialPalettes.h")
#  import "MaterialPalettes.h"
#else
//#  define MATERIAL_PALETTES                                             (0)
#endif

@interface IDEAActivityIndicatorController ()

@end

@implementation IDEAActivityIndicatorController

- (void)dealloc {

   __LOG_FUNCTION;

   // Custom dealloc

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

   __TRY;

   [super viewDidLoad];

   // Do any additional setup after loading the view.
   
   if (nil == self.activityIndicator) {
      
#if MATERIAL_COMPONENTS
      self.activityIndicator  = [[MDCActivityIndicator alloc] initWithFrame:CGRectMake(0, 0, self.activityIndicatorRadius * 2, self.activityIndicatorRadius * 2)];
#else /* MATERIAL_COMPONENTS */
      
#  ifdef __IPHONE_13_0
      self.activityIndicator  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
#  else /* __IPHONE_13_0 */
      self.activityIndicator  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
#  endif /* !__IPHONE_13_0 */
#endif /* !MATERIAL_COMPONENTS */
      
   } /* End if () */

   if (0 != self.activityIndicatorRadius) {
      
      [self.activityIndicator setSize:CGSizeMake(self.activityIndicatorRadius * 2, self.activityIndicatorRadius * 2)];
      
   } /* End if () */
   
   [self.view addSubview:self.activityIndicator];
   [self.activityIndicator setCenter:self.view.center];
   
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

@end

#pragma mark - UIStoryboardSegue
@implementation IDEAActivityIndicatorController (UIStoryboardSegue)

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

#pragma mark - UITheme
@implementation IDEAActivityIndicatorController (Theme)

#if IDEA_NIGHT_VERSION_MANAGER
- (void)onThemeUpdate:(NSNotification *)aNotification {

   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   LogDebug((@"-[IDEAActivityIndicatorController onThemeUpdate:] : Notification : %@", aNotification));

   /**
    Super onThemeUpdate
    */
   if ([super respondsToSelector:@selector(onThemeUpdate:)]) {

      [super onThemeUpdate:aNotification];
      
   } /* End if () */
   else {
      
      [self setNeedsStatusBarAppearanceUpdate];
      
   } /* End else */

   __CATCH(nErr);

   return;
}
#endif /* if IDEA_NIGHT_VERSION_MANAGER */

#pragma mark - UIStatusBar
- (UIStatusBarStyle)preferredStatusBarStyle {
   
   LogView((@"-[%@ preferredStatusBarStyle]", [self class]));
   
#if IDEA_NIGHT_VERSION_MANAGER
   if ([DKThemeVersionNight isEqualToString:[DKNightVersionManager sharedManager].themeVersion]) {
      
      return UIStatusBarStyleLightContent;
      
   } /* End if () */
   else { // if ([[DKNightVersionManager sharedManager].themeVersion isEqualToString:DKThemeVersionNormal])
#endif
      
      if (@available(iOS 13.0, *)) {
         
         // 系统版本高于 13.0
         return UIStatusBarStyleDarkContent;
         
      } /* End if () */
      
      return UIStatusBarStyleDefault;
#if IDEA_NIGHT_VERSION_MANAGER
   } /* End if () */
#endif
}

#pragma mark - UIUserInterfaceStyle
- (UIUserInterfaceStyle)overrideUserInterfaceStyle {
   
   //   if (UIUserInterfaceStyleDark == self.traitCollection.userInterfaceStyle) {
   //
   //      return UIUserInterfaceStyleDark;
   //
   //   } /* End if () */
   //   else {
   //
   //      return UIUserInterfaceStyleLight;
   //
   //   } /* End else */
   
   if ([DKThemeVersionNight isEqualToString:[DKNightVersionManager sharedManager].themeVersion]) {
      
      return UIUserInterfaceStyleDark;
      
   } /* End if () */
   else { // if ([[DKNightVersionManager sharedManager].themeVersion isEqualToString:DKThemeVersionNormal])
      
      return UIUserInterfaceStyleLight;
      
   } /* End if () */
}

- (BOOL)prefersStatusBarHidden {

   LogView((@"-[%@ prefersStatusBarHidden]", [self class]));

   return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {

   LogView((@"-[%@ preferredStatusBarUpdateAnimation]", [self class]));

   return UIStatusBarAnimationFade;
}

- (BOOL)shouldAutorotate {

   LogView((@"-[%@ shouldAutorotate]", [self class]));

   return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {

   LogView((@"-[%@ supportedInterfaceOrientations]", [self class]));

   return UIInterfaceOrientationMaskPortrait;
}

// Controls the application's preferred home indicator auto-hiding when this view controller is shown.
- (BOOL)prefersHomeIndicatorAutoHidden {
   
   LogView((@"-[%@ prefersHomeIndicatorAutoHidden]", [self class]));

   return YES;
}

- (UIModalPresentationStyle)modalPresentationStyle {

   LogView((@"-[%@ modalPresentationStyle]", [self class]));

   return UIModalPresentationFullScreen;
}

@end

