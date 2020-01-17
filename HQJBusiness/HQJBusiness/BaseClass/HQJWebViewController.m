//
//  ProgramSourceWebViewController.m
//  WuWuMap
//
//  Created by mymac on 2017/3/30.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HQJWebViewController.h"

@interface HQJWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@end

@implementation HQJWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.titleString = self.webTitleString;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.minimumFontSize = 10;
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    config.userContentController = [[WKUserContentController alloc] init];
    config.processPool = [[WKProcessPool alloc] init];
    WKUserContentController *userCC = config.userContentController;

    [userCC addScriptMessageHandler:self name:@"out"];
    [userCC addScriptMessageHandler:self name:@"exitWeb"];
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
    [self.view addSubview:self.webView];
    if (self.isHiddenNav) {
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(self.view);
               make.right.mas_equalTo(self.view);
               make.top.mas_equalTo(self.view.top).offset(StatusBarHeight <= 20 ? -20 :-StatusBarHeight);;
               make.bottom.mas_equalTo(self.view);
           }];
    } else {
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(self.view);
               make.right.mas_equalTo(self.view);
               make.top.mas_equalTo(self.view.top).offset(NavigationControllerHeight);;
               make.bottom.mas_equalTo(self.view);
           }];
    }
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    if (![self.webUrlStr containsString:@"http"] && ![self.webUrlStr containsString:@"https"] && ![self.webUrlStr containsString:@"HTTP"] && ![self.webUrlStr containsString:@"HTTPS"]) {
        self.webUrlStr = [NSString stringWithFormat:@"https://%@",self.webUrlStr];
    }
    
    NSString *url=[NSURL URLWithString:self.webUrlStr] ? self.webUrlStr : [self.webUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    [super preferredStatusBarStyle];
    return UIStatusBarStyleLightContent;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD showErrorWithStatus:@"加载失败！"];
}

//#pragma mark KVO的监听代理
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context { //加载进度值
//   if ([keyPath isEqualToString:@"title"]) {
//        if (object == self.webView) {
//            self.titleString = self.webView.title;
//
//        } else {
//            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//
//        }
//
//    } else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//
//    }
//
//}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.webView.UIDelegate = nil;
    self.webView.navigationDelegate =  nil;
    [self cleanCacheAndCookie];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}
// 类似 UIWebView的 -webView: shouldStartLoadWithRequest: navigationType:
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler {
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
    if ([strRequest containsString:@"itunes.apple.com"]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:strRequest]];
    }
    
//    if([strRequest isEqualToString:@"about:blank"]) {//主页面加载内容
//        decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
//
//    } else {
//        //截获页面里面的链接点击
//        //do something you want
//        decisionHandler(WKNavigationActionPolicyCancel);//不允许跳转
//
//    }
    
}



-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    if (!navigationAction.targetFrame.isMainFrame) {
        
        [webView loadRequest:navigationAction.request];
        
    }
    
    return nil;
    
}
/**清除缓存和cookie*/
- (void)cleanCacheAndCookie{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 9.0) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    }
 
    
    
//    //清除cookies
//    NSHTTPCookie *cookie;
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (cookie in [storage cookies]){
//        [storage deleteCookie:cookie];
//    }
//    //清除UIWebView的缓存
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//    NSURLCache * cache = [NSURLCache sharedURLCache];
//    [cache removeAllCachedResponses];
//    [cache setDiskCapacity:0];
//    [cache setMemoryCapacity:0];
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"out"]||[message.name isEqualToString:@"exitWeb"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)dealloc {
    WKUserContentController *controller = self.webView.configuration.userContentController;
    [controller removeScriptMessageHandlerForName:@"out"];
    [controller removeScriptMessageHandlerForName:@"exitWeb"];

}
@end
