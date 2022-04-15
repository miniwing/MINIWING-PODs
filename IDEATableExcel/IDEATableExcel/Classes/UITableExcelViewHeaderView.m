//
//  UITableExcelViewHeaderView.m
//  UITableExcel_Example
//
//  Created by Mr.Yao on 2019/12/12.
//  Copyright © 2019 flyOfUI. All rights reserved.
//

#import "UITableExcelViewHeaderView.h"
#import "UITableExcelViewMode.h"
#import "UIView+Layout.h"
#import "UITableExcelCell.h"
#import "UITableExcelViewColl.h"




@interface UITableExcelViewHeaderView ()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIExcelCellConfig *_config;
    NSArray *_slideColumn;
    NSArray *_fixedColumn;
    BOOL _isAllowedNotification;
    CGFloat _lastOffX;
}
@property (nonatomic, strong,readwrite) UICollectionView *collectionView;
@end


@implementation UITableExcelViewHeaderView

- (void)reloadDataFixed:(NSArray<UIColumnMode *> *)fixedColumn slide:(NSArray<UIColumnMode *> *)slideColumn{
    _slideColumn = slideColumn;
    _fixedColumn = fixedColumn;
    [_collectionView reloadData];
    for (int i = 0 ; i < _fixedColumn.count; i ++) {
        UIColumnMode *columnModel = fixedColumn[i];
        if (_config.columnStyle != UITableExcelViewColumnStyleBtn) {
            UILabel *label = [self viewWithTag:100 + i];
            label.text = columnModel.text;
        }else{
            UIButton *btn = [self viewWithTag:100 + i];
            [btn setTitle:columnModel.text forState:UIControlStateNormal];
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _slideColumn.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UITableExcelViewColl *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"defalutHeadCell"
                                                                           forIndexPath:indexPath];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UITableExcelViewColl *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    cell.menuLabel.borderWidth = _config.columnBorderWidth;
    cell.menuLabel.borderColor = _config.columnBorderColor;
    if (indexPath.row < _slideColumn.count) {
        UIColumnMode *columnModel = _slideColumn[indexPath.row];
        if (_config.columnStyle == UITableExcelViewColumnStyleBtn) {
            cell.contentView.backgroundColor = columnModel.backgroundColor;
        }
        cell.menuLabel.textColor = columnModel.textColor;
        cell.menuLabel.font = [UIFont systemFontOfSize:columnModel.fontSize];
        cell.menuLabel.text = columnModel.text;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < _slideColumn.count) {
        UIColumnMode *model = _slideColumn[indexPath.row];
        CGFloat hi = collectionView.frame.size.height;
        return CGSizeMake(model.width, hi <= 5 ? _config.defalutHeight : hi);
    }
    UIColumnMode *model =  _slideColumn.firstObject;
    return CGSizeMake(model.width, _config.defalutHeight);
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isAllowedNotification = NO;//
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _isAllowedNotification = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!_isAllowedNotification) {//是自身才发通知去tableView以及其他的cell
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:_config.notifiKey
                                                            object:self
                                                          userInfo:@{UI_EXCEL_NOTIFI_KEY:@(scrollView.contentOffset.x)}];
    }
    _isAllowedNotification = NO;
}

- (void)setContentOffset:(CGPoint)point{
    [_collectionView setContentOffset:point animated:NO];
}

- (void)scrollMove:(NSNotification*)notification{
    NSDictionary *noticeInfo = notification.userInfo;
    NSObject *obj = notification.object;
    float x = [noticeInfo[UI_EXCEL_NOTIFI_KEY] floatValue];
    
    if (obj != self) {
        _isAllowedNotification = YES;
        if (_lastOffX != x) {
            [_collectionView setContentOffset:CGPointMake(x, 0) animated:NO];
        }
        _lastOffX = x;
    }else{
        _isAllowedNotification = NO;
    }
    obj = nil;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
                                  fixed:(NSArray <UIColumnMode *>*)fixedColumn
                                  slide:(NSArray <UIColumnMode *>*)slideColumn
                             cellConfig:(UIExcelCellConfig *)config{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _config = config;
        _slideColumn = slideColumn;
        _fixedColumn = fixedColumn;
        [self prepareInitFixed:fixedColumn slide:slideColumn];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(scrollMove:)
                                                     name:_config.notifiKey
                                                   object:nil];
    }
    return self;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier cellConfig:(UIExcelCellConfig *)config{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _config = config;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(scrollMove:)
                                                     name:_config.notifiKey
                                                   object:nil];
    }
    return self;
}
- (void)setupViewWithFixed:(NSArray<UIColumnMode *> *)fixedColumn slide:(NSArray<UIColumnMode *> *)slideColumn{
    _slideColumn = slideColumn;
    _fixedColumn = fixedColumn;
    [self prepareInitFixed:fixedColumn slide:slideColumn];
}

- (void)prepareInitFixed:(NSArray <UIColumnMode *>*)fixedColumnList slide:(NSArray <UIColumnMode *>*)slideColumnList{
    CGFloat padding = 0;
    UIView *currentLabel = nil;
    NSInteger index = 0;
    for (UIColumnMode *column in fixedColumnList) {
        UIView *titleLbl = nil;
        if (_config.columnStyle != UITableExcelViewColumnStyleBtn) {
            UIDrawLabel *lbl = [UIDrawLabel new];
            lbl.text = column.text;
            lbl.font = [UIFont systemFontOfSize:column.fontSize];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.textColor = column.textColor;
            lbl.tag = 100 + index;
            lbl.borderWidth = _config.columnBorderWidth;
            lbl.borderColor = _config.columnBorderColor;
            titleLbl = lbl;
        }else{
            UIDrawButton *btn = [UIDrawButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = [UIFont systemFontOfSize:column.fontSize];
            [btn setTitleColor:column.textColor forState:UIControlStateNormal];
            btn.mode = column;
            [btn setTitle:column.text forState:UIControlStateNormal];
            btn.tag = 100 + index;
            btn.borderWidth = _config.columnBorderWidth;
            btn.borderColor = _config.columnBorderColor;
            btn.backgroundColor = column.backgroundColor;
            titleLbl = btn;
        }
        [self addSubview:titleLbl];
        if (currentLabel == nil) {
            [titleLbl addConstraint:NSLayoutAttributeLeft equalTo:self offset:padding];
            [titleLbl addConstraint:NSLayoutAttributeTop equalTo:self offset:padding];
            [titleLbl addConstraint:NSLayoutAttributeWidth equalTo:nil offset:column.width];
            [titleLbl addConstraint:NSLayoutAttributeBottom equalTo:self offset:-padding];
        }else{
            [titleLbl addConstraint:NSLayoutAttributeLeft equalTo:currentLabel toAttribute:NSLayoutAttributeRight offset:padding];
            [titleLbl addConstraint:NSLayoutAttributeTop equalTo:self offset:padding];
            [titleLbl addConstraint:NSLayoutAttributeWidth equalTo:nil offset:column.width];
            [titleLbl addConstraint:NSLayoutAttributeBottom equalTo:self offset:-padding];
        }
        currentLabel = titleLbl;
        index += 1;
    }
    if (slideColumnList.count > 0) {
//        UIColumnMode *column = slideColumnList.firstObject;
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//        layout.itemSize = CGSizeMake(column.width, _config.defalutHeight);
        layout.minimumInteritemSpacing = padding;
        layout.minimumLineSpacing = padding;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = self.backgroundColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[UITableExcelViewColl class] forCellWithReuseIdentifier:@"defalutHeadCell"];
        [self addSubview:_collectionView];
        if (currentLabel == nil) {
            [_collectionView addConstraint:NSLayoutAttributeLeft equalTo:self offset:padding];
        }else{
            [_collectionView addConstraint:NSLayoutAttributeLeft equalTo:currentLabel toAttribute:NSLayoutAttributeRight offset:padding];
        }
        [_collectionView addConstraint:NSLayoutAttributeRight equalTo:self offset:-padding];
        [_collectionView addConstraint:NSLayoutAttributeTop equalTo:self offset:padding];
        [_collectionView addConstraint:NSLayoutAttributeBottom equalTo:self offset:-padding];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_config.notifiKey object:nil];
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
