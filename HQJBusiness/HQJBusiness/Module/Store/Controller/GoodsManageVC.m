//
//  GoodsManageVC.m
//  HQJBusiness
//   商品管理
//  Created by mymac on 2019/6/27.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsManageVC.h"
#import "SaleVC.h"
#import "SoldOutVC.h"
#import "DraftVC.h"
#import "GoodsManageBottomView.h"

#define GoodsManageNavButtonSize 22
@interface GoodsManageVC () <SGSegmentedControlStaticDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) SGSegmentedControlStatic *topSView;
@property (nonatomic, strong) SGSegmentedControlBottomView *bottomSView;
@property (nonatomic, strong) GoodsManageBottomView *selectBottomView;
@property (nonatomic, strong) GoodsManageViewModel *viewModel;
@end

@implementation GoodsManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品管理";
    [self setTopMenu];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavType:HQJNavigationBarWhite];
    [self hideShadowLine];
}

- (void)setTopMenu {
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:38 / 3.f];
    addButton.layer.masksToBounds = YES;
    addButton.layer.cornerRadius = 41 / 3.f;
    addButton.backgroundColor = DefaultAPPColor;
    addButton.frame = CGRectMake(0, 0, 164 / 3.f, 82 / 3.f);
//    @weakify(self);
    [addButton addTarget:self.viewModel action:@selector(clickEmptyViewbutton) forControlEvents:UIControlEventTouchUpInside];
//    [addButton bk_addEventHandler:^(id  _Nonnull sender) {
//        @strongify(self);
////        [self.viewModel navMenu:sender];
//
//    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRightItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = barRightItem;
    
    
    
    SaleVC *saleVC = [[SaleVC alloc]init];
    [self addChildViewController:saleVC];
    
    SoldOutVC *soldOutVC = [[SoldOutVC alloc]init];
    [self addChildViewController:soldOutVC];
    
    DraftVC *draftVC = [[DraftVC alloc]init];
    [self addChildViewController:draftVC];

    NSArray *childVC = @[saleVC,soldOutVC,draftVC];
    
    NSArray *title_arr = @[@"出售中(0)",@"已下架(0)",@"草稿中(0)"];
    
    
    
    self.bottomSView = [[SGSegmentedControlBottomView alloc] initWithFrame:CGRectMake(0, 0 , WIDTH, HEIGHT  - NavigationControllerHeight)];
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
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *title_arr1 = @[@"出售中(1)",@"已下架(3)",@"草稿中(999)"];
        [self.topSView setTitle_Arr:title_arr1];

    });

//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goodsCount:) name:GoodsStateCount object:nil];
}




- (void)goodsCount:(NSNotification *)notifi {
    NSInteger typeStr = [notifi.userInfo[@"type"] integerValue];
    NSInteger countStr = [notifi.userInfo[@"count"] integerValue];
    NSString *titleOne = @"";
    NSString *titleTwo = @"";
    NSString *titleThree = @"";

    if (typeStr == 1) {
        titleOne = [NSString stringWithFormat:@"出售中(%ld)",countStr];
    }
    if (typeStr == 2) {
        titleOne = [NSString stringWithFormat:@"已下架(%ld)",countStr];
    }
    if (typeStr == 3) {
        titleOne = [NSString stringWithFormat:@"草稿中(%ld)",countStr];
    }
    if (![titleOne isEqualToString:@""] && ![titleTwo isEqualToString:@""] && ![titleThree isEqualToString:@""]  ) {
        [self.topSView setTitle_Arr:@[titleOne,titleTwo,titleThree]];

    }
}
//- (void)aaa {
//
//}
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
- (GoodsManageViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GoodsManageViewModel alloc]init];
    }
    return _viewModel;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
