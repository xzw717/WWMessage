//
//  ZWTabBarViewController.m
//  WuWuMap
//
//  Created by mymac on 2017/1/13.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZWTabBarViewController.h"
#import "LogInViewController.h"
#import "MyViewController.h"
#import "DetailViewController.h"
#import "CommodityViewController.h"
#import "OrderViewController.h"
#import "ZWNavigationController.h"
#import "ZWTabBarViewController.h"
#import "TabBarBannerViewModel.h"
#import "TabBarBannerModel.h"
#import "HeadlineVC.h"
#import "MessageVC.h"
#import "StoreVC.h"
#import "ToolVC.h"




@interface ZWTabBarViewController ()
/*********** <#注释#>  ************/
@property (nonatomic,weak)  UIView *tabberOldViews ;
@end

@implementation ZWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    StoreVC *storeVC = [[StoreVC alloc]init];//--个人信息
    ZWNavigationController *storeNvc =[[ZWNavigationController alloc]initWithRootViewController:storeVC];
    
    MessageVC *messageVC = [[MessageVC alloc]init];
    ZWNavigationController *messageNav = [[ZWNavigationController alloc]initWithRootViewController:messageVC];

    ToolVC *toolVC = [[ToolVC alloc]init];//--个人信息
    ZWNavigationController *toolNvc =[[ZWNavigationController alloc]initWithRootViewController:toolVC];
    
    HeadlineVC *headlineVC = [[HeadlineVC alloc]init];
    ZWNavigationController *headlineNav = [[ZWNavigationController alloc]initWithRootViewController:headlineVC];
    
    MyViewController *myVc = [[MyViewController alloc]init];
    ZWNavigationController *myNav = [[ZWNavigationController alloc]initWithRootViewController:myVc];
    [[UITabBar appearance]setTintColor:[ManagerEngine getColor:@"18abf5"]];
    UITabBar *tabBar = self.tabBar;
    
    for (UITabBarItem *item in tabBar.items) {
        item.imageInsets = UIEdgeInsetsMake(2, 2, 2,2);
    }
    
    UIImage *storeImage      = [UIImage imageNamed:@"tab_store_normal"];
    UIImage *storeImageHig     = [[UIImage imageNamed:@"tab_store_highlight"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
   UIImage *messageImage      = [UIImage imageNamed:@"tab_message_normal"];
    UIImage *messageImageHig     = [[UIImage imageNamed:@"tab_message_highlight"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *toolImage  = [UIImage imageNamed:@"tab_tool_normal"];
    UIImage *toolImageHig  = [[UIImage imageNamed:@"tab_tool_highlight"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UIImage *headlineImage  = [UIImage imageNamed:@"tab_headline_normal"];
    UIImage *headlineImageHig  = [[UIImage imageNamed:@"tab_headline_highlight"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *myImage  = [UIImage imageNamed:@"tab_my_normal"];
    UIImage *myImageHig  = [[UIImage imageNamed:@"tab_my_highlight"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    storeVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"店铺" image:storeImage selectedImage:storeImageHig];
    messageVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"消息" image:messageImage selectedImage:messageImageHig];
    toolVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"工具" image:toolImage selectedImage:toolImageHig];
    headlineVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"头条" image:headlineImage selectedImage:headlineImageHig];
    myVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:myImage selectedImage:myImageHig];
    
    self.viewControllers = @[storeNvc,messageNav,toolNvc,headlineNav,myNav];
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 420, 49)];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)viewWillLayoutSubviews{
//    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
//    tabFrame.size.height = 59;
//    tabFrame.origin.y = self.view.frame.size.height - 59;
//    self.tabBar.frame = tabFrame;
//}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    if (_isAnimation) {
        [self animationWithIndex:index];

    }
    
    
    
    if([item.title isEqualToString:@"发现"])
    {
        // 也可以判断标题,然后做自己想做的事<img alt="得意" src="http://static.blog.csdn.net/xheditor/xheditor_emot/default/proud.gif" />
    }
    
}
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
//    UIView *tabberViews  = tabbarbuttonArray[index] ;
//    _tabberOldViews.transform = CGAffineTransformMakeScale(1, 1);
//    tabberViews.transform = CGAffineTransformMakeScale(2, 2);
//    _tabberOldViews = tabberViews;
//    HQJLog(@"按钮的高度是：%f--%f",tabberViews.frame.size.height,tabberViews.frame.origin.y);
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
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
