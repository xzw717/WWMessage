//
//  SUCCESSViewController.m
//  HQJFacilitator
//
//  Created by mymac on 2016/10/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ProtocolViewController.h"

@interface ProtocolViewController ()<WKUIDelegate,WKNavigationDelegate>

@end

@implementation ProtocolViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutTheSubViews];
    // Do any additional setup after loading the view.
}

#pragma private method
- (void)layoutTheSubViews{
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];

    [self.view addSubview:self.webView];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
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

- (void)dealloc {
    //        [self.webView removeObserver:self forKeyPath:@"title"];
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
