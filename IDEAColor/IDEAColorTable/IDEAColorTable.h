//
//  IDEAColorTable.m
//  IDEANightVersion
//
//  Created by Harry on 2021/3/2.
//  Copyright © 2021 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDEAColorTable : NSObject

//@property (class, nonatomic, readonly)       NSString                            * bundle;

@end

@interface IDEAColorTable ()

+ (NSString *)pathForColorTable:(NSString *)aColorTable
                         ofType:(NSString *)aType;

@end
