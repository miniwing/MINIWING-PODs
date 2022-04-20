//
//  UITableExcelViewColl.m
//  UITableExcel_Example
//
//  Created by Mr.Yao on 2019/12/12.
//  Copyright © 2019 flyOfUI. All rights reserved.
//

#import "UITableExcelViewColl.h"
#import "UIView+Layout.h"

@interface UITableExcelViewColl ()

@end

@implementation UITableExcelViewColl

- (instancetype)initWithFrame:(CGRect)aFrame {
   
   self = [super initWithFrame:aFrame];
   
   if (self) {
      
      UIDrawLabel *stMenuLabel   = [[UIDrawLabel alloc] initWithFrame:aFrame];
      stMenuLabel.font = [UIFont systemFontOfSize:15];
      stMenuLabel.textAlignment = NSTextAlignmentCenter;

//      [self.contentView setTranslatesAutoresizingMaskIntoConstraints:YES];
      [self.contentView addSubview:stMenuLabel];
      _menuLabel = stMenuLabel;

      [_menuLabel addConstraint:NSLayoutAttributeLeft    equalTo:self.contentView offset:0];
      [_menuLabel addConstraint:NSLayoutAttributeTop     equalTo:self.contentView offset:0];
      [_menuLabel addConstraint:NSLayoutAttributeWidth   equalTo:self.contentView offset:0];
      [_menuLabel addConstraint:NSLayoutAttributeBottom  equalTo:self.contentView offset:0];
   }
   
   return self;
}

//- (void)awakeFromNib {
//
//   [super awakeFromNib];
//
//   UIDrawLabel *stMenuLabel   = [UIDrawLabel new];
//   stMenuLabel.font = [UIFont systemFontOfSize:15];
//   stMenuLabel.textAlignment = NSTextAlignmentCenter;
//
//   [self.contentView setTranslatesAutoresizingMaskIntoConstraints:YES];
//   [self.contentView addSubview:stMenuLabel];
//   _menuLabel = stMenuLabel;
//
//   [_menuLabel addConstraint:NSLayoutAttributeLeft    equalTo:self.contentView offset:0];
//   [_menuLabel addConstraint:NSLayoutAttributeTop     equalTo:self.contentView offset:0];
//   [_menuLabel addConstraint:NSLayoutAttributeWidth   equalTo:self.contentView offset:0];
//   [_menuLabel addConstraint:NSLayoutAttributeBottom  equalTo:self.contentView offset:0];
//
//
//   return;
//}

@end
