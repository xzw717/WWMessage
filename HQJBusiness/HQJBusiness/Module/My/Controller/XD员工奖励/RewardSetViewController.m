//
//  RewardSetViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/8/3.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "RewardSetViewController.h"
#import "UITextField+IndexPath.h"
#import "RewardSetCell.h"
#import "RewardSetHeaderView.h"
#import "RewardSetModel.h"
#import "SelectMenuView.h"
#import "ZGRelayoutButton.h"
#import "RewardSetFootView.h"

@interface RewardSetViewController ()<UITableViewDelegate,UITableViewDataSource,RewardSetEditDelegate>{
    BOOL _isEnabled;
}
@property (nonatomic, strong) UITableView *rewardSetTableView;
@property (nonatomic, strong) RewardSetHeaderView *headerView;
@property (nonatomic, strong) RewardSetFootView *footView;
@property (nonatomic, strong) NSMutableArray <RewardSetModel *>*roleSetArray;
@property (nonatomic, strong) UIButton *saveSetButton;
@property (nonatomic, strong) NSMutableArray <NSString *>*roleArray;

@end

@implementation RewardSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"奖励设置";
    _isEnabled = NO;
    [self.view addSubview:self.rewardSetTableView];
    [self.view addSubview:self.saveSetButton];
    RewardSetModel *model = [[RewardSetModel alloc]init];
    model.roleTitle = @"全部";
    self.roleSetArray = [NSMutableArray arrayWithObject:model];
    self.roleArray = [NSMutableArray arrayWithObjects:@"角色一",@"角色二",@"角色三", nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:)name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)textFieldDidChanged:(NSNotification *)noti{
    UITextField *textField=noti.object;
    NSIndexPath *indexPath = textField.indexPath;
    RewardSetCell *cell = [self.rewardSetTableView dequeueReusableCellWithIdentifier:NSStringFromClass([RewardSetCell class]) forIndexPath:indexPath];
    HQJLog(@"%@",cell.btnTitle);
    [self setModelRoleWithIndexpath:indexPath title:nil number:textField.text];

}


- (void)saveAction {
    [self.roleSetArray enumerateObjectsUsingBlock:^(RewardSetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ( [obj.roleTitle isEqualToString:@"请选择"]||  [obj.number isEqualToString:@""] || obj.number == nil) {
            [SVProgressHUD showErrorWithStatus:@"数据未设置"];
            *stop = YES;
        } else {
            if (idx == self.roleSetArray.count - 1) {
                /// 可以提交
            }
        }
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.roleSetArray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RewardSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RewardSetCell class]) forIndexPath:indexPath];
    cell.cellModel = self.roleSetArray[indexPath.row];
    @weakify(self);
    [cell setAddAction:^{
        @strongify(self);
        if (self.roleArray.count + 1 > self.roleSetArray.count) {
            /// 设置的条数不能大于总角色数+1（全部角色算一条）
            [self.roleSetArray addObject:[[RewardSetModel alloc]init]];
            [self addNewRole];
            [self.rewardSetTableView reloadData];
        }
        
    }];
    [cell setRemoveAction:^{
        @strongify(self);
        [self.roleSetArray removeObjectAtIndex:indexPath.row];
        [self.rewardSetTableView reloadData];

    }];
    [cell setSelectRoleAction:^(UIButton *btn) {
#warning  show  menu  title
//        [[SelectMenuView showMenuWithView:btn].munuAry(self.roleArray) setClickTitle:^(NSString * _Nonnull str) {
//            @strongify(self);
//            [self setModelRoleWithIndexpath:indexPath title:str number:nil];
//            [self.rewardSetTableView reloadData];
//
//        }];
    }];

    return cell;
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull RewardSetCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [cell setIsEnabled:_isEnabled];
    [cell setCellIndexPath:indexPath];

}
- (void)clickEdit {
    _isEnabled = YES;
    self.saveSetButton.hidden = NO;
    [self.rewardSetTableView reloadData];
    HQJLog(@"开始编辑 ");
}
#pragma mark --- 更新数据
- (void )setModelRoleWithIndexpath:(NSIndexPath *)index title:(NSString *)title number:(NSString *)num  {
    RewardSetModel *model = self.roleSetArray[index.row];
    model.roleTitle = title ? title : model.roleTitle;
    model.number = num ? num :model.number;
    [self.roleSetArray replaceObjectAtIndex:index.row withObject:model];
    
}


#pragma mark ---添加新的一行角色
- (void)addNewRole {
    NSIndexPath *index= [NSIndexPath indexPathForRow:self.roleSetArray.count - 1 inSection:0];
    [self setModelRoleWithIndexpath:index title:@"请选择" number:nil];
}

- (UITableView *)rewardSetTableView {
    if (!_rewardSetTableView) {
        _rewardSetTableView = [[UITableView alloc]init];
        _rewardSetTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _rewardSetTableView.backgroundColor = [ManagerEngine getColor:@"f5f5f5"];
        _rewardSetTableView.delegate = self;
        _rewardSetTableView.dataSource = self;
        _rewardSetTableView.rowHeight = 55.f;
        _rewardSetTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_rewardSetTableView registerClass:[RewardSetCell class] forCellReuseIdentifier:NSStringFromClass([RewardSetCell class])];
        _rewardSetTableView.tableFooterView = self.footView;
        _rewardSetTableView.tableHeaderView = self.headerView;
    }
    return _rewardSetTableView;
}
- (RewardSetHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[RewardSetHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 54)];
        _headerView.delegate = self;
        _headerView.backgroundColor = [UIColor whiteColor];
        
    }
    return _headerView;
}
- (RewardSetFootView *)footView {
    if (!_footView) {
        _footView = [[RewardSetFootView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, NewProportion(500))];
        _footView.backgroundColor = [UIColor whiteColor];

    }
    return _footView;
}
- (UIButton *)saveSetButton {
    if (!_saveSetButton) {
        _saveSetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveSetButton setFrame:CGRectMake(NewProportion(50), HEIGHT - NewProportion(110) - NewProportion(130), WIDTH - NewProportion(50) *2, NewProportion(130))];
        [_saveSetButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveSetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveSetButton.titleLabel setFont:[UIFont systemFontOfSize:NewProportion(55)]];
        [_saveSetButton setBackgroundColor:DefaultAPPColor];
        _saveSetButton.layer.masksToBounds = YES;
        _saveSetButton.layer.cornerRadius = NewProportion(65);
        [_saveSetButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
        _saveSetButton.hidden = YES;
    }
    return _saveSetButton;
}

@end
