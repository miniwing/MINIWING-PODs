//
//  DKPicker.h
//  DKNightVersion
//
//  Created by Draveness on 15/12/9.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSString DKThemeVersion;

//++++++++++++++++++++++++++++++++++++++++++++++++++++
typedef id (^DKPicker)(DKThemeVersion *aThemeVersion);
//++++++++++++++++++++++++++++++++++++++++++++++++++++

/**
 * Swift 用法
 */
//let onAppRateOnStoreNotification : @convention(block) (_ aThemeVersion:String) -> UIColor = { (aThemeVersion) -> UIColor in
//  
//   return UIColor.clear
//};
//
//self.view.backgroundColorPicker  = { (aThemeVersion) -> UIColor in
//
//   if DKThemeVersionNight == aThemeVersion {
//
//      return IDEAColor.color(withKey: IDEAColor.systemBackground())
//
//   } /* End if () */
//
//   return IDEAColor.color(withKey: IDEAColor.systemGroupedBackground())
//};
