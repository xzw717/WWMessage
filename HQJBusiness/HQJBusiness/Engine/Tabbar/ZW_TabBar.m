//
//  ZW_TabBar.m
//  WuWuMap
//
//  Created by mymac on 2017/11/16.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.

//
#import "TabbarManager.h"
#import "ZW_TabBar.h"
#import "ZWNavigationController.h"
#import "HeadlineVC.h"
#import "MessageVC.h"
#import "StoreVC.h"
#import "ToolVC.h"
#import "MyViewController.h"
#import "TabBarSingle.h"
#import "NewMessageImageView.h"

#import "MineViewController.h"

NSString *const NotificationMessage           = @"NotificationMessageName";

@interface ZW_TabBar ()<UITabBarDelegate>

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, assign) NSInteger tabbatTag;
@property (nonatomic, strong) NewMessageImageView   *storeButton;
@property (nonatomic, strong) NewMessageImageView   *messageButton;
@property (nonatomic, strong) NewMessageImageView   *toolButton;
@property (nonatomic, strong) NewMessageImageView   *headlineButton;
@property (nonatomic, strong) NewMessageImageView   *myButton;
@end
@implementation ZW_TabBar

+ (ZW_TabBar *)sharedInstance {
    static ZW_TabBar *tab = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tab = [[self alloc]init];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationMessage:) name:NotificationMessage object:nil];
    });
    return tab;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbatTag = 10086;
    NSMutableDictionary *delaydic = [NSMutableDictionary dictionary];
    [delaydic setObject:@[@"tab_store_normal",
                          @"tab_message_normal",
                          @"tab_headline_normal",
                          @"tab_tool_normal",
                          @"tab_my_normal"] forKey:ZWTabBarItemiconArrayKey];
    [delaydic setObject:@[@"tab_store_highlight",
                          @"tab_message_highlight",
                          @"tab_headline_highlight",
                          @"tab_tool_highlight",
                          @"tab_my_highlight"] forKey:ZWTabBarItemSelectIconArrayIconKey];
    [delaydic setObject:@"tabbar_bg_icon" forKey:ZWTabBarItembarBgUrlKey];
    [delaydic setObject:@"btn_home_cart" forKey:ZWTabBarItemshopCartUrlKey];
    [delaydic setObject:@"tabbar_voice_icon" forKey:ZWTabBarItemvoiceButtonUrlKey];
    [TabBarSingle shareManager].dataDict = delaydic;
    self.tabBar.translucent = NO;
    [self setbar];
//    [self requstTabbarIcon];
}

//#pragma mark ---  请求图标
//- (void)requstTabbarIcon {
//    NSString *mobileType ;
//    if (iPhone6) {
//        mobileType = @"2";
//    } else if (iPhone6Plus || iPhoneX) {
//        mobileType = @"3";
//    } else {
//        mobileType = @"2";
//    }
//    NSString *strUrl = [NSString stringWithFormat:@"%@system/icon.action?type=1&mobile=%@",WWMDomainName,mobileType];
//    [[RequstManager getAFManager] HQJWuWuMapRequestDetailsUrl:strUrl complete:^(id dic) {
//        NSDictionary * dict =  dic[@"resultMsg"];
//        if (dict.allKeys.count > 0) {
//        NSMutableArray *copyiconArray = [NSMutableArray array];
//        NSMutableArray *copySelecticonArray = [NSMutableArray array];
//        NSMutableDictionary *delaydic = [NSMutableDictionary dictionary];
//        NSArray *urliconStringAry = dict[@"icons"];
//        NSArray *urlSelecticonStringAry = dict[@"selectedIcons"];
//        for (NSInteger i = 0; i< urliconStringAry.count; i ++) {
//            if (urliconStringAry[i] != nil) {
//                [copyiconArray addObject:[[TabBarSingle shareManager] zw_setKeyValues:urliconStringAry[i]]];
//
//            }
//        }
//        for (NSInteger i = 0; i< urlSelecticonStringAry.count; i ++) {
//            if ( urlSelecticonStringAry[i] != nil) {
//                [copySelecticonArray addObject: [[TabBarSingle shareManager] zw_setKeyValues:urlSelecticonStringAry[i]]];
//
//            }
//
//        }
//        [delaydic setObject:copyiconArray forKey:ZWTabBarItemiconArrayKey];
//        [delaydic setObject:copySelecticonArray forKey:ZWTabBarItemSelectIconArrayIconKey];
//        [delaydic setObject:dict[@"barBg"] forKey:ZWTabBarItembarBgUrlKey];
//        [delaydic setObject:dict[@"shopCart"] forKey:ZWTabBarItemshopCartUrlKey];
//        [delaydic setObject:dict[@"search"] forKey:ZWTabBarItemvoiceButtonUrlKey];
//        [TabBarSingle shareManager].dataDict = delaydic;
//        }
//    } andError:^(NSError *error) {
//
//    } showHUD:RequstAlertNotShowDefault alertText:nil];
//}






- (void)setbar {
    //设置tabBar的背景颜色
    _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, ToolBarHeight)];
    _bgView.image = [ManagerEngine conversionsImage:[TabBarSingle shareManager].dataDict[ZWTabBarItembarBgUrlKey]];
 
    [[UITabBar appearance]setTintColor:DefaultAPPColor];
    UITabBar *tabBar = self.tabBar;
    
//    for (UITabBarItem *item in tabBar.items) {
//        item.imageInsets = UIEdgeInsetsMake(2, 2, 2,2);
//    }
    [tabBar insertSubview:_bgView atIndex:0];
    tabBar.opaque = YES;
    [self bgimage];
    //首页
 
    StoreVC *storeVC = [[StoreVC alloc]init];//--个人信息
    ZWNavigationController *storeNvc =[[ZWNavigationController alloc]initWithRootViewController:storeVC];
    [self setTabBarItem:storeVC.tabBarItem Title:@"店铺" selectedImage:@"tabbar_ placeholder_icon" tag:10086];

    
    MessageVC *messageVC = [[MessageVC alloc]init];
    ZWNavigationController *messageNav = [[ZWNavigationController alloc]initWithRootViewController:messageVC];
    [self setTabBarItem:messageVC.tabBarItem Title:@"消息" selectedImage:@"tabbar_ placeholder_icon" tag:10087];
    
    HeadlineVC *headlineVC = [[HeadlineVC alloc]init];
    ZWNavigationController *headlineNav = [[ZWNavigationController alloc]initWithRootViewController:headlineVC];
    [self setTabBarItem:headlineVC.tabBarItem Title:@"头条" selectedImage:@"tabbar_ placeholder_icon" tag:10088];
    
    ToolVC *toolVC = [[ToolVC alloc]init];//--个人信息
    ZWNavigationController *toolNvc =[[ZWNavigationController alloc]initWithRootViewController:toolVC];
    [self setTabBarItem:toolVC.tabBarItem Title:@"工具" selectedImage:@"tabbar_ placeholder_icon" tag:10089];

    MineViewController *myVc = [[MineViewController alloc]init];
    ZWNavigationController *myNav = [[ZWNavigationController alloc]initWithRootViewController:myVc];
    [self setTabBarItem:myVc.tabBarItem Title:@"我的" selectedImage:@"tabbar_ placeholder_icon" tag:10080];
    
    

    self.viewControllers = @[storeNvc,messageNav,headlineNav,toolNvc,myNav];
 
    
    // 语音按钮
//    _voiceBtn = [zw_TabBarButton  buttonWithType:UIButtonTypeCustom];
//    _voiceBtn.frame = CGRectMake((S_SCREEN_WIDTH - 41)/2, -41/3, 45, 60);
//    _voiceBtn.btnImageView.image = [ToolManager conversionsImage:[TabBarSingle shareManager].dataDict[ZWTabBarItemvoiceButtonUrlKey]];
//    [_voiceBtn addTarget:self action:@selector(clickVoiceBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.tabBar addSubview:_voiceBtn];
//    [self.tabBar bringSubviewToFront:_voiceBtn];
//    [RACObserve([TabBarSingle shareManager], dataDict) subscribeNext:^(NSMutableDictionary  * dict) {
//        if (![dict[ZWTabBarItembarBgUrlKey] isEqualToString:@"tabbar_bg_icon"]) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//                    //主线程刷新UI
//                    [self changeTabBar];
//
//                });
//        }
//    }];
    
    
    //去掉tabBar顶部线条
//    CGRect rect = CGRectMake(0, 0, WIDTH, 0.01);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.tabBar setBackgroundImage:img];
//    [self.tabBar setShadowImage:img];
}
- (void)notificationMessage:(NSNotificationCenter *)notifi {

    
}

#pragma mark --- 默认图 背景imageView
- (void)bgimage {
    /// 每个itme宽度
    CGFloat itmeWith = (WIDTH - 20) / 5;
    CGFloat imageHeight = 46/2.f;
    CGFloat imageWidth =  42/2.f;

    /// 每个btn 距离item 左边的距离
    CGFloat space = (itmeWith - imageWidth)/2 + 2;
    for (NSInteger i = 0; i < 5; i ++) {
        CGFloat xnum = i % 5;
        CGFloat x = space + (space * 2  + imageWidth) * xnum;
        NewMessageImageView *btn = [[NewMessageImageView alloc]initWithHintStyle:redViewStyleDefault];
        btn.contentMode = UIViewContentModeScaleAspectFit;
        btn.frame = CGRectMake(x, 8, imageWidth, imageHeight);
        btn.image = [ManagerEngine conversionsImage:[TabBarSingle shareManager].dataDict[ZWTabBarItemSelectIconArrayIconKey][i]];
        [self.tabBar addSubview:btn];
        [self.tabBar bringSubviewToFront:btn];
        switch (i) {
            case 0:
                _storeButton = btn;
                _storeButton.image = [ManagerEngine conversionsImage:[TabBarSingle shareManager].dataDict[ZWTabBarItemSelectIconArrayIconKey][i]];

                break;
            case 1:
                _messageButton = btn;
                _messageButton.image = [ManagerEngine conversionsImage:[TabBarSingle shareManager].dataDict[ZWTabBarItemiconArrayKey][i]];
                [_messageButton setNumbaer:0];
                break;
            case 2:
                _headlineButton = btn;
                _headlineButton.image = [ManagerEngine conversionsImage:[TabBarSingle shareManager].dataDict[ZWTabBarItemiconArrayKey][i]];

                break;
            case 3:
                _toolButton = btn;
                _toolButton.image = [ManagerEngine conversionsImage:[TabBarSingle shareManager].dataDict[ZWTabBarItemiconArrayKey][i]];

                break;
            default:
                _myButton = btn;
                _myButton.image = [ManagerEngine conversionsImage:[TabBarSingle shareManager].dataDict[ZWTabBarItemiconArrayKey][i]];

                break;
        }
    }
    

}


#pragma mark --- UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    self.tabbatTag = item.tag;
    [self tagbar];
}


#pragma mark ---代替显示图片
- (void)tagbar {
        NSMutableArray *iconArray    = [TabBarSingle shareManager].dataDict[ZWTabBarItemiconArrayKey];
        NSMutableArray *selectArray  = [TabBarSingle shareManager].dataDict[ZWTabBarItemSelectIconArrayIconKey];
    if (selectArray.count != 0 && iconArray.count != 0) {
        if (self.tabbatTag == 10086) {
            _storeButton.image = [ManagerEngine conversionsImage:selectArray[0]];
            _messageButton.image = [ManagerEngine conversionsImage:iconArray[1]];
            _headlineButton.image = [ManagerEngine conversionsImage:iconArray[2]];
            _toolButton.image = [ManagerEngine conversionsImage:iconArray[3]];
            _myButton.image = [ManagerEngine conversionsImage:iconArray[4]];
            
        } else if (self.tabbatTag == 10087) {
            _storeButton.image = [ManagerEngine conversionsImage:iconArray[0]];
            _messageButton.image = [ManagerEngine conversionsImage:selectArray[1]];
            _headlineButton.image = [ManagerEngine conversionsImage:iconArray[2]];
            _toolButton.image = [ManagerEngine conversionsImage:iconArray[3]];
            _myButton.image = [ManagerEngine conversionsImage:iconArray[4]];
        } else if (self.tabbatTag == 10088) {
            _storeButton.image = [ManagerEngine conversionsImage:iconArray[0]];
            _messageButton.image = [ManagerEngine conversionsImage:iconArray[1]];
            _headlineButton.image = [ManagerEngine conversionsImage:selectArray[2]];
            _toolButton.image = [ManagerEngine conversionsImage:iconArray[3]];
            _myButton.image = [ManagerEngine conversionsImage:iconArray[4]];
        } else if (self.tabbatTag == 10089) {
            _storeButton.image = [ManagerEngine conversionsImage:iconArray[0]];
            _messageButton.image = [ManagerEngine conversionsImage:iconArray[1]];
            _headlineButton.image = [ManagerEngine conversionsImage:iconArray[2]];
            _toolButton.image = [ManagerEngine conversionsImage:selectArray[3]];
            _myButton.image = [ManagerEngine conversionsImage:iconArray[4]];
        }  else if (self.tabbatTag == 10080) {
            _storeButton.image = [ManagerEngine conversionsImage:iconArray[0]];
            _messageButton.image = [ManagerEngine conversionsImage:iconArray[1]];
            _headlineButton.image = [ManagerEngine conversionsImage:iconArray[2]];
            _toolButton.image = [ManagerEngine conversionsImage:iconArray[3]];
            _myButton.image = [ManagerEngine conversionsImage:selectArray[4]];
        }
        
    }
    
    
    
    
   
    
}



//- (void)clickVoiceBtn:(UIButton *)btn {
//        VoiceSearchViewController *vc = [[VoiceSearchViewController alloc]init];
//        [[ToolManager currentViewControll] presentViewController:vc animated:YES completion:nil];
//
//}


#pragma mark --- 改皮肤
- (void)changeTabBar  {
    NSMutableArray *iconArray    = [TabBarSingle shareManager].dataDict[ZWTabBarItemiconArrayKey];
    NSMutableArray *selectArray  = [TabBarSingle shareManager].dataDict[ZWTabBarItemSelectIconArrayIconKey];
    if (selectArray.count != 0 && iconArray.count != 0) {
        _bgView.image = [[TabBarSingle shareManager] zw_setKeyValues:[TabBarSingle shareManager].dataDict[ZWTabBarItembarBgUrlKey]];
//        _voiceBtn.btnImageView.image = [[TabBarSingle shareManager] zw_setKeyValues:[TabBarSingle shareManager].dataDict[ZWTabBarItemvoiceButtonUrlKey]];
        [self tagbar];
    }
  
}

- (UIImage *)tabbarImage:(NSString *)str {
    NSString *urlString = [NSString stringWithFormat:@"%@",str];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}


- (void)setTabBarItem:(UITabBarItem *)tabbarItem
                Title:(NSString *)title
        selectedImage:(id)selectedImage
      tag:(NSInteger)tags{
    //设置图片
    tabbarItem = [tabbarItem initWithTitle:title image:[ManagerEngine conversionsImage:selectedImage] tag:tags];
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[ManagerEngine getColor:@"939191"],NSFontAttributeName:[UIFont systemFontOfSize:11.f]} forState:UIControlStateNormal];
//    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:DefaultAPPColor,NSFontAttributeName:[UIFont systemFontOfSize:11.f]} forState:UIControlStateSelected];
}

- (UINavigationController *)className:(NSString *)className
                              vcTitle:(NSString *)vcTitle
                             tabTitle:(NSString *)tabTitle
                             tabImage:(NSString *)image
                     tabSelectedImage:(NSString *)selectedImage
{
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    vc.title = vcTitle;
    vc.tabBarItem.title = tabTitle;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    UINavigationController *navgation = [[UINavigationController alloc] initWithRootViewController:vc];
    return navgation;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
