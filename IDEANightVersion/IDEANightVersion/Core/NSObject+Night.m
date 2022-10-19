//
//  NSObject+Night.m
//  DKNightVersion
//
//  Created by Draveness on 15/11/7.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "NSObject+Night.h"
#import "NSObject+DeallocBlock.h"
#import <objc/runtime.h>

static void *DKViewDeallocHelperKey;

@interface NSObject ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *pickers;

@end

@implementation NSObject (Night)

- (NSMutableDictionary<NSString *, DKColorPicker> *)pickers {
   
   NSMutableDictionary<NSString *, DKColorPicker> *stPickers = objc_getAssociatedObject(self, @selector(pickers));
   
   if (!stPickers) {
      
      @autoreleasepool {
         
         // Need to removeObserver in dealloc
         if (objc_getAssociatedObject(self, &DKViewDeallocHelperKey) == nil) {
            
            __unsafe_unretained typeof(self) weakSelf = self; // NOTE: need to be __unsafe_unretained because __weak var will be reset to nil in dealloc
            
            id deallocHelper = [self addDeallocBlock:^{
               
               [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
            }];
            
            objc_setAssociatedObject(self, &DKViewDeallocHelperKey, deallocHelper, OBJC_ASSOCIATION_ASSIGN);
            
         } /* End () */
         
      } /* @autoreleasepool */
      
      stPickers = [[NSMutableDictionary alloc] init];
      objc_setAssociatedObject(self, @selector(pickers), stPickers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
      
      [[NSNotificationCenter defaultCenter] removeObserver:self
                                                      name:DKNightVersionThemeChangingNotification
                                                    object:nil];
//      [[NSNotificationCenter defaultCenter] removeObserver:self];

      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(night_updateColor:)
                                                   name:DKNightVersionThemeChangingNotification
                                                 object:nil];

   } /* End () */
   
   return stPickers;
}

- (DKNightVersionManager *)themeManager {
   
   return [DKNightVersionManager sharedManager];
}

- (void)night_updateColor:(NSNotification *)aNotification {
   
   [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull aSelector, DKPicker _Nonnull aPicker, BOOL * _Nonnull aStop) {
      
//      LogDebug((@"-[NSObject night_updateColor] : %@", aSelector));
//
//      if ([aSelector isEqualToString:@"setText:"]) {
//         
//         LogDebug((@"-[aSelector isEqualToString:@\"setText:\"]"));
//         
//      } /* End if () */
      
      SEL stSEL      = NSSelectorFromString(aSelector);
      id  stResult   = aPicker(self.themeManager.themeVersion);
      
      [UIView animateWithDuration:DKNightVersionAnimationDuration
                       animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
         [self performSelector:stSEL withObject:stResult];
#pragma clang diagnostic pop
      }];
   }];
}

@end
