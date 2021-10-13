//
//  UIStoryboard+Kit.h
//  Idea
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail:iidioter@gmail.com
//  TEL :+(86)18668032582
//

#import <UIKit/UIKit.h>

#define IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

NS_ASSUME_NONNULL_BEGIN

@interface UIStoryboard (UIViewController)

+ (NSString *)storyboard:(NSString *)aStoryboard PAD:(BOOL)aPAD;
+ (id)loadStoryboard:(NSString *)aStoryboard viewController:(Class)aClass;
+ (id)loadStoryboardRoot:(NSString *)aStoryboard;

- (id)loadViewController:(Class)aClass;

@end

NS_ASSUME_NONNULL_END
