//
//  IDEATypeFaceLoader.m
//  IDEATypeFace
//
//  Created by Harry on 2021/3/2.
//  Copyright © 2021 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <IDEATypeFace/IDEATypeFace.h>
#import <IDEATypeFace/IDEATypeFaceSystemFont.h>

@interface IDEATypeFaceLoader : NSObject

//@property (class, nonatomic, readonly)       NSString                            * bundle;

@end

@interface IDEATypeFaceLoader ()

+ (void)loadFontFile:(NSString *)fontFileName
              ofType:(NSString *)type
          fromBundle:(NSString *)bundleName
           onceToken:(dispatch_once_t *)onceToken;

@end
