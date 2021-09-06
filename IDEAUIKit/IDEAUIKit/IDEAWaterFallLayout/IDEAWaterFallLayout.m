//
//  IDEAWaterFallLayout.m
//  IDEAWaterFallLayout
//
//  Created by Harry on 2017/5/18.
//  Copyright © 2017年 . All rights reserved.
//

#import "IDEAWaterFallLayout.h"

/** 默认的列数    */
static const CGFloat       DEFAULT_COLUNM_COUNT    = 3;
/** 每一列之间的间距    */
static const CGFloat       DEFAULT_COLUNM_MARGIN   = 10;

/** 每一行之间的间距    */
static const CGFloat       DEFAULTROWMARGIN        = 10;

/** 内边距    */
static const UIEdgeInsets  DEFAULTEDGEINSETS       = {10, 10, 10, 10};


@interface IDEAWaterFallLayout ()

/** 存放所有的布局属性 */
@property (nonatomic, strong)                      NSMutableArray                      * attrsArr;
/** 存放所有列的当前高度 */
@property (nonatomic, strong)                      NSMutableArray                      * columnHeights;
/** 内容的高度 */
@property (nonatomic, assign)                      CGFloat                               contentHeight;

@end

@interface IDEAWaterFallLayout ()

- (NSUInteger)colunmCount;
- (CGFloat)columnMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)edgeInsets;

@end

@implementation IDEAWaterFallLayout

#pragma mark 懒加载
- (NSMutableArray *)attrsArr {
   
   if (!_attrsArr) {
      
      _attrsArr = [NSMutableArray array];
      
   } /* End if () */
   
   return _attrsArr;
}

- (NSMutableArray *)columnHeights {
   
   if (!_columnHeights) {
      
      _columnHeights = [NSMutableArray array];

   } /* End if () */

   return _columnHeights;
}

#pragma mark - 数据处理
/**
 * 列数
 */
- (NSUInteger)colunmCount {
   
   if ([self.delegate respondsToSelector:@selector(columnCountInWaterFallLayout:)]) {
      
      return [self.delegate columnCountInWaterFallLayout:self];
      
   } /* End if () */
   else {
      
      return DEFAULT_COLUNM_COUNT;

   } /* End else */
}

/**
 * 列间距
 */
- (CGFloat)columnMargin {
   
   if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFallLayout:)]) {
      
      return [self.delegate columnMarginInWaterFallLayout:self];
      
   } /* End if () */
   else {
      
      return DEFAULT_COLUNM_MARGIN;

   } /* End else */
}

/**
 * 行间距
 */
- (CGFloat)rowMargin {
   
   if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFallLayout:)]) {
      
      return [self.delegate rowMarginInWaterFallLayout:self];

   } /* End if () */
   else {
      
      return DEFAULTROWMARGIN;

   } /* End else */
}

/**
 * item的内边距
 */
- (UIEdgeInsets)edgeInsets {
   
   if ([self.delegate respondsToSelector:@selector(edgeInsetdInWaterFallLayout:)]) {
      
      return [self.delegate edgeInsetdInWaterFallLayout:self];
   }
   else {
      
      return DEFAULTEDGEINSETS;
   }
}

/**
 * 初始化
 */
- (void)prepareLayout {
   
   [super prepareLayout];
   
   self.contentHeight = 0;
   
   // 清楚之前计算的所有高度
   [self.columnHeights removeAllObjects];
   
   // 设置每一列默认的高度
   for (NSInteger H = 0; H < DEFAULT_COLUNM_COUNT ; H++) {
      
      [self.columnHeights addObject:@(DEFAULTEDGEINSETS.top)];
      
   } /* End if () */
   
   // 清除之前所有的布局属性
   [self.attrsArr removeAllObjects];
   
   // 开始创建每一个cell对应的布局属性
   NSInteger                         count         = [self.collectionView numberOfItemsInSection:0];
   UICollectionViewLayoutAttributes *stAttrs       = nil;
   NSIndexPath                      *stIndexPath   = nil;

   for (int H = 0; H < count; H++) {
      
      // 创建位置
      stIndexPath = [NSIndexPath indexPathForItem:H inSection:0];
      
      // 获取indexPath位置上cell对应的布局属性
      stAttrs  = [self layoutAttributesForItemAtIndexPath:stIndexPath];
      
      [self.attrsArr addObject:stAttrs];
      
   } /* End if () */
 
   return;
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)aIndexPath {
   
   // 创建布局属性
   UICollectionViewLayoutAttributes *stAttrs          = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:aIndexPath];
   
   //collectionView的宽度
   CGFloat                           fCollectionViewW = self.collectionView.frame.size.width;
   
   // 设置布局属性的frame
   CGFloat cellW  = (fCollectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.colunmCount) * self.columnMargin) / self.colunmCount;
   CGFloat cellH  = [self.delegate waterFallLayout:self heightForItemAtIndexPath:aIndexPath itemWidth:cellW];
   
   // 找出最短的那一列
   NSInteger    destColumn       = 0;
   CGFloat      minColumnHeight  = [self.columnHeights[0] doubleValue];
   
   for (int H = 1; H < DEFAULT_COLUNM_COUNT; H++) {
      
      // 取得第i列的高度
      CGFloat columnHeight = [self.columnHeights[H] doubleValue];
      
      if (minColumnHeight > columnHeight) {
         
         minColumnHeight = columnHeight;
         destColumn = H;
         
      } /* End if () */

   } /* End for () */

   CGFloat cellX = self.edgeInsets.left + destColumn * (cellW + self.columnMargin);
   CGFloat cellY = minColumnHeight;
   if (cellY != self.edgeInsets.top) {
      
      cellY += self.rowMargin;
      
   } /* End if () */
   
   stAttrs.frame = CGRectMake(cellX, cellY, cellW, cellH);
   
   // 更新最短那一列的高度
   self.columnHeights[destColumn] = @(CGRectGetMaxY(stAttrs.frame));
   
   // 记录内容的高度 - 即最长那一列的高度
   CGFloat maxColumnHeight = [self.columnHeights[destColumn] doubleValue];
   if (self.contentHeight < maxColumnHeight) {
      
      self.contentHeight = maxColumnHeight;
      
   } /* End if () */
   
   return stAttrs;
}

/**
 * 决定cell的高度
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)aRect {
   
   return self.attrsArr;
}

/**
 * 内容的高度
 */
- (CGSize)collectionViewContentSize {
   
   //    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
   //    for (int i = 0; i < DefaultColunmCount; i++) {
   //
   //        // 取得第i列的高度
   //        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
   //
   //        if (maxColumnHeight < columnHeight) {
   //            maxColumnHeight = columnHeight;
   //        }
   //
   //    }
   
   return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}

@end

