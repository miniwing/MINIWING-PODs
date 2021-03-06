//
//  GitHub: https://github.com/iphone5solo/IDEASearch
//  Created by CoderKo1o.
//  Copyright © 2016 iphone5solo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (IDEASearchExtension)

/**
 Returns the corresponding color according to the hexadecimal string.

 @param hexString   hexadecimal string(eg:@"#ccff88")
 @return new instance of `UIColor` class
 */
+ (instancetype)search_colorWithHexString:(NSString *)hexString;

/**
  Returns the corresponding color according to the hexadecimal string and alpha.

 @param hexString   hexadecimal string(eg:@"#ccff88")
 @param alpha       alpha
 @return new instance of `UIColor` class
 */
+ (instancetype)search_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
