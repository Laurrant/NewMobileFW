//
//  MFABasePlugin.h
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-25.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MFAViewWithWebViewController;
//typedef NS_ENUM(NSInteger, MFA) {
//    UIViewAnimationTransitionNone,//默认从0开始
//    UIViewAnimationTransitionFlipFromLeft,
//    UIViewAnimationTransitionFlipFromRight,
//    UIViewAnimationTransitionCurlUp,
//    UIViewAnimationTransitionCurlDown,
//};

@interface MFABasePlugin : NSObject

@property(weak,nonatomic) MFAViewWithWebViewController* mainViewDelegate;
@property(copy,nonatomic)NSString *callBack;

@end
