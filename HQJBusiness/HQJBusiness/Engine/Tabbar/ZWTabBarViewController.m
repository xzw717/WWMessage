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

@interface ZWTabBarViewController ()
/*********** <#注释#>  ************/
@property (nonatomic,weak)  UIView *tabberOldViews ;
@end

@implementation ZWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyViewController *myVc = [[MyViewController alloc]init];
    ZWNavigationController *myNav = [[ZWNavigationController alloc]initWithRootViewController:myVc];
    DetailViewController *detailVc = [[DetailViewController alloc]init];
    ZWNavigationController *detailNav = [[ZWNavigationController alloc]initWithRootViewController:detailVc];
    CommodityViewController *commodityVc = [[CommodityViewController alloc]init];
//    ZWNavigationController *CommodityNav = [[ZWNavigationController alloc]initWithRootViewController:CommodityVc];
    OrderViewController *orderVc = [[OrderViewController alloc]init];//--个人信息
    ZWNavigationController *orderNvc =[[ZWNavigationController alloc]initWithRootViewController:orderVc];
    XDViewController *xdVc = [[XDViewController alloc]init];//--个人信息
      ZWNavigationController *xdNvc =[[ZWNavigationController alloc]initWithRootViewController:xdVc];

    [[UITabBar appearance]setTintColor:[ManagerEngine getColor:@"18abf5"]];
    UITabBar *tabBar = self.tabBar;
    
    for (UITabBarItem *item in tabBar.items) {
        item.imageInsets = UIEdgeInsetsMake(2, 2, 2,2);
    }
    
    UIImage *mainImage      = [UIImage imageNamed:@"icon_mine_normal"];
    UIImage *mainImageS     = [[UIImage imageNamed:@"icon_mine_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
   UIImage *NearImage      = [UIImage imageNamed:@"icon_details_normal"];
    UIImage *NearImageS     = [[UIImage imageNamed:@"icon_details_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *BusinessImage  = [UIImage imageNamed:@"icon_order_normal"];
    UIImage *BusinessImageS = [[UIImage imageNamed:@"icon_order_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *xdImage        = [UIImage imageNamed:@"icon_XD_noselect"];
    UIImage *xdImageS       = [[UIImage imageNamed:@"icon_XD_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
    xdVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"XD" image:xdImage selectedImage:xdImageS];

    myVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:mainImage selectedImage:mainImageS];
    detailVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"明细" image:NearImage selectedImage:NearImageS];
    commodityVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"商品" image:NearImage selectedImage:NearImageS];
    orderVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"订单" image:BusinessImage selectedImage:BusinessImageS];


    self.viewControllers = @[myNav,detailNav,orderNvc,xdNvc];
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
