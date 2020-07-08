//
//  SUCCESSViewController.m
//  HQJFacilitator
//
//  Created by mymac on 2016/10/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ProtocolViewController.h"

@interface ProtocolViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@end

@implementation ProtocolViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutTheSubViews];
    self.title = self.titleStr;
    
}

#pragma private method
- (void)layoutTheSubViews{
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.view addSubview:self.webView];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
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
    if (![self.webUrlStr containsString:@"http"] && ![self.webUrlStr containsString:@"https"] && ![self.webUrlStr containsString:@"HTTP"] && ![self.webUrlStr containsString:@"HTTPS"]) {
        self.webUrlStr = [NSString stringWithFormat:@"https://%@",self.webUrlStr];
    }
    //    NSString *url=[NSURL URLWithString:self.webUrlStr] ? self.webUrlStr : [[RequstManager getAFManager] strUTF8Encoding:self.webUrlStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrlStr]]];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"加载失败！");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.webView.UIDelegate = nil;
    self.webView.navigationDelegate =  nil;
    [self cleanCacheAndCookie];
}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
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

@end
