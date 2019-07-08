//
//  DetailViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/9.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "DetailViewController.h"
#import "BonusDealVC.h"
#import "CashDealVC.h"
#import "BonusChangeVC.h"
#import "CashChangeVC.h"
#import "BonusBuyZHVC.h"
#import "CashBuyZHVC.h"
#import "ManualGiftRYViewController.h"



@interface DetailViewController ()<SGSegmentedControlDefaultDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) SGSegmentedControlDefault *topSView;
@property (nonatomic, strong) SGSegmentedControlBottomView *bottomSView;
@end

@implementation DetailViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavType:HQJNavigationBarWhite];

//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor = DefaultBackgroundColor;
    self.title = @"明细";
    HQJLog(@"id\n%@",MmberidStr);
    BonusDealVC *BDVC = [[BonusDealVC alloc]init];
    [self addChildViewController:BDVC];
    
    CashDealVC *CDVC = [[CashDealVC alloc]init];
    [self addChildViewController:CDVC];
    
    BonusChangeVC *BCVC = [[BonusChangeVC alloc]init];
    [self addChildViewController:BCVC];
    
    CashChangeVC *CCVC = [[CashChangeVC alloc]init];
    [self addChildViewController:CCVC];
    
    BonusBuyZHVC *BBVC = [[BonusBuyZHVC alloc]init];
    [self addChildViewController:BBVC];
    
    CashBuyZHVC *CBVC = [[CashBuyZHVC alloc]init];
    [self addChildViewController:CBVC];
    
    ManualGiftRYViewController *MGVC = [[ManualGiftRYViewController alloc]init];
    [self addChildViewController:MGVC];
    NSArray *childVC = @[BDVC,CDVC,BCVC,CCVC,BBVC,CBVC,MGVC];
    
    NSArray *title_arr = @[@"积分交易",@"现金交易",@"积分兑现",@"现金提现",[NSString stringWithFormat:@"积分购买%@值",HQJValue],[NSString stringWithFormat:@"现金购买%@值",HQJValue],[NSString stringWithFormat:@"手动赠送%@值",HQJValue]];

    self.bottomSView = [[SGSegmentedControlBottomView alloc] initWithFrame:CGRectMake(0, 0 , WIDTH, HEIGHT)];
    _bottomSView.childViewController = childVC;
    _bottomSView.backgroundColor = [UIColor clearColor];
    _bottomSView.delegate = self;
    
    [self.view addSubview:_bottomSView];
    
    self.topSView = [SGSegmentedControlDefault segmentedControlWithFrame:CGRectMake(0, 0 , WIDTH, DetailToolBarHeight) delegate:self childVcTitle:title_arr isScaleText:NO];
    _topSView.showsBottomScrollIndicator = NO;
    _topSView.titleColorStateSelected = DefaultAPPColor;
    _topSView.backgroundColor = DefaultBackgroundColor;
    [self.view addSubview:_topSView];

 
}


- (void)SGSegmentedControlDefault:(SGSegmentedControlDefault *)segmentedControlDefault didSelectTitleAtIndex:(NSInteger)index {
    CGFloat offsetX = index * self.view.frame.size.width;
    CGFloat offsetY = 0;
    
    // 计算滚动的位置
    self.bottomSView.contentOffset = CGPointMake(offsetX, offsetY);
    
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x < -30) {
        [self.navigationController popViewControllerAnimated:YES];
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
