//
//  IDEAWaterFallLayout.h
//  IDEAKit
//
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDEAWaterFallLayout;

@protocol IDEAWaterFallLayoutDelegate<NSObject>

@required
/**
 * 每个item的高度
 */
- (CGFloat)waterFallLayout:(IDEAWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSIndexPath *)aIndexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(IDEAWaterFallLayout *)waterFallLayout;

/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(IDEAWaterFallLayout *)waterFallLayout;

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(IDEAWaterFallLayout *)waterFallLayout;

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(IDEAWaterFallLayout *)waterFallLayout;


@end

@interface IDEAWaterFallLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) IBOutlet   id<IDEAWaterFallLayoutDelegate> delegate;

@end
