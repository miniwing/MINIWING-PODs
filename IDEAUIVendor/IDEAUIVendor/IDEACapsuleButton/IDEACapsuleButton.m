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

   __TRY;

   [super awakeFromNib];
   // Initialization code

   [self setBackgroundColor:UIColor.clearColor];

   [self.containerView setCornerRadius:self.containerView.height / 2 clipsToBounds:YES];
   [self.containerView setBackgroundColor:UIColor.clearColor];
   self.containerView.layer.borderWidth = 0.5f;
   self.containerView.layer.borderColor = UIColor.grayColor.CGColor;

   [self.moreButton setTitle:nil forState:UIControlStateNormal];
   [self.moreButton setTitle:nil forState:UIControlStateHighlighted];
   [self.moreButton setTitle:nil forState:UIControlStateSelected];

   [self.moreButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
   [self.moreButton setImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
      
      return [__IMAGE_NAMED_IN_BUNDLE(self.class, @"ic_more") imageRenderWithTintColor:[IDEAColor colorWithKey:[IDEAColor label]]];
   }
                             forState:UIControlStateNormal];
   
   [self.moreButton setImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
      
      return [__IMAGE_NAMED_IN_BUNDLE(self.class, @"ic_more") imageRenderWithTintColor:[IDEAColor colorWithKey:[IDEAColor darkGray]]];
   }
                             forState:UIControlStateSelected];
   
   [self.moreButton setImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
      
      return [__IMAGE_NAMED_IN_BUNDLE(self.class, @"ic_more") imageRenderWithTintColor:[IDEAColor colorWithKey:[IDEAColor darkGray]]];
   }
                             forState:UIControlStateHighlighted];

   
   [self.separationView setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor separator])];

   
   [self.stopButton setTitle:nil forState:UIControlStateNormal];
   [self.stopButton setTitle:nil forState:UIControlStateHighlighted];
   [self.stopButton setTitle:nil forState:UIControlStateSelected];
   [self.stopButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
   [self.stopButton setImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
      
      return [__IMAGE_NAMED_IN_BUNDLE(self.class, @"ic_done") imageRenderWithTintColor:[IDEAColor colorWithKey:[IDEAColor label]]];
   }
                             forState:UIControlStateNormal];
   
   [self.stopButton setImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
      
      return [__IMAGE_NAMED_IN_BUNDLE(self.class, @"ic_done") imageRenderWithTintColor:[IDEAColor colorWithKey:[IDEAColor darkGray]]];
   }
                             forState:UIControlStateSelected];
   
   [self.stopButton setImagePicker:^UIImage *(DKThemeVersion *aThemeVersion) {
      
      return [__IMAGE_NAMED_IN_BUNDLE(self.class, @"ic_done") imageRenderWithTintColor:[IDEAColor colorWithKey:[IDEAColor darkGray]]];
   }
                             forState:UIControlStateHighlighted];

   [self.trailingView setBackgroundColor:UIColor.clearColor];
   
   __CATCH(nErr);

   return;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)aRect {
   
   // Drawing code

   return;
}
*/

@end


@implementation IDEACapsuleButton (Notification)

+ (NSString *)moreNotification {
   
   return [[self class] notificationName:@"moreNotification"];
}

+ (NSString *)doneNotification {
   
   return [[self class] notificationName:@"doneNotification"];
   
}

@end
