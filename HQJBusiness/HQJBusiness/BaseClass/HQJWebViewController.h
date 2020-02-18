//
//  ProgramSourceWebViewController.h
//  WuWuMap
//
//  Created by mymac on 2017/3/30.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_ViewController.h"
#import <WebKit/WebKit.h>

@interface HQJWebViewController : ZW_ViewController
/// 连接
@property (nonatomic, copy) NSString * webUrlStr;
/// 网页视图
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) NSString *webTitleString;
@end
