//
//  IDEAFontLoader.m
//  IDEAFONT
//
//  Created by Harry on 2021/3/2.
//  Copyright © 2021 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <IDEAFONT/IDEAFONT.h>
#import <IDEAFONT/IDEASystemFont.h>

@interface IDEAFontLoader : NSObject

//@property (class, nonatomic, readonly)       NSString                            * bundle;

@end

@interface IDEAFontLoader ()

+ (void)loadFontFile:(NSString *)fontFileName
              ofType:(NSString *)type
          fromBundle:(NSString *)bundleName
           onceToken:(dispatch_once_t *)onceToken;

@end
