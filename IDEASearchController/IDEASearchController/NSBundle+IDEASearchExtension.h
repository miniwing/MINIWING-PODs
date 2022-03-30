//
//  GitHub: https://github.com/iphone5solo/PYSearch
//  Created by CoderKo1o.
//  Copyright © 2016 iphone5solo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSBundle (IDEASearchExtension)

/**
 Get the localized string

 @param key     key for localized string
 @return a localized string
 */
+ (NSString *)search_localizedStringForKey:(NSString *)key;

/**
 Get the path of `IDEASearch.bundle`.

 @return path of the `IDEASearch.bundle`
 */
+ (NSBundle *)searchBundle;

/**
 Get the image in the `IDEASearch.bundle` path

 @param name name of image
 @return a image
 */
+ (UIImage *)search_imageNamed:(NSString *)name;

@end
