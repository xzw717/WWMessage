//
//  UnionActivityViewController.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/1/26.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UnionActivityDetailViewController.h"
#import "UnionActivityCell.h"
#import "UnionActivityDetailCell.h"
#import "UnionDetailSectionView.h"
#import "AddUnionModel.h"
#import "AddUnionCoponViewModel.h"

#define TableViewCellHeight 300.f
#define TableViewTopSpace 40/3.f
@interface UnionActivityDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UnionActivityListModel *listModel;
@property (nonatomic, strong) AddUnionModel *unoinModel;
@end

@implementation UnionActivityDetailViewController
- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = @[@[@"联盟券类型：",@"typeId"],@[@"联盟券面额：",@"reducePrice"],@[@"每人限领：",@"receiveNumber"],@[@"发行数量：",@"count"],@[@"领取数量：",@"receiverCount"],@[@"使用数量：",@"usedCount"]];
    }
    return _dataArray;
}

-(UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UnionActivityCell class] forCellReuseIdentifier:NSStringFromClass([UnionActivityCell class])];
        [_tableView registerClass:[UnionActivityDetailCell class] forCellReuseIdentifier:NSStringFromClass([UnionActivityDetailCell class])];
        
        
    }
    
    return _tableView;
}
- (instancetype)initWithModel:(UnionActivityListModel *)model{
    self = [super init];
    if (self) {
        self.listModel = model;
        [AddUnionCoponViewModel getUnionCouponById:model.activityId completion:^(NSDictionary * _Nonnull dic) {
            if ([dic[@"code"] integerValue] == 49000) {
                self.unoinModel = [AddUnionModel mj_objectWithKeyValues:dic[@"result"][@"coupon"]];

                [self.tableView reloadData];
            }else{
                self.unoinModel = [[AddUnionModel alloc]init];
                [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
            }

        }];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"联盟活动";
    
    [self initUI];
    
    
    // Do any additional setup after loading the view.
}
- (void)initUI{
    self.zwNavView.backgroundColor = DefaultAPPColor;
    self.zwTitLabel.textColor = [UIColor whiteColor];
    self.bottomLineView.hidden = YES;
    [self.zwBackButton setImage:[UIImage imageNamed:@"icon_back_arrow_white"] forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn addTarget:self action:@selector(addUnionActivity) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
//    self.zw_rightOneButton = rightBtn;
}

- (void)addUnionActivity{
    
}
#pragma mark --- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return view;
    }else{
        UnionDetailSectionView *view = [[UnionDetailSectionView alloc]init];
        return view;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return TableViewCellHeight;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UnionActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UnionActivityCell class]) forIndexPath:indexPath];
        cell.model = self.listModel;
        return cell;
    }else{
        UnionActivityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UnionActivityDetailCell class]) forIndexPath:indexPath];
        cell.model = self.unoinModel;
        cell.dataArray = self.dataArray[indexPath.row];
        return cell;
    }
    
    
}
#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
