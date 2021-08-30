//
//  IDEANetUtils.h
//  IDEANetUtils
//
//  Created by Harry on 2021/8/2.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//

#import <Foundation/Foundation.h>
#import <IDEANetUtils/IDEANetInterface.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEANetUtils : NSObject

@end

@interface IDEANetUtils ()

+ (NSArray<IDEANetInterface *> *)allInterfaces;

@end

NS_ASSUME_NONNULL_END
