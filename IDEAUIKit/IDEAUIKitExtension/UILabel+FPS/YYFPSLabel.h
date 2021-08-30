//
//  YYFPSLabel.h
//  IDEAUIKit
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail:iidioter@gmail.com
//  TEL :+(852)53054612
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#if FPS_LABEL

/**
 Show Screen FPS...
 
 The maximum fps in OSX/iOS Simulator is 60.00.
 The maximum fps on iPhone is 59.97.
 The maxmium fps on iPad is 60.0.
 */
@interface YYFPSLabel : UILabel

@end

#endif /* FPS_LABEL */

NS_ASSUME_NONNULL_END

