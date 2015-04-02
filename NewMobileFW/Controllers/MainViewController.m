//
//  MainViewController.m
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-18.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "MenuTableViewController.h"
#import "UserModel.h"
#import "SubMenuTableViewController.h"
#import "MFABasePlugin.h"
#import "MBProgressHUD.h"


@interface MainViewController ()

@end

@implementation MainViewController

static void *MFWContext = &MFWContext;



- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  初始化SWRevealViewController
     */
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                        style:UIBarButtonItemStyleBordered target:self action:@selector(showRightButton:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Public Interface

-(void)animiStop
{
    [self.rightMenuViewController.view removeFromSuperview];
}
/**
 *  关闭SubMenu
 */
- (void)closeSubMenu
{
    [self.view addSubview:self.rightMenuViewController.view];
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.45];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animiStop)];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.rightMenuViewController.view cache:YES];
    [self.rightMenuViewController.view setFrame:CGRectMake(kDeviceWidth/2+kDeviceWidth/2-15, 66, 0, 0)];
    
    [UIView commitAnimations];
    self.isOpeningSubMenu=false;
}

/**
 *  弹出右侧菜单
 *
 *  @param sender rightNavButton
 */
- (IBAction)showRightButton:(id)sender
{
    //[self revealToggleAnimated:YES];
    if(self.isOpeningSubMenu)
    {
        
        [self closeSubMenu];
    }
    else
    {
        CGRect subMenuBounds=CGRectMake(kDeviceWidth/2, 66, kDeviceWidth/2-15, KDeviceHeight/2);
        if(self.rightMenuViewController)
        {
            subMenuBounds.size.height=self.rightMenuViewController.tableView.contentSize.height>KDeviceHeight/2?KDeviceHeight/2:self.rightMenuViewController.tableView.contentSize.height;
            [self.rightMenuViewController.view setFrame:CGRectMake(kDeviceWidth/2+kDeviceWidth/2-15, 66, 0, 0)];
            [self.view addSubview:self.rightMenuViewController.view];
            [UIView beginAnimations:@"Curl"context:nil];//动画开始
            [UIView setAnimationDuration:0.45];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.rightMenuViewController.view cache:YES];
            [self.rightMenuViewController.view setFrame:subMenuBounds];
            [UIView commitAnimations];
            self.isOpeningSubMenu=true;
        }
        else
        {
            SubMenuTableViewController * stvc=[[SubMenuTableViewController alloc]init];
            [stvc.tableView layoutIfNeeded];
            subMenuBounds.size.height=stvc.tableView.contentSize.height>KDeviceHeight/2?KDeviceHeight/2:stvc.tableView.contentSize.height;
            [stvc.view setFrame:CGRectMake(kDeviceWidth/2+kDeviceWidth/2-15, 66, 0, 0)];
            self.rightMenuViewController=stvc;
            [self.view addSubview:stvc.view];
            [UIView beginAnimations:@"Curl"context:nil];//动画开始
            [UIView setAnimationDuration:0.45];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:stvc.view cache:YES];
            [stvc.view setFrame:subMenuBounds];
            [UIView commitAnimations];
            
            
            self.isOpeningSubMenu=true;
        }
    }
}



- (void)webBrowser:(MainViewController *)webBrowser didFinishLoadingURL:(NSURL *)URL
{
    [self ModifiedMenu:@"aa"];
}

//#pragma mark - WKNavigationDelegate
//
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    if(webView == self.wkWebView) {
//        if([self.delegate respondsToSelector:@selector(webBrowser:didStartLoadingURL:)]) {
//            [self.delegate webBrowser:self didStartLoadingURL:self.wkWebView.URL];
//        }
//    }
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    if(webView == self.wkWebView) {
//        if([self.delegate respondsToSelector:@selector(webBrowser:didFinishLoadingURL:)]) {
//            [self.delegate webBrowser:self didFinishLoadingURL:self.wkWebView.URL];
//        }
//    }
//}
//
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
//      withError:(NSError *)error {
//    if(webView == self.wkWebView) {
//        if([self.delegate respondsToSelector:@selector(webBrowser:didFailToLoadURL:error:)]) {
//            [self.delegate webBrowser:self didFailToLoadURL:self.wkWebView.URL error:error];
//        }
//    }
//}
//
//- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
//      withError:(NSError *)error {
//    if(webView == self.wkWebView) {
//        if([self.delegate respondsToSelector:@selector(webBrowser:didFailToLoadURL:error:)]) {
//            [self.delegate webBrowser:self didFailToLoadURL:self.wkWebView.URL error:error];
//        }
//    }
//}

#pragma mark 内部函数

/**
 *  修改菜单
 *
 *  @param menu 菜单
 */
-(void)ModifiedMenu:(NSString *)menu
{
    SWRevealViewController *revealController = [self revealViewController];
    if([[NSString stringWithUTF8String:object_getClassName(revealController.rearViewController.class)] isEqualToString:@"UINavigationController"])
    {
        NSLog(@"%s",object_getClassName(revealController.rearViewController.class));
        UINavigationController *nav=(UINavigationController *)revealController.rearViewController;
        if([[NSString stringWithUTF8String:object_getClassName(nav.topViewController.class)] isEqualToString:@"MenuTableViewController"])
        {
            NSLog(@"%s",object_getClassName(nav.topViewController.class));
            MenuTableViewController *menuVC=(MenuTableViewController *)nav.topViewController;
            UserModel *um=[[UserModel alloc]init];
            [um setUserName:@"bbb"];
            [menuVC setUser:um];
        }
    }
}

@end
