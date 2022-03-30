//
//  GitHub: https://github.com/iphone5solo/PYSearch
//  Created by CoderKo1o.
//  Copyright © 2016 iphone5solo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+IDEASearchExtension.h"
#import "UIColor+IDEASearchExtension.h"
#import "NSBundle+IDEASearchExtension.h"

#define IDEASEARCH_MARGIN                          10
#define IDEASEARCH_BACKGROUND_COLOR                IDEASEARCH_COLOR(255, 255, 255)

#define IDEASEARCH_COLOR(r,g,b)                    [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define IDEASEARCH_RANDOM_COLOR                    IDEASEARCH_COLOR(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

#define IDEASEARCH_DEPRECATED(instead)             NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

#define IDEASEARCH_REALY_SCREEN_WIDTH              [UIScreen mainScreen].bounds.size.width
#define IDEASEARCH_REALY_SCREEN_HEIGHT             [UIScreen mainScreen].bounds.size.height
#define IDEA_SCREEN_WIDTH                          (IDEASEARCH_REALY_SCREEN_WIDTH < IDEASEARCH_REALY_SCREEN_HEIGHT ? IDEASEARCH_REALY_SCREEN_WIDTH : IDEASEARCH_REALY_SCREEN_HEIGHT)
#define IDEA_SCREEN_HEIGHT                         (IDEASEARCH_REALY_SCREEN_WIDTH > IDEASEARCH_REALY_SCREEN_HEIGHT ? IDEASEARCH_REALY_SCREEN_WIDTH : IDEASEARCH_REALY_SCREEN_HEIGHT)
#define IDEASEARCH_SCREEN_SIZE                     CGSizeMake(IDEA_SCREEN_WIDTH, IDEA_SCREEN_HEIGHT)

#define IDEASEARCH_SEARCH_HISTORY_CACHE_PATH       [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"IDEASearchhistories.plist"] // the path of search record cached

UIKIT_EXTERN NSString *const IDEASearchSearchPlaceholderText;
UIKIT_EXTERN NSString *const IDEASearchHotSearchText;
UIKIT_EXTERN NSString *const IDEASearchSearchHistoryText;
UIKIT_EXTERN NSString *const IDEASearchEmptySearchHistoryText;

// HARRY FIXED
UIKIT_EXTERN NSString *const IDEASearchHotSearchRefresh;
// HARRY FIXED

UIKIT_EXTERN NSString *const IDEASearchEmptyButtonText;
UIKIT_EXTERN NSString *const IDEASearchEmptySearchHistoryLogText;
UIKIT_EXTERN NSString *const IDEASearchCancelButtonText;
UIKIT_EXTERN NSString *const IDEASearchBackButtonText;
