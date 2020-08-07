//
//  RewardsRecordViewController.m
//  HQJBusiness
//  奖励记录
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//
#import "RewardsRecordChildCell.h"

#pragma mark --- 子控制器
@interface RewardsRecordChildVC: UIViewController

@end
@interface RewardsRecordChildVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *recordTableView;
@property (nonatomic, assign) NSInteger page;
@end
@implementation RewardsRecordChildVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.recordTableView];
    self.page = 1;
}
- (void)requst {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.recordTableView.mj_header endRefreshing];
        [self.recordTableView.mj_footer endRefreshing];

    });
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 3;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RewardsRecordChildCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RewardsRecordChildCell class]) forIndexPath:indexPath];
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

@interface RewardsRecordViewController ()<UIScrollViewDelegate,SGSegmentedControlStaticDelegate>
@property (nonatomic, strong) SGSegmentedControlStatic *topSView;
@property (nonatomic, strong) SGSegmentedControlBottomView *bottomSView;
@end

@implementation RewardsRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"消费奖励记录";
    [self initVC];
}
-(void)initVC {
    RewardsRecordChildVC *sdVC = [[RewardsRecordChildVC alloc]init];
    [self addChildViewController:sdVC];
    
    RewardsRecordChildVC *irZHVC = [[RewardsRecordChildVC alloc]init];
    [self addChildViewController:irZHVC];
    
    NSArray *childVC = @[sdVC, irZHVC];
    
    NSArray *title_arr = @[@"员工邀请奖励",@"商家邀请奖励"];
    
    self.bottomSView = [[SGSegmentedControlBottomView alloc] initWithFrame:CGRectMake(0, NavigationControllerHeight + 44 , WIDTH, HEIGHT - NavigationControllerHeight - 44)];
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
//    [self.view bringSubviewToFront:self.editorButton];
//    [self.view bringSubviewToFront:self.deleteButton];
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
@end
