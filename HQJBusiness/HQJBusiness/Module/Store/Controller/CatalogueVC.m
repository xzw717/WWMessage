//
//  CatalogueVC.m
//  HQJBusiness
//  商品目录
//  Created by mymac on 2019/7/15.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "CatalogueVC.h"
#import "GoodsCatalogueTopCell.h"
#import "GoodsCatalogueModel.h"
#import "CatalogueViewModel.h"

@interface CatalogueVC ()
@property (nonatomic, strong) UITableView *catalogueTableView;
@property (nonatomic, strong) GoodsCatalogueTopView *topView;
@property (nonatomic, strong) GoodsCatalogueBottomView *bottomView;
@property (nonatomic, strong) CatalogueViewModel *viewModel;
@property (nonatomic, strong) UIButton *confirmButton;
@end

@implementation CatalogueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品目录";
    self.view.backgroundColor = DefaultBackgroundColor;
    NSMutableArray *itemAry = [NSMutableArray array];
    NSArray *titAry = @[@"热菜",@"小龙虾系列",@"特色菜",@"冷",@"粉面系列",@"早餐系列",@"神奇的无敌的厚爱啊什么的阿克苏的垃圾的垃圾的垃"];
    NSArray *selectAry = @[@"冷",@"粉面系列"];
    for (NSInteger index = 0; index < titAry.count ; index++) {
        GoodsCatalogueModel *model = [[GoodsCatalogueModel alloc]init];
        model.btnTit = titAry[index];
        if ([selectAry containsObject:titAry[index]]) {
            model.isSelect = YES;
        }
        [itemAry addObject:model];
    }
    [self.topView itemArray:itemAry];
    [self setup];
 
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self setNavType:HQJNavigationBarWhite];
}
- (void)setup {
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];

    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40 /3.f);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(self.view.height / 2.f);

    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).mas_offset(40 /3.f);
        make.left.right.mas_equalTo(0);
        
    }];
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmButton.backgroundColor = DefaultAPPColor;
    self.confirmButton.layer.masksToBounds = YES;
    self.confirmButton.layer.cornerRadius = 73 / 3.f;
    self.confirmButton.titleLabel.font = [UIFont systemFontOfSize:50 / 3.f];
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton bk_addEventHandler:^(id  _Nonnull sender) {
        
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-ToolBarSafetyZoneHeight - 32/3);
        make.left.mas_equalTo(55 /3.f);
        make.right.mas_equalTo(- 55 / 3.f);
        make.height.mas_equalTo(146 / 3.f);
    }];
}


- (GoodsCatalogueTopView *)topView {
    if (!_topView) {
        _topView = [[GoodsCatalogueTopView alloc]init];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.topViewdelegate = self.viewModel;
    }
    return _topView;
}
- (GoodsCatalogueBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[GoodsCatalogueBottomView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.bottomDelegate = self.viewModel;
    }
    return _bottomView;
}
- (CatalogueViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CatalogueViewModel alloc]initWithTopView:self.topView];
    }
    return _viewModel;
}
@end
