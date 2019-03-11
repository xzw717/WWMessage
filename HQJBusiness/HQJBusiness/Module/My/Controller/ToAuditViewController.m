//
//  ToAuditViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ToAuditViewController.h"
#import "allViewController.h"
#import "ZHViewController.h"
#import "CashWithdrawViewController.h"
#import "BonusViewController.h"
#import "ZHProportionViewController.h"

@interface ToAuditViewController () <SGSegmentedControlDefaultDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) SGSegmentedControlDefault *topSView;
@property (nonatomic, strong) SGSegmentedControlBottomView *bottomSView;
@end

@implementation ToAuditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.zw_title = @"待审核申请";
    
    [self initVC];
    
    
}

-(void)initVC {
    allViewController *allVC = [[allViewController alloc]init];
    [self addChildViewController:allVC];
    
    ZHViewController *buyZHVC = [[ZHViewController alloc]init];
    [self addChildViewController:buyZHVC];
    
    CashWithdrawViewController *cashVC = [[CashWithdrawViewController alloc]init];
    [self addChildViewController:cashVC];
    
    BonusViewController *bonusVC =[[BonusViewController alloc]init];
    [self addChildViewController:bonusVC];
    
    ZHProportionViewController *ZHVC =[[ZHProportionViewController alloc]init];
    [self addChildViewController:ZHVC];
    
    NSArray *childVC = @[allVC, buyZHVC, cashVC, bonusVC,ZHVC];
    
    NSArray *title_arr = @[@"全部",[NSString stringWithFormat:@"购买%@值",HQJValue],@"现金提现", @"积分兑现", [NSString stringWithFormat:@"%@值比例",HQJValue]];
    
    
    self.bottomSView = [[SGSegmentedControlBottomView alloc] initWithFrame:CGRectMake(0, kNAVHEIGHT , WIDTH, HEIGHT - kNAVHEIGHT)];
    _bottomSView.childViewController = childVC;
    _bottomSView.backgroundColor = [UIColor clearColor];
    _bottomSView.delegate = self;

    [self.view addSubview:_bottomSView];
    
    self.topSView = [SGSegmentedControlDefault segmentedControlWithFrame:CGRectMake(0, kNAVHEIGHT , self.view.frame.size.width, 44) delegate:self childVcTitle:title_arr isScaleText:NO];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _bottomSView) {
        if (scrollView.mj_offsetX <= -50) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    

    
}

@end
