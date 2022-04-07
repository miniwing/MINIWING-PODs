//
//  UILabelX.m
//  IDEAUIKit
//
//  Created by Harry on 2022/3/21.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "UILabelX.h"

@interface UILabelX ()

@end

@implementation UILabelX

- (void)dealloc {
   
   __LOG_FUNCTION;
   
   // Custom dealloc
   
   __SUPER_DEALLOC;
   
   return;
}

- (instancetype)initWithFrame:(CGRect)aFrame {
   
   self  = [super initWithFrame:aFrame];
   
   if(self) {
      
      self.edgeInsets   = UIEdgeInsetsMake(0, 0, 0, 0);
   }
   
   return self;
}

- (instancetype)initWithCoder:(NSCoder *)aCoder {

   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super initWithCoder:aCoder];
   
   if (self) {

      self.edgeInsets   = UIEdgeInsetsMake(0, 0, 0, 0);

   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (void)awakeFromNib {

   int                            nErr                                     = EFAULT;

   __TRY;

   [super awakeFromNib];
   // Initialization code

   self.edgeInsets   = UIEdgeInsetsMake(0, 0, 0, 0);
   
   __CATCH(nErr);

   return;
}

+ (UIEdgeInsets)edgeInsets {
   
    /*- (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(nullable NSDictionary<NSString *, id> *)attributes context:(nullable NSStringDrawingContext *)context NS_AVAILABLE(10_11, 7_0);
     方法计算label的大小时，由于不会调用textRectForBounds方法，并不会计算自己通过edgeInsets插入的内边距，而是实际的大小，因此手动返回进行修正*/
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark 设置第一行和最后一行距离label的距离
- (CGRect)textRectForBounds:(CGRect)aBounds limitedToNumberOfLines:(NSInteger)aNumberOfLines {
   
    //注意传入的UIEdgeInsetsInsetRect(bounds, self.edgeInsets),bounds是真正的绘图区域
    CGRect   stRect     = [super textRectForBounds:UIEdgeInsetsInsetRect(aBounds, self.edgeInsets) limitedToNumberOfLines:aNumberOfLines];
   
    stRect.origin.x     -= self.edgeInsets.left;
    stRect.origin.y     -= self.edgeInsets.top;
    stRect.size.width   += self.edgeInsets.left + self.edgeInsets.right;
    stRect.size.height  += self.edgeInsets.top + self.edgeInsets.bottom;
   
    return stRect;
}

- (void)drawTextInRect:(CGRect)aRect {
   
   [super drawTextInRect:UIEdgeInsetsInsetRect(aRect, self.edgeInsets)];
}

@end
