//
//  UITableExcelViewMode.m
//  UITableExcel_Example
//
//  Created by Mr.Yao on 2019/12/11.
//  Copyright © 2019 flyOfUI. All rights reserved.
//

#import "UITableExcelViewMode.h"


@implementation UITableExcelViewMode

- (instancetype)init {
   
   self = [super init];
   
   if (self) {
      
      _defalutHeight = 40;
   }
   
   return self;
}
@end

@implementation UIColumnMode

- (instancetype)init {
   
   self = [super init];
   
   if (self) {
      
      _textColor  = [UIColor darkGrayColor];
      _fontSize   = 14;
      _selectedBackgroundColor = [UIColor systemGrayColor];
   }
   
   return self;
}

@end

@implementation UIExcelCellConfig

@end
