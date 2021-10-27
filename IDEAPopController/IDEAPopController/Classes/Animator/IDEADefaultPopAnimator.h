//
//  IDEADefaultPopAnimator.h
//  IDEAPopController
//
//  Copyright © 2020 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IDEAPopController/IDEAPopController.h>
#import <IDEAPopController/IDEAPopControllerAnimationProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDEADefaultPopAnimator : NSObject <IDEAPopControllerAnimationProtocol>

@property (nonatomic, assign) IDEAPopType popType;
@property (nonatomic, assign) IDEADismissType dismissType;

@end

NS_ASSUME_NONNULL_END
