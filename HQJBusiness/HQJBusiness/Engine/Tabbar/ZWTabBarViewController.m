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
#import "XDViewController.h"
#import "ShopViewController.h"
#import "ToolsViewController.h"

@interface ZWTabBarViewController ()


@property (nonatomic,weak)  UIView *tabberOldViews ;
@end

@implementation ZWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    MyViewController *myVc = [[MyViewController alloc]init];
//    ZWNavigationController *myNav = [[ZWNavigationController alloc]initWithRootViewController:myVc];
    
    
    ShopViewController *shopVC = [[ShopViewController alloc]init];
    ZWNavigationController *shopNav = [[ZWNavigationController alloc]initWithRootViewController:shopVC];

    ToolsViewController *toolsVc = [[ToolsViewController alloc]init];
    ZWNavigationController *toolsNav = [[ZWNavigationController alloc]initWithRootViewController:toolsVc];
    CommodityViewController *commodityVc = [[CommodityViewController alloc]init];
//    ZWNavigationController *CommodityNav = [[ZWNavigationController alloc]initWithRootViewController:CommodityVc];
    XDViewController *xdVc = [[XDViewController alloc]init];//--个人信息
    ZWNavigationController *xdNvc =[[ZWNavigationController alloc]initWithRootViewController:xdVc];
    MyViewController *myVc = [[MyViewController alloc]init];//--个人信息
      ZWNavigationController *myNvc =[[ZWNavigationController alloc]initWithRootViewController:myVc];

    [[UITabBar appearance]setTintColor:[ManagerEngine getColor:@"18abf5"]];
    UITabBar *tabBar = self.tabBar;
    
    for (UITabBarItem *item in tabBar.items) {
        item.imageInsets = UIEdgeInsetsMake(2, 2, 2,2);
    }
    
    UIImage *mainImage      = [UIImage imageNamed:@"icon_home"];
    UIImage *mainImageS     = [[UIImage imageNamed:@"icon_home_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
   UIImage *NearImage      = [UIImage imageNamed:@"icon_tool"];
    UIImage *NearImageS     = [[UIImage imageNamed:@"icon_tool_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
 
    
    UIImage *xdImage        = [UIImage imageNamed:@"icon_xd"];
    UIImage *xdImageS       = [[UIImage imageNamed:@"icon_xd_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
    
    UIImage *myImage  = [UIImage imageNamed:@"icon_user-1"];
    UIImage *myImageS = [[UIImage imageNamed:@"icon_user_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    myVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"XD" image:xdImage selectedImage:xdImageS];

    shopNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"店铺" image:mainImage selectedImage:mainImageS];
    toolsVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"工具" image:NearImage selectedImage:NearImageS];
    xdVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"XD" image:xdImage selectedImage:xdImageS];
    myVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:myImage selectedImage:myImageS];


    self.viewControllers = @[shopNav,toolsNav,xdNvc,myNvc];
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


//-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{
//    NSInteger index = [self.tabBar.items indexOfObject:item];
//    
//    if (_isAnimation) {
//        [self animationWithIndex:index];
//
//    }
//    
//    
//    
//    if([item.title isEqualToString:@"发现"])
//    {
//        // 也可以判断标题,然后做自己想做的事<img alt="得意" src="http://static.blog.csdn.net/xheditor/xheditor_emot/default/proud.gif" />
//    }
//    
//}
//- (void)animationWithIndex:(NSInteger) index {
//    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            [tabbarbuttonArray addObject:tabBarButton];
//        }
//    }
////    UIView *tabberViews  = tabbarbuttonArray[index] ;
////    _tabberOldViews.transform = CGAffineTransformMakeScale(1, 1);
////    tabberViews.transform = CGAffineTransformMakeScale(2, 2);
////    _tabberOldViews = tabberViews;
////    HQJLog(@"按钮的高度是：%f--%f",tabberViews.frame.size.height,tabberViews.frame.origin.y);
//    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    pulse.duration = 0.08;
//    pulse.repeatCount= 1;
//    pulse.autoreverses= YES;
//    pulse.fromValue= [NSNumber numberWithFloat:0.7];
//    pulse.toValue= [NSNumber numberWithFloat:1.3];
//    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
