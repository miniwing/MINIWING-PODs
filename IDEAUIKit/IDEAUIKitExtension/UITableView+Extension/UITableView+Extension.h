//
//  UITableView+Extension.h
//  IDEA
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail:iidioter@gmail.com
//  TEL :+(852)53054612
//

#import <UIKit/UIKit.h>

#define UIATableViewSelectedDefaultDuraton   (0.15f)

@interface UITableView (Extension)

- (void)clearHeaderView;
- (void)clearFooterView;
- (void)unselect:(BOOL)aAnimated;

/**********************************************************************************************/
/**
 Select all rows in tableView.
 
 @param animated YES to animate the transition, NO to make the transition immediate.
 */
- (void)selectedAllRowsAnimated:(BOOL)animated;
/**********************************************************************************************/

@end
