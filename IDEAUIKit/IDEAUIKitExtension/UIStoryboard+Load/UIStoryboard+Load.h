//
//  UIStoryboard+Load.h
//  UIStoryboard+Load
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail:miniwing.hz@gmail.com
//  TEL :+(852)53054612
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (Load)

+ (NSString *)storyboard:(NSString *)aStoryboard PAD:(BOOL)aPAD;
+ (id)loadStoryboard:(NSString *)aStoryboard viewController:(Class)aClass;
+ (id)loadStoryboard:(NSString *)aStoryboard identifier:(NSString *)aIdentifier;
+ (id)loadStoryboardRoot:(NSString *)aStoryboard;

+ (id)loadStoryboard:(NSString *)aStoryboard viewController:(Class)aClass inBundle:(NSString *)aBundle;

- (id)loadViewController:(Class)aClass;

@end

@interface UIStoryboard (Framework)
+ (id)loadStoryboard:(NSString *)aStoryboard viewController:(Class)aClass framework:(NSString *)aFramework;
@end



