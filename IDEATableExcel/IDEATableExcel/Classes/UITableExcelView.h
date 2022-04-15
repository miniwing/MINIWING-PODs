//
//  UITableExcelView.h
//  UITableExcel_Example
//
//  Created by Mr.Yao on 2019/12/11.
//  Copyright © 2019 flyOfUI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableExcelViewMode.h"
#import "UIView+Layout.h"

NS_ASSUME_NONNULL_BEGIN



typedef NS_ENUM(NSInteger, UITableExcelViewHeaderInSectionMode) {
   UITableExcelViewHeaderInSectionModeNone = 0,
   UITableExcelViewHeaderInSectionModeCustom,
};

@class UITableExcelView;

@protocol UITableExcelViewDataSource<NSObject>
@required
///  固定的列
/// @param excelView UITableExcelView
/// @param section 组
- (nullable NSArray <UIColumnMode *>*)tableExcelView:(UITableExcelView *)excelView titleForFixedHeaderInSection:(NSInteger)section;
///  可滑动的列
/// @param excelView UITableExcelView
/// @param section 组
- (nullable NSArray <UIColumnMode *>*)tableExcelView:(UITableExcelView *)excelView titleForSlideHeaderInSection:(NSInteger)section;
/// 每组对应多少行
/// @param excelView UITableExcelView
/// @param section 组
- (NSInteger)tableExcelView:(UITableExcelView *)excelView numberOfRowsInSection:(NSInteger)section;

@optional
/// 组数
/// @param excelView UITableExcelView
- (NSInteger)numberOfSectionsInTableExcelView:(UITableExcelView *)excelView;
/// 返回数据对应数据源（固定的列）
/// @param excelView UITableExcelView
/// @param indexPath indexPath
- (nullable NSArray <UIColumnMode *>*)tableExcelView:(UITableExcelView *)excelView fixedCellForRowAtIndexPath:(NSIndexPath *)indexPath;
/// 返回数据对应数据源（可滑动的列）
/// @param excelView UITableExcelView
/// @param indexPath indexPath
- (nullable NSArray <UIColumnMode *>*)tableExcelView:(UITableExcelView *)excelView slideCellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@protocol UITableExcelViewDelegate <NSObject>
@optional
/// 组头
/// UITableExcelViewHeaderInSectionModeNone-没有组头  ｜UITableExcelViewHeaderInSectionModeCustom-自定义
/// @param excelView UITableExcelView
- (UITableExcelViewHeaderInSectionMode)tableExcelView:(UITableExcelView *)excelView modeForHeaderInSection:(NSInteger)section;
/// 组头视图
/// @param excelView excelView
/// @param section 某组
- (UIView *)tableExcelView:(UITableExcelView *)excelView viewForHeaderInSection:(NSInteger)section;
/// 组头视图的高度
/// @param excelView excelView
/// @param section 某组
- (CGFloat )tableExcelView:(UITableExcelView *)excelView heightForHeaderInSection:(NSInteger)section;
/// 点击单元格的回调
/// @param tableView UITableExcelView
/// @param indexPath indexPath(section-组|row-行|colunmn-列)
- (void)tableExcelView:(UITableExcelView *)tableView didSelectColumnAtIndexPath:(NSIndexPath *)indexPath;

/// 每一行的高度
/// @param excelView excelView
/// @param indexPath indexPath
- (CGFloat )tableExcelView:(UITableExcelView *)excelView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface UITableExcelView : UIView

/** 内部通知的name */
@property (nonatomic, strong, readonly) NSString *NotificationID;
/** 数据源的委托 */
@property (nonatomic, weak, nullable) id <UITableExcelViewDataSource>dataSource;
/** 委托 */
@property (nonatomic, weak, nullable) id <UITableExcelViewDelegate>delegate;
/**分割线的颜色*/
@property (nonatomic, strong) UIColor *dividerColor;
/**分割线的宽或者高*/
@property (nonatomic, assign) CGFloat widthOrHeight;
/**是否添加滑动区域分割线*/
@property (nonatomic, assign, getter=isAddSlidingAreaDivider) BOOL addverticalDivider;
/**是否添加滑动区域分割线*/
@property (nonatomic, assign, getter=isAddSlidingAreaDivider) BOOL addHorizontalDivider;
/**标题栏 只需要设置frame的height*/
@property (nonatomic, strong, nullable) UIView *tableHeaderView;
/**表尾栏  只需要设置frame的height**/
@property (nonatomic, strong, nullable) UIView *tableFooterView;
/**contentView outside border*/
@property (nonatomic, strong, nullable) UIColor *outsideBorder;

/**固定行的背景颜色*/
@property (nonatomic, strong, nullable) UIColor *fixedHeaderColor;

/**contentView outside border width*/
@property (nonatomic, assign) CGFloat outsideBorderWidth;
/**list view bounces ,defalut is NO */
@property (nonatomic, assign) BOOL bounces;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;


/// 自定义cell
/// @param excelCell cell类
- (void)registerClass:(Class)excelCell;

/// 构造方法
/// @param frame frame
/// @param mode mode
- (instancetype)initWithFrame:(CGRect)frame
                     withMode:(UITableExcelViewMode *)mode;
/// 刷新头部
- (void)reloadHeadData;
/// 刷新 内容部分
- (void)reloadContentData;
/// 刷新整个表
- (void)reloadData;
/// 刷新某行【指定列无效】
/// @param indexPaths 集合
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
/// 选中某一行
/// @param indexPath indexPath
/// @param animated animated
/// @param scrollPosition scrollPosition
- (void)selectRowAtIndexPath:(nullable NSIndexPath *)indexPath
                    animated:(BOOL)animated
              scrollPosition:(UITableViewScrollPosition)scrollPosition;



@end

NS_ASSUME_NONNULL_END
