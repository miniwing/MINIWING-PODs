//
//  UITableExcelViewHeaderView.h
//  UITableExcel_Example
//
//  Created by Mr.Yao on 2019/12/12.
//  Copyright © 2019 flyOfUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIColumnMode;
@class UIExcelCellConfig;

NS_ASSUME_NONNULL_BEGIN

@interface UITableExcelViewHeaderView : UITableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier NS_UNAVAILABLE;

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
                             cellConfig:(UIExcelCellConfig *)config;

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
                                  fixed:(NSArray <UIColumnMode *>*)fixedColumn
                                  slide:(NSArray <UIColumnMode *>*)slideColumn
                             cellConfig:(UIExcelCellConfig *)config;

- (void)setupViewWithFixed:(NSArray <UIColumnMode *>*)fixedColumn
                     slide:(NSArray <UIColumnMode *>*)slideColumn;

- (void)reloadDataFixed:(NSArray <UIColumnMode *>*)fixedColumn
                  slide:(NSArray <UIColumnMode *>*)slideColumn;

@end

NS_ASSUME_NONNULL_END
