//
//  IDEACapsuleButton.m
//  Pods
//
//  Created by Harry on 2024/8/18.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <IDEAKit/IDEAKit.h>

#import "IDEACapsuleButton.h"
#import "IDEACapsuleButton+Inner.h"
#import "IDEACapsuleButton+Action.h"

@implementation IDEACapsuleButton

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

- (void)awakeFromNib {

   int                            nErr                                     = EFAULT;

   UIImage                       *stImage                                  = nil;
   
   __TRY;

   [super awakeFromNib];
   // Initialization code

   [self setBackgroundColor:UIColor.clearColor];
   
   [self.containerView setCornerRadius:self.containerView.height / 2 clipsToBounds:YES];
   [self.containerView setBackgroundColor:UIColor.clearColor];
   self.containerView.layer.borderWidth = 0.5f;
   [self.containerView setBorderColorPicker:DKColorPickerWithKey(IDEAColor.label)];

//   [self.moreButton setTintColorPicker:DKColorPickerWithKey(IDEAColor.label)];
   [self.moreButton setTitle:nil forState:UIControlStateNormal];
   [self.moreButton setTitle:nil forState:UIControlStateHighlighted];
   [self.moreButton setTitle:nil forState:UIControlStateSelected];

   stImage  = __IMAGE_NAMED_IN_BUNDLE(self.class, @"ic_more");

//   [self.moreButton setImage:stImage
//                    forState:UIControlStateNormal];
//   [self.moreButton setImage:[stImage imageRenderWithTintColor:UIColor.darkGrayColor]
//                    forState:UIControlStateSelected];
//   [self.moreButton setImage:[stImage imageRenderWithTintColor:UIColor.darkGrayColor]
//                    forState:UIControlStateHighlighted];

   [self.moreButton setImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
      
      return [stImage imageRenderWithTintColor:[IDEAColor colorWithKey:IDEAColor.label]];
   }
                          forState:UIControlStateNormal];
   
   [self.moreButton setImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
      
      return [stImage imageRenderWithTintColor:[IDEAColor colorWithKey:IDEAColor.darkGray]];
   }
                          forState:UIControlStateSelected];
   
   [self.moreButton setImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
      
      return [stImage imageRenderWithTintColor:[IDEAColor colorWithKey:IDEAColor.darkGray]];
   }
                          forState:UIControlStateHighlighted];

   
   [self.separationView setBackgroundColorPicker:DKColorPickerWithKey(IDEAColor.separator)];

   
//   [self.stopButton setTintColorPicker:DKColorPickerWithKey(IDEAColor.label)];
   [self.stopButton setTitle:nil forState:UIControlStateNormal];
   [self.stopButton setTitle:nil forState:UIControlStateHighlighted];
   [self.stopButton setTitle:nil forState:UIControlStateSelected];

   stImage  = __IMAGE_NAMED_IN_BUNDLE(self.class, @"ic_done");
//   [self.stopButton setImage:stImage
//                    forState:UIControlStateNormal];
//   [self.stopButton setImage:[stImage imageRenderWithTintColor:UIColor.darkGrayColor]
//                    forState:UIControlStateSelected];
//   [self.stopButton setImage:[stImage imageRenderWithTintColor:UIColor.darkGrayColor]
//                    forState:UIControlStateHighlighted];

   [self.stopButton setImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
      
      return [stImage imageRenderWithTintColor:[IDEAColor colorWithKey:IDEAColor.label]];
   }
                          forState:UIControlStateNormal];
   [self.stopButton setImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
      
      return [stImage imageRenderWithTintColor:[IDEAColor colorWithKey:IDEAColor.darkGray]];
   }
                          forState:UIControlStateSelected];
   [self.stopButton setImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
      
      return [stImage imageRenderWithTintColor:[IDEAColor colorWithKey:IDEAColor.darkGray]];
   }
                          forState:UIControlStateHighlighted];

   [self.trailingView setBackgroundColor:UIColor.clearColor];
   
   [self.moreButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
   [self.stopButton.imageView setContentMode:UIViewContentModeScaleAspectFit];

   __CATCH(nErr);

   return;
}

+ (CGFloat)fixedWidth {
   
   return 92.0f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)aRect {
   
   // Drawing code

   return;
}
*/

- (void)setTintColor:(UIColor *)aTintColor {
   
   int                            nErr                                     = EFAULT;
   
   UIImage                       *stImage                                  = nil;
   
   __TRY;

   if (nil != aTintColor) {

      stImage  = __IMAGE_NAMED_IN_BUNDLE(self.class, @"ic_more");

      [self.moreButton setTintColor:aTintColor];
      [self.moreButton setImage:[stImage imageRenderWithTintColor:aTintColor] forState:UIControlStateNormal];


      stImage  = __IMAGE_NAMED_IN_BUNDLE(self.class, @"ic_done");
      [self.stopButton setTintColor:aTintColor];
      [self.stopButton setImage:[stImage imageRenderWithTintColor:aTintColor] forState:UIControlStateNormal];

      self.containerView.layer.borderColor = aTintColor.CGColor;

   } /* End if () */
   
   __CATCH(nErr);

   return;
}

- (void)setTintColorPicker:(DKColorPicker)aTintColorPicker {
   
   int                            nErr                                     = EFAULT;

   UIImage                       *stImage                                  = nil;
   
   __TRY;

   LogDebug((@"-[IDEACapsuleButton setTintColorPicker:] : moreButton : 0x%08x", self.moreButton));
   LogDebug((@"-[IDEACapsuleButton setTintColorPicker:] : stopButton : 0x%08x", self.stopButton));

   if (nil == aTintColorPicker) {
      
      [self.moreButton setImagePicker:nil forState:UIControlStateNormal];
      [self.moreButton setImagePicker:nil forState:UIControlStateHighlighted];
      [self.moreButton setImagePicker:nil forState:UIControlStateSelected];
      
      [self.stopButton setImagePicker:nil forState:UIControlStateNormal];
      [self.stopButton setImagePicker:nil forState:UIControlStateHighlighted];
      [self.stopButton setImagePicker:nil forState:UIControlStateSelected];

   } /* End if () */
   
   [self.moreButton setTintColorPicker:aTintColorPicker];
   [self.stopButton setTintColorPicker:aTintColorPicker];
   [self.containerView setBorderColorPicker:aTintColorPicker];

   __CATCH(nErr);

   return;
}

+ (NSString *)moreNotification {
   
   return [[self class] notificationName:@(__PRETTY_FUNCTION__)];
}

+ (NSString *)doneNotification {
   
   return [[self class] notificationName:@(__PRETTY_FUNCTION__)];
}

@end
