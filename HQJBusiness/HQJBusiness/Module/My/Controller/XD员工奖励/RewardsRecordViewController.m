//
//  RewardsRecordViewController.m
//  HQJBusiness
//  奖励记录
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//
#import "RewardsRecordChildCell.h"
#import "RewardsRecordViewModel.h"
#import "RewardsRecordSuperModel.h"

static NSString *const totalKey = @"totalKey";

#pragma mark --- 子控制器
@interface RewardsRecordChildVC: UIViewController
/// 显示的类型： 员工 or 商家
@property (nonatomic, strong) NSString *typeStr;
@end
@interface RewardsRecordChildVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *recordTableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) RewardsRecordSuperModel *model;
@property (nonatomic, strong) NSMutableArray <RewardsRecordModel *>*modeAry;
@end
@implementation RewardsRecordChildVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.recordTableView];
    self.page = 1;
    self.modeAry = [NSMutableArray array];
    [self requst];
}

- (void)requst {
    [RewardsRecordViewModel getAwardWithType:self.typeStr page:self.page completion:^(RewardsRecordSuperModel * _Nonnull model, NSError * _Nonnull requstError) {
        [[NSNotificationCenter defaultCenter]postNotificationName:totalKey object:nil userInfo:@{@"total":model.total ?model.total :@"0",@"score":model.totalScore ? model.totalScore : @"0"}];
        if (!requstError) {
            if (self.page > 1) {
                if (model.data.count == 0) {
                    self.page --;
                } else {
                    [self.modeAry addObjectsFromArray:model.data];
                }
            } else {
                self.modeAry = [model.data mutableCopy];
                
            }
        }
        
        
        [self.recordTableView reloadData];
        [self.recordTableView.mj_header endRefreshing];
        [self.recordTableView.mj_footer endRefreshing];
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modeAry.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RewardsRecordChildCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RewardsRecordChildCell class]) forIndexPath:indexPath];
    [cell setModelWithModel:self.modeAry[indexPath.row] type:self.typeStr];
    return cell;
    
}

- (UITableView *)recordTableView {
    if (!_recordTableView) {
        _recordTableView = [[UITableView alloc]init];
        _recordTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, HEIGHT - NavigationControllerHeight - 44);
        _recordTableView.backgroundColor = [ManagerEngine getColor:@"f5f5f5"];
        _recordTableView.delegate = self;
        _recordTableView.dataSource = self;
        _recordTableView.rowHeight = 60.f;
        [_recordTableView registerClass:[RewardsRecordChildCell class] forCellReuseIdentifier:NSStringFromClass([RewardsRecordChildCell class])];
        _recordTableView.tableFooterView = [UIView new];
        @weakify(self);
        _recordTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            self.page = 1;
            [self requst];
            
            
        }];
        _recordTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            self.page ++;
            [self requst];
        }];
    }
    return _recordTableView;
}

@end



#pragma mark --- 主控制器
#import "RewardsRecordViewController.h"
#import "ScoreGiftViewController.h"
@interface RewardsRecordViewController ()<UIScrollViewDelegate,SGSegmentedControlStaticDelegate>
@property (nonatomic, strong) SGSegmentedControlStatic *topSView;
@property (nonatomic, strong) SGSegmentedControlBottomView *bottomSView;
@property (nonatomic, strong) RewardsRecordChildVC *sdVC;
@property (nonatomic, strong) RewardsRecordChildVC *irZHVC;
/// 总计label
@property (nonatomic, strong) UILabel *totalLabel;
@end

@implementation RewardsRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title =  self.isMembersRewards ? @"消费奖励记录" : @"XD商家活动积分";
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"赠送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
    rightBtn.bounds = CGRectMake(0, 0, 60, 44);
    self.zw_rightOneButton = rightBtn;
    [rightBtn addTarget:self action:@selector(scoreGiftClicked) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.hidden = self.isMembersRewards ;
    [self initVC];
}
- (void)scoreGiftClicked{
    ScoreGiftViewController *vc = [[ScoreGiftViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)initVC {
    self.sdVC = [[RewardsRecordChildVC alloc]init];
    self.sdVC.typeStr = self.isMembersRewards ? @"员工" : @"奖励记录";
    [self addChildViewController:self.sdVC];
    
    self.irZHVC = [[RewardsRecordChildVC alloc]init];
    self.irZHVC.typeStr = self.isMembersRewards ? @"商家" : @"赠送记录";
    [self addChildViewController:self.irZHVC];
    
    NSArray *childVC = @[self.sdVC, self.irZHVC];
    
    NSArray *title_arr = self.isMembersRewards ? @[@"员工邀请奖励",@"商家邀请奖励"] :@[@"奖励记录",@"赠送记录"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTotal:) name:totalKey object:nil];
    self.bottomSView = [[SGSegmentedControlBottomView alloc] initWithFrame:CGRectMake(0, NavigationControllerHeight + 44 + 44 , WIDTH, HEIGHT - NavigationControllerHeight - 44)];
    _bottomSView.childViewController = childVC;
    _bottomSView.backgroundColor = [UIColor clearColor];
    _bottomSView.delegate = self;
    [self.view addSubview:_bottomSView];
    
    self.topSView = [SGSegmentedControlStatic segmentedControlWithFrame:CGRectMake(0, NavigationControllerHeight , WIDTH, 44) delegate:self childVcTitle:title_arr indicatorIsFull:NO];
    
    // 必须实现的方法
    [self.topSView SG_setUpSegmentedControlType:nil];
    
    [self.topSView SG_setUpSegmentedControlStyle:^(UIColor *__autoreleasing *segmentedControlColor, UIColor *__autoreleasing *titleColor, UIColor *__autoreleasing *selectedTitleColor, UIColor *__autoreleasing *indicatorColor, BOOL *isShowIndicor) {
        *indicatorColor = DefaultAPPColor;
        *isShowIndicor = YES;
    }];
    self.topSView.selectedIndex = 0;
    
    _topSView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topSView];
    [self.view addSubview:self.totalLabel];
    //    [self.view bringSubviewToFront:self.editorButton];
    //    [self.view bringSubviewToFront:self.deleteButton];
}

- (void)changeTotal:(NSNotification *)notifi {
    self.totalLabel.text = [NSString stringWithFormat:@"    合计：赠送%@积分，总计%@",notifi.userInfo[@"total"],notifi.userInfo[@"score"]];
}

- (void)SGSegmentedControlStatic:(SGSegmentedControlStatic *)segmentedControlStatic didSelectTitleAtIndex:(NSInteger)index  {
    // 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.bottomSView.contentOffset = CGPointMake(offsetX, 0);
    [self.bottomSView showChildVCViewWithIndex:index outsideVC:self];
    if (index == 0) {
        [self.sdVC requst];

    } else {
        [self.irZHVC requst];


    }
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
        if (index == 0) {
             [self.sdVC requst];

         } else {
             [self.irZHVC requst];

         }
    }
//    [[NSNotificationCenter defaultCenter]postNotificationName:totalKey object:nil userInfo:@{@"total":model.total ?model.total :@"0",@"score":model.totalScore ? model.totalScore : @"0"}];

}
- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, NavigationControllerHeight + 44, WIDTH, 44)];
        _totalLabel.backgroundColor = DefaultAPPColor;
        _totalLabel.textColor = [UIColor whiteColor];
        _totalLabel.font = [UIFont systemFontOfSize:14.f];
        _totalLabel.text = @"    加载中";
    }
    return _totalLabel;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
