//
//  UITableExcelCell.h
//  UITableExcel_Example
//
//  Created by Mr.Yao on 2019/12/12.
//  Copyright © 2019 flyOfUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIColumnMode;
@class UIExcelCellConfig;
@class UITableExcelCell;
NS_ASSUME_NONNULL_BEGIN


UIKIT_EXTERN NSString *const UI_EXCEL_NOTIFI_KEY;


@protocol UITableExcelCellDelegate <NSObject>

- (void)clickExcel:(UITableExcelCell *)cell collectionViewForIndexPath:(NSIndexPath *)indexPath column:(NSInteger)column;


@end

@interface UITableExcelCell : UITableViewCell

@property (nonatomic,   weak, nullable) id <UITableExcelCellDelegate>delegate;

@property (nonatomic,   copy, nullable)  void(^collClick)(UITableViewCell *cell);

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@property (nonatomic, strong, readonly) UIImageView *lineView;


- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                        fixed:(NSArray <UIColumnMode *>*)fixedColumn
                        slide:(NSArray <UIColumnMode *>*)slideColumn
                   cellConfig:(UIExcelCellConfig *)config;
//刷新滑动区域
- (void)reloadFixed:(NSArray <UIColumnMode *>*)fixedColumn
              slide:(NSArray <UIColumnMode *>*)slideColumn;
//选择操作
- (void)selectedItemAtIndexPath:(nullable NSIndexPath *)indexPath fixedItem:(NSInteger)column;
//取消选择操作
- (void)deselectItemAtIndexPath:(nullable NSIndexPath *)indexPath fixedItem:(NSInteger)column;

@end

NS_ASSUME_NONNULL_END
