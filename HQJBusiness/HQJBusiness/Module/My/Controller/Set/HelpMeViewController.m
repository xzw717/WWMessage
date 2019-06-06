//
//  HelpMeViewController.m
//  WuWuMap
//
//  Created by mymac on 16/9/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HelpMeViewController.h"

@interface HelpMeViewController ()<UIWebViewDelegate>

@end

@implementation HelpMeViewController



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    /***********************返回 */
    [ManagerEngine navViewWillAppearColor:self andConmp:^(id  _Nonnull sender) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}

//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [ManagerEngine navViewWillDisappearColor:self];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultBackgroundColor;
    
    self.zw_title =_titleNameStr;
//
    UIWebView *setWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight)];
    setWebView.backgroundColor = DefaultBackgroundColor;
    setWebView.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",_SetWEBStr]];
    
    [setWebView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:setWebView];

    
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
 

    
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
