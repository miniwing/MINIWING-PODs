//
//  UIFont+TypeFace.m
//  IDEATypeFace
//
//  Created by Harry on 2022/3/10.
//

#import "IDEATypeFace/NSObject+TypeFace.h"
#import "IDEATypeFace/UIFont+TypeFace.h"

@implementation UIFont (TypeFace)

+ (void)load {
   
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{

      //交换systemFontOfSize: 方法
      [[self class] runtimeReplaceMethodWithSelector:@selector(systemFontOfSize:)
                                     swizzleSelector:@selector(customSystemFontOfSize:)
                                       isClassMethod:YES];
      //交换fontWithName:size:方法
      [[self class] runtimeReplaceMethodWithSelector:@selector(fontWithName:size:)
                                     swizzleSelector:@selector(customFontWithName:size:)
                                       isClassMethod:YES];
   });
   
   return;
}

// 自定义的交换方法
+ (UIFont *)customSystemFontOfSize:(CGFloat)fontSize {
   
   CGFloat size = [UIFont transSizeWithFontSize:fontSize];
   
   ///这里并不会引起递归，方法交换后，此时调用customSystemFontOfSize方法，其实是调用了原来的systemFontOfSize方法
   return [UIFont customSystemFontOfSize:size];
}

// 自定义的交换方法
+ (UIFont *)customFontWithName:(NSString *)fontName size:(CGFloat)fontSize {
   
   CGFloat size = [UIFont transSizeWithFontSize:fontSize];
   
   return [UIFont customFontWithName:fontName size:size];
}

///屏幕宽度大于320的，字体加10。(此处可根据不同的需求设置字体大小)
+ (CGFloat)transSizeWithFontSize:(CGFloat)fontSize {
   
   CGFloat size = fontSize;
//   CGFloat width = [UIFont getWidth];
//   
//   if (width > 320)
//   {
//      size += 10;
//      
//   } /* End if () */
   
   return size;
}

/////获取竖屏状态下的屏幕宽度
//+ (CGFloat)getWidth
//{
//   for (UIScreen *windowsScenes in UIApplication.sharedApplication.connectedScenes)
//   {
//      UIWindowScene * scenes = (UIWindowScene *)windowsScenes;
//      UIWindow *window = scenes.windows.firstObject;
//
//      if (scenes.interfaceOrientation == UIInterfaceOrientationPortrait)
//      {
//         return window.frame.size.width;
//      }
//
//      return window.frame.size.height;
//   }
//
//   return 0;
//}

@end
