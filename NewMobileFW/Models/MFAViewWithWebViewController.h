//
//  MFAViewWithWebViewController.h
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-25.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"
@class MFABasePlugin;
//@class MainViewController;
@class SubMenuTableViewController;

@interface MFAViewWithWebViewController : UIViewController<WKNavigationDelegate, UIWebViewDelegate,MBProgressHUDDelegate>{
    @protected

        UIImage *viewImage;
        UIImagePickerController *picker;
        NSString *callbackFunc;
        NSMutableDictionary *para;
        NSString *paraJson;
        NSString *funcName;
        NSError *error2;


}

@property(strong,nonatomic)NSMutableDictionary* currentPlugin;
#pragma mark - Public Properties


/**
 *  首页上的标题
 */
@property(copy,nonatomic) NSString * mainTitle;

/**
 *  右侧菜单Controller
 */
@property(strong,nonatomic)SubMenuTableViewController * rightMenuViewController;

/**
 *  MBProgressHUD
 */
@property(strong,nonatomic)MBProgressHUD * progressHUD;


/**
 *  右侧菜单状态
 */
@property(assign,nonatomic)BOOL isOpeningSubMenu;

/**
 *  主页面webview
 */
@property (strong, nonatomic) IBOutlet UIView *webView;
//@property(strong,nonatomic)WKWebView *wkWebView;

/**
 *  主页面uiwebview
 */
@property(strong,nonatomic)UIWebView *uiWebView;
- (id)initWithConfiguration:(WKWebViewConfiguration *)configuration ;

@end
