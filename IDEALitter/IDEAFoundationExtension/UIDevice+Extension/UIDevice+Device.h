//
//  UIDevice+Device.h
//  IDEALitter
//
//  Created by Harry on 2021/5/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger
{
   CurrentDeviceTypeNone,              // 未知类型
   CurrentDeviceTypeIPhone,            // 手机
   CurrentDeviceTypeIPad,              // pad
   CurrentDeviceTypeIPod,              // pod
   CurrentDeviceTypeIPhoneSimulator    // 模拟器
} CurrentDeviceType;

@interface UIDevice (Device)

/**
 获取当前的APP的运行的手机系统版本号
 e.g. @"9.3.5"
 */
+ (NSString *)getOSVersion;

/**
 获取当前的APP的运行的手机类型名称
 e.g. @"iPhone", @"iPod touch"
 */
+ (NSString *)getOSModel;

/**
 获取当前的APP的运行的手机系统名称(这个感觉有点鸡肋)
 e.g. @"iOS"
 */
+ (NSString *)getOSName;

/**
 判断当前设备是不是手机(iPhone)
 */
+ (BOOL)isPhone;

/**
 判断当前设备是不是IPad
 */
+ (BOOL)isPad;

/**
 判断当前设备是不是IPod
 */
+ (BOOL)isPod;


+ (BOOL)isiPhoneX;

/**
 获取当前设备类型
 */
+ (CurrentDeviceType)getDeviceType;

/**
 获取当前设备的具体型号
 */
+ (NSString *)getDeviceTypeString;

// 获取CPU类型和核心数
+ (NSString *)getCPUType;

// 获取运行内存
+ (double)getMemoryMB;

@end

NS_ASSUME_NONNULL_END
