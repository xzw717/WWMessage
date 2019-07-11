//
//  OrderViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/9.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderViewController.h"
#import "AllOrdeVC.h"
#import "GoodsOrderVC.h"
#import "TransferOrderVC.h"
#import "AlreadyVerificationVC.h"
@interface OrderViewController () <SGSegmentedControlStaticDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) SGSegmentedControlStatic *topSView;
@property (nonatomic, strong) SGSegmentedControlBottomView *bottomSView;
@end

@implementation OrderViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavType:HQJNavigationBarWhite];
    [self hideShadowLine];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultBackgroundColor;
//    self.zwBackButton.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.zwTitLabel.textColor = [UIColor whiteColor];
    self.title = @"订单管理";
    HQJLog(@"id\n%@",MmberidStr);
    AllOrdeVC *allorderVC = [[AllOrdeVC alloc]init];
    [self addChildViewController:allorderVC];

    GoodsOrderVC *goodsOrderVC = [[GoodsOrderVC alloc]init];
    [self addChildViewController:goodsOrderVC];

    TransferOrderVC *TransferVC = [[TransferOrderVC alloc]init];
    [self addChildViewController:TransferVC];

    AlreadyVerificationVC *alreadyVC = [[AlreadyVerificationVC alloc]init];
     [self addChildViewController:alreadyVC];
    
    NSArray *childVC = @[allorderVC,goodsOrderVC,TransferVC,alreadyVC];
    
    NSArray *title_arr = @[@"全部订单",@"待付款",@"待使用",@"交易完成"];
    

    
    self.bottomSView = [[SGSegmentedControlBottomView alloc] initWithFrame:CGRectMake(0, 0 , WIDTH, HEIGHT)];
    _bottomSView.childViewController = childVC;
    _bottomSView.backgroundColor = DefaultBackgroundColor;
    _bottomSView.delegate = self;
    [self.view addSubview:_bottomSView];
    
    self.topSView = [SGSegmentedControlStatic segmentedControlWithFrame:CGRectMake(0, 0 , WIDTH, 44) delegate:self childVcTitle:title_arr indicatorIsFull:NO];
    
    // 必须实现的方法
    [self.topSView SG_setUpSegmentedControlType:nil];

    [self.topSView SG_setUpSegmentedControlStyle:^(UIColor *__autoreleasing *segmentedControlColor, UIColor *__autoreleasing *titleColor, UIColor *__autoreleasing *selectedTitleColor, UIColor *__autoreleasing *indicatorColor, BOOL *isShowIndicor) {
        *indicatorColor = DefaultAPPColor;
        *isShowIndicor = YES;
    }];
    self.topSView.selectedIndex = 0;
 


    _topSView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topSView];
    
    
}
- (void)SGSegmentedControlStatic:(SGSegmentedControlStatic *)segmentedControlStatic didSelectTitleAtIndex:(NSInteger)index  {
    // 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.bottomSView.contentOffset = CGPointMake(offsetX, 0);
    [self.bottomSView showChildVCViewWithIndex:index outsideVC:self];
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(scrollView == _bottomSView) {
        
        // 计算滚动到哪一页
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        // 1.添加子控制器view
        [self.bottomSView showChildVCViewWithIndex:index outsideVC:self];
        
        // 2.把对应的标题选中
        [self.topSView changeThePositionOfTheSelectedBtnWithScrollView:scrollView];
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
