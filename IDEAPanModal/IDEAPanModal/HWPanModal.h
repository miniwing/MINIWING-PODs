//
//  HWPanModal.h
//  Pods
//
//  Created by heath wang on 2019/4/30.
//
#import <Foundation/Foundation.h>

//! Project version number for HWPanModal.
FOUNDATION_EXPORT double HWPanModalVersionNumber;

//! Project version string for JYHitchModule.
FOUNDATION_EXPORT const unsigned char HWPanModalVersionString[];

// protocol
#import <IDEAPanModal/HWPanModalPresentable.h>
#import <IDEAPanModal/HWPanModalPanGestureDelegate.h>
#import <IDEAPanModal/HWPanModalHeight.h>

#import <IDEAPanModal/HWPanModalPresenterProtocol.h>

// category
#import <IDEAPanModal/UIViewController+PanModalDefault.h>
#import <IDEAPanModal/UIViewController+Presentation.h>
#import <IDEAPanModal/UIViewController+PanModalPresenter.h>

// custom animation
#import <IDEAPanModal/HWPresentingVCAnimatedTransitioning.h>

// view
#import <IDEAPanModal/HWPanModalIndicatorProtocol.h>
#import <IDEAPanModal/HWPanIndicatorView.h>
#import <IDEAPanModal/HWDimmedView.h>

// panModal view
#import <IDEAPanModal/HWPanModalContentView.h>
