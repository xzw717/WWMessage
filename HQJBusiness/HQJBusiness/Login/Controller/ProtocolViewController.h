//
//  SUCCESSViewController.h
//  HQJFacilitator
//
//  Created by mymac on 2016/10/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface ProtocolViewController : UIViewController

/// 标题
@property (nonatomic, copy) NSString * titleStr;
/// 连接ChildBaseViewController
@property (nonatomic, copy) NSString * webUrlStr;
/// 网页视图
@property (nonatomic, strong) WKWebView *webView;


@end
