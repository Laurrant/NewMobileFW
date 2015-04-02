//
//  MFAViewWithWebViewController.m
//  NewMobileFW
//
//  Created by ElandApple02 on 15-3-25.
//  Copyright (c) 2015年 eland. All rights reserved.
//

#import "MFAViewWithWebViewController.h"
#import "SWRevealViewController.h"
#import "MenuTableViewController.h"
#import "UserModel.h"
#import "SubMenuTableViewController.h"
#import "MFABasePlugin.h"
#import "MBProgressHUD.h"

@interface MFAViewWithWebViewController ()

@end

@implementation MFAViewWithWebViewController

- (id)initWithConfiguration:(WKWebViewConfiguration *)configuration {
    self = [super init];
    if(self) {
        
        //        if([WKWebView class]) {
        //            if(configuration) {
        //                self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        //            }
        //            else {
        //                self.wkWebView = [[WKWebView alloc] init];
        //            }
        //        }
        //        else {
        self.uiWebView = [[UIWebView alloc] init];
        //        }
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  初始化title
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendJavaScript:) name:@"__MFA__SENDJSTOPAGE__" object:nil];
    if(!self.mainTitle&&self.mainTitle.length==0)
    {
        self.title = NSLocalizedString(@"首页", nil);
    }
    else
    {
        self.title=self.mainTitle;
    }
    //    if(self.wkWebView) {
    //        [self.wkWebView setFrame:self.view.bounds];
    //        [self.wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    //        [self.wkWebView setNavigationDelegate:self];
    //        [self.wkWebView setMultipleTouchEnabled:YES];
    //        [self.wkWebView setAutoresizesSubviews:YES];
    //        [self.wkWebView.scrollView setAlwaysBounceVertical:NO];
    //        self.wkWebView.scrollView.bounces=NO;
    //        [self.view addSubview:self.wkWebView];
    //
    ////        [self.wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:MFWContext];
    //    }
    //    else if(self.uiWebView) {
    
    /**
     *  初始化uiwebview
     */
    [self.uiWebView setFrame:self.view.bounds];
    [self.uiWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.uiWebView setDelegate:self];
    [self.uiWebView setMultipleTouchEnabled:YES];
    [self.uiWebView setAutoresizesSubviews:YES];
    [self.uiWebView setScalesPageToFit:YES];
    [self.uiWebView.scrollView setAlwaysBounceVertical:NO];
    self.uiWebView.scrollView.bounces=NO;
    [self.view addSubview:self.uiWebView];
    //    }
    
    _currentPlugin=[[NSMutableDictionary alloc]init];
    //    NSURLRequest *req=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"htm"];
    [self loadURLString:filePath];
    //[self loadURLString:@"http://www.baidu.com"];
    // Do any additional setup after loading the view from its nib.
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

- (void)loadURL:(NSURL *)URL {
    //    if(self.wkWebView) {
    //        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:URL]];
    //    }
    //    else if(self.uiWebView) {
    [self.uiWebView loadRequest:[NSURLRequest requestWithURL:URL]];
    //    }
}



- (void)loadURLString:(NSString *)URLString {
    NSURL *URL = [NSURL URLWithString:URLString];
    [self loadURL:URL];
}

-(void)sendJavaScript:(NSNotification*) notification
{
    [self.progressHUD hide:YES];
    NSLog(@"stringByEvaluatingJavaScriptFromString success1");
//    if (![NSThread isMainThread] || !_commandQueue.currentlyExecuting) {
//        [self performSelectorOnMainThread:@selector(evalJsHelper2:) withObject:js waitUntilDone:NO];
//    } else {
//        [self evalJsHelper2:js];
//    }
    if([notification.object isKindOfClass:[NSString class]])
    {
        //执行回调函数
        NSLog(@"stringByEvaluatingJavaScriptFromString success2");
        [self.uiWebView stringByEvaluatingJavaScriptFromString:notification.object];
        [self.uiWebView resignFirstResponder];
        //self.currentPlugin=nil;
    }
    else
    {
        //弹出alert
        NSLog(@"stringByEvaluatingJavaScriptFromString fail2");
        [self.uiWebView stringByEvaluatingJavaScriptFromString:@"setTimeout(function(){alert(\"method call error\");},30);"];
        [self.uiWebView resignFirstResponder];
        //self.currentPlugin=nil;
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //    if(webView == self.uiWebView) {
    ////        self.uiWebViewCurrentURL = request.URL;
    ////        self.uiWebViewIsLoading = YES;
    ////        [self updateToolbarState];
    ////
    ////        [self fakeProgressViewStartLoading];
    //
    //        if([self.delegate respondsToSelector:@selector(webBrowser:didStartLoadingURL:)]) {
    //            [self.delegate webBrowser:self didStartLoadingURL:request.URL];
    //        }
    //    }
    
    
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.revealViewController.view animated:YES];
    self.progressHUD.delegate = self;
    
    //常用的设置
    //小矩形的背景色
    self.progressHUD.color = [UIColor lightGrayColor];//这儿表示无背景
    //显示的文字
    self.progressHUD.labelText = @"请稍后";
    //细节文字
    //    self.progressHUD.detailsLabelText = @"Test detail";
    //是否有遮罩
    self.progressHUD.dimBackground = YES;
    //[self.progressHUD hide:YES afterDelay:2];
    
    NSString *urlString = [[request URL] absoluteString];
    urlString=[urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    
    if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"mfa"])
    {
        NSError *jsonError;
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@"/"];
        //class名
        NSString *cmdClass=[NSString stringWithFormat:@"%@%@%@",@"MFA",[arrFucnameAndParameter objectAtIndex:0],@"Plugin"];
        
        NSString *other=[arrFucnameAndParameter objectAtIndex:1];
        NSArray *otherArray=[other componentsSeparatedByString:@"?param="];
        //方法名
        NSString *fullCmd=[otherArray objectAtIndex:0];
        //参数（JSON)
        paraJson=[otherArray objectAtIndex:1];
        //回传方法名
        //callbackFunc = [arrFucnameAndParameter objectAtIndex:3];
        NSData *paraData=[paraJson dataUsingEncoding:NSUTF8StringEncoding];
        //参数（NSMutableDictionary)
        para = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:paraData options:kNilOptions error:&jsonError]];
        //[para setObject:self forKey:@"__MFA__MAINVIEW__"];
        //funcName=[para objectForKey:@"script"];
        //        if([arrFucnameAndParameter count]>2)
        //        {
        //            para=[arrFucnameAndParameter objectAtIndex:2];
        //        }
        //        else
        //        {
        //            para=nil;
        //        }
        
        
        //反射调用插件
        Class cls = NSClassFromString(cmdClass);
        id a;
        if(![self.currentPlugin objectForKey:cmdClass])
        {
            a= [[cls  alloc]  init];
        }else
        {
            a=[self.currentPlugin objectForKey:cmdClass];
        }
        
        if([cls isSubclassOfClass:[MFABasePlugin class]])
        {
            SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:",@"setMainViewDelegate"]);
            if([a respondsToSelector:selector])
            {
                [a performSelector:selector withObject:self afterDelay:0.0];
                
                //防止plugin被过早销毁
                
                [self.currentPlugin setObject:a forKey:cmdClass];
                
                selector = NSSelectorFromString([NSString stringWithFormat:@"%@:",fullCmd]);
                if([a respondsToSelector:selector])
                {
                    [a performSelector:selector withObject:para afterDelay:0.0];
                    [self.progressHUD hide:YES];
                }
                else
                {
                    NSLog(@"cannot execute method %@!",cmdClass);
                    [self.uiWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"setTimeout(function(){alert(\"cannot execute method %@!\");});",fullCmd]];
                    [self.uiWebView resignFirstResponder];
                    [self.progressHUD hide:YES];
                }
            }
            else
            {
                NSLog(@"illegal plugin %@!",cmdClass);
                [self.uiWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"setTimeout(function(){alert(\"illegal plugin %@!\");});",cmdClass]];
                [self.uiWebView resignFirstResponder];
                //self.currentPlugin=nil;
                [self.progressHUD hide:YES];
            }
        }
        else
        {
            NSLog(@"cannot find plugin %@!",cmdClass);
            [self.uiWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"setTimeout(function(){alert(\"cannot find plugin %@!\");});",cmdClass]];
            [self.uiWebView resignFirstResponder];
            //self.currentPlugin=nil;
            [self.progressHUD hide:YES];
        }
    }
    
    return YES;
}



- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    if(webView == self.uiWebView) {
    //        if(!self.uiWebView.isLoading) {
    ////            self.uiWebViewIsLoading = NO;
    ////            [self updateToolbarState];
    ////
    ////            [self fakeProgressBarStopLoading];
    //        }
    //
    //        if([self.delegate respondsToSelector:@selector(webBrowser:didFinishLoadingURL:)]) {
    //            [self.delegate webBrowser:self didFinishLoadingURL:self.uiWebView.request.URL];
    //        }
    //    }
    [self.progressHUD hide:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //    if(webView == self.uiWebView) {
    //        if(!self.uiWebView.isLoading) {
    ////            self.uiWebViewIsLoading = NO;
    ////            [self updateToolbarState];
    ////
    ////            [self fakeProgressBarStopLoading];
    //        }
    //        if([self.delegate respondsToSelector:@selector(webBrowser:didFailToLoadURL:error:)]) {
    //            [self.delegate webBrowser:self didFailToLoadURL:self.uiWebView.request.URL error:error];
    //        }
    //    }
}


@end
