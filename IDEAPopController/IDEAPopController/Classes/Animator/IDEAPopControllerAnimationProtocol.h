//
//  IDEAPopControllerAnimationProtocol.h
//  IDEAPopController
//
//  Copyright © 2020 Harry. All rights reserved.
//

#ifndef IDEAPopControllerAnimationProtocol_h
#define IDEAPopControllerAnimationProtocol_h

NS_ASSUME_NONNULL_BEGIN

@class IDEAPopAnimationContext;

@protocol IDEAPopControllerAnimationProtocol <NSObject>

- (NSTimeInterval)popControllerAnimationDuration:(IDEAPopAnimationContext *)context;
- (void)popAnimate:(IDEAPopAnimationContext *)context completion:(void (^)(BOOL finished))completion;
- (void)dismissAnimate:(IDEAPopAnimationContext *)context completion:(void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END

#endif /* IDEAPopControllerAnimationProtocol_h */
