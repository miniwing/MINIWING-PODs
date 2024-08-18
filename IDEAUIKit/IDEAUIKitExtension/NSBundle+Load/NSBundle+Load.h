//
//  NSBundle+Load.h
//  NSBundle+Load
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail:miniwing.hz@gmail.com
//  TEL :+(852)53054612
//

#import <UIKit/UIKit.h>

@interface NSBundle (Load)

- (UIView *)loadViewWithNib:(NSString *)aNib class:(Class)aClass;

#if 0
- (UIView *)loadViewWithNib:(NSString *)aNib class:(Class)aClass inBundle:(NSString *)aBundle;
#endif // 0

@end
