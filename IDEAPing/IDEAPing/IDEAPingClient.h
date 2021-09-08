//
//  IDEAPingClient.h
//  IDEAPing
//
//  Created by Harry on 2021/7/28.
//
//  Mail: miniwing.hz@gmail.com
//

#import <Foundation/Foundation.h>

#import <SimplePing/SimplePing.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEAPingClient : NSObject

@property (nonatomic, readonly)              NSString                            * hostName;

@end

@interface IDEAPingClient ()

+ (instancetype)pingClientWithHostName:(NSString *)aHostName
                                  ping:(void (^ __nullable)(NSString *aHostName, NSString *aIP, NSTimeInterval aTime, NSError *aError))aPing
                             completed:(void (^ __nullable)(NSString *aHostName, NSString *aIP))aCompleted;

- (void)startPing;
- (void)stopPing;

- (BOOL)isPinging;

@end

NS_ASSUME_NONNULL_END
