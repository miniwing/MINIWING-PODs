//
//  IDEAFileUtils.h
//  IDEAKit
//
//  Created by Harry on 2022/10/23.
//
//  Mail: miniwing.hz@gmail.com
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEAFileUtils : NSObject

@end

@interface IDEAFileUtils ()

/**
 文件大小格式化
 
 @param size : unit byte.
 @return 返回值实例：1.22M
 */
+ (NSString *)formatFileSize:(int64_t)aSize;

+ (NSString *)byteCountFormat:(int64_t)aBytes;

@end

NS_ASSUME_NONNULL_END
