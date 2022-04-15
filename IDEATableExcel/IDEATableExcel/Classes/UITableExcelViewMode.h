//
//  UITableExcelViewMode.h
//  UITableExcel_Example
//
//  Created by Mr.Yao on 2019/12/11.
//  Copyright © 2019 flyOfUI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, UITableExcelViewColumnStyle) {
    UITableExcelViewColumnStyleText = 0,//纯文本显示[不支持行选择以及单元格单击操作]
    UITableExcelViewLineStyleText ,//文本显示[支持行选择不支持单元格单击操作]
    UITableExcelViewColumnStyleBtn,//每个单元格均可点击不支持行选择
};
typedef NS_ENUM(NSInteger, UITableExcelViewSectionStyle) {
    UITableExcelViewSectionStylePlain,          // regular table view
    UITableExcelViewSectionStyleGrouped,        // sections are grouped together
    UITableExcelViewSectionStyleInsetGrouped  API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(tvos)  // 暂不支持
};

@interface UIColumnMode : NSObject
/** 标题*/
@property (nonatomic, copy,nullable) NSString *text;
/**列的宽度*/
@property (nonatomic, assign) CGFloat width;
/**文字大小*/
@property (nonatomic, assign) CGFloat fontSize;
/**文字颜色*/
@property (nonatomic, strong) UIColor *textColor;

//UITableExcelViewColumnStyleBtn模式下有效
/**选中背景颜色*/
@property (nonatomic, strong,nullable) UIColor *selectedBackgroundColor;
/**背景颜色*/
@property (nonatomic, strong,nullable) UIColor *backgroundColor;

/**是否选中(内部使用)*/
@property (nonatomic, assign) BOOL selected;


@end

__attribute__((objc_subclassing_restricted))
@interface UITableExcelViewMode : NSObject
/**TableExcelView显示模式*/
@property (nonatomic,assign) UITableExcelViewColumnStyle columnStyle;
/**默认头部的高度*/
@property (nonatomic,assign) CGFloat defalutHeight;

//针对每个一个单元格而言
/**单元格的边框宽度，建议0.8*/
@property (nonatomic,assign) CGFloat columnBorderWidth;
/**单元格的边框颜色*/
@property (nonatomic,strong, nullable) UIColor *columnBorderColor;

//针对每一行而言
//针对每一行底部线的颜色
@property (nonatomic,strong, nullable) UIColor *lineColor;
//针对每一行底部线，支持设置个性图片
@property (nonatomic,strong, nullable) UIImage *lineImage;
//针对每一行底部线
@property (nonatomic,assign          ) CGFloat lineHeight;



/**组样式*/
@property (nonatomic,assign) UITableExcelViewSectionStyle sectionStyle;



@end


/**
 *内部类使用
 */
__attribute__((objc_subclassing_restricted))
@interface UIExcelCellConfig : NSObject

@property (nonatomic,  copy) NSString *notifiKey;

@property (nonatomic,assign) UITableExcelViewColumnStyle columnStyle;
/**单元格的边框宽度*/
@property (nonatomic,assign) CGFloat columnBorderWidth;
/**单元格的边框颜色*/
@property (nonatomic,strong,nullable) UIColor *columnBorderColor;

//针对每一行底部线的颜色
@property (nonatomic,strong, nullable) UIColor *lineViewColor;
//针对每一行底部线，支持设置个性图片
@property (nonatomic,strong, nullable) UIImage *lineViewImage;
//针对每一行底部线
@property (nonatomic,assign          ) CGFloat lineViewHeight;

//行高
@property (nonatomic,assign          ) CGFloat defalutHeight;



@end


NS_ASSUME_NONNULL_END
