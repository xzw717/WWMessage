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
#import "AddStaffViewModel.h"
#import "RoleListModel.h"
#import "AddStaffViewModel.h"
#import "StaffRoleViewController.h"
#import "NSString+RegexCategory.h"
@interface RewardSetViewController ()<UITableViewDelegate,UITableViewDataSource,RewardSetEditDelegate>{
    BOOL _isEnabled;
}
@property (nonatomic, strong) UITableView *rewardSetTableView;
@property (nonatomic, strong) RewardSetHeaderView *headerView;
@property (nonatomic, strong) RewardSetFootView *footView;
@property (nonatomic, strong) NSMutableArray <RewardSetModel *>*roleSetArray;
@property (nonatomic, strong) UIButton *saveSetButton;

/// 已有的角色
@property (nonatomic, strong) NSMutableArray <RoleListModel *>*roleList;
/// 已设置和将要设置的角色
@property (nonatomic, strong) NSMutableArray <RoleListModel *>*hasSetArray;




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
    self.roleList = [NSMutableArray array];
    self.hasSetArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:)name:UITextFieldTextDidChangeNotification object:nil];
    
    [AddStaffViewModel getTitlesWithCompletion:^(NSArray<RoleListModel *> * _Nonnull modelArray) {
        self.roleList = [modelArray mutableCopy];
        [modelArray enumerateObjectsUsingBlock:^(RoleListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.roleAward && ![obj.roleAward isEqualToString:@"0"]) {
                [self.hasSetArray addObject:obj];
            }
            if (idx == modelArray.count - 1) {
                if (self.hasSetArray.count <= 0) {
                    RoleListModel *objs = [[RoleListModel alloc]init];
                    objs.roleName = @"请选择";
                    [self.hasSetArray insertObject:objs atIndex:0];
                }
               
                [self.rewardSetTableView reloadData];
            }
        }];
        
    }];
}
- (void)textFieldDidChanged:(NSNotification *)noti {
    UITextField *textField=noti.object;
    NSIndexPath *indexPath = textField.indexPath;
    RewardSetCell *cell = [self.rewardSetTableView dequeueReusableCellWithIdentifier:NSStringFromClass([RewardSetCell class]) forIndexPath:indexPath];
    HQJLog(@"%@",cell.btnTitle);
    [self setModelRoleWithIndexpath:indexPath titleid:nil number:textField.text];

}


- (void)saveAction {
    NSMutableDictionary *setDict = [NSMutableDictionary dictionary];
    [self.hasSetArray enumerateObjectsUsingBlock:^(RoleListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           if ( [obj.roleName isEqualToString:@"请选择"]||  [obj.roleAward isEqualToString:@""] || obj.roleAward == nil) {
                [SVProgressHUD showErrorWithStatus:@"数据未设置"];
                *stop = YES;
           } else {
               if ([obj.roleAward deptNumInputShouldNumber]) {
                   if ([obj.roleAward integerValue] > 100 || [obj.roleAward integerValue] < 0 ) {
                       [SVProgressHUD showErrorWithStatus:@"请输入正确的比例"];
                       *stop = YES;

                   } else {
                       [setDict setValue:obj.roleAward forKey:obj.nid];

                   }

               } else {
                   [SVProgressHUD showErrorWithStatus:@"请输入正确的比例"];
                   *stop = YES;
                   
               }
           }
    }];
    HQJLog(@"我要设置的角色比例：%@",setDict);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.hasSetArray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RewardSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RewardSetCell class]) forIndexPath:indexPath];
    cell.cellModel = self.hasSetArray[indexPath.row];
    @weakify(self);
    [cell setAddAction:^{
        @strongify(self);
//        if (self.roleArray.count + 1 > self.roleSetArray.count) {
            /// 设置的条数不能大于总角色数+1（全部角色算一条）
            [self.hasSetArray addObject:[[RoleListModel alloc]init]];
            [self addNewRole];
            [self.rewardSetTableView reloadData];
//        }
        
    }];
    [cell setRemoveAction:^{
        @strongify(self);
        [self.hasSetArray removeObjectAtIndex:indexPath.row];
        [self.rewardSetTableView reloadData];

    }];
    [cell setSelectRoleAction:^(UIButton *btn) {
        [AddStaffViewModel getTitlesWithCompletion:^(NSArray<RoleListModel *> * _Nonnull modelArray) {
            
            if (modelArray.count && modelArray.count > 0) {
                [[SelectMenuView showMenuWithView:btn].munuAry(modelArray) setClickModel:^(RoleListModel * _Nonnull model) {
                              @strongify(self);
                              [self setModelRoleWithIndexpath:indexPath titleid:model.nid number:nil];
                              [self.rewardSetTableView reloadData];
                          }];
            } else {
                [SVProgressHUD showWithStatus:@"没有角色请添加"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    @strongify(self);
                    [SVProgressHUD dismiss];
                    StaffRoleViewController *vc = [[StaffRoleViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                });
            }
          
        }];
        
    }];
    return cell;
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull RewardSetCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        [cell setCellIndexPath:indexPath];

}
 
#pragma mark --- 更新数据
- (void )setModelRoleWithIndexpath:(NSIndexPath *)index
                           titleid:(NSString *)titleid
                            number:(NSString *)num  {
    RoleListModel *model = self.hasSetArray[index.row];
    [self.roleList enumerateObjectsUsingBlock:^(RoleListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.nid isEqualToString:titleid]) {
            model.roleName = obj.roleName;
            *stop = YES;
        }
    }];
    model.nid = titleid ? titleid : model.nid;
    model.roleAward = num ? num :model.roleAward;
    [self.hasSetArray replaceObjectAtIndex:index.row withObject:model];
    
}

#pragma mark ---添加新的一行角色
- (void)addNewRole {
    NSIndexPath *index= [NSIndexPath indexPathForRow:self.hasSetArray.count - 1 inSection:0];
    RoleListModel *model = self.hasSetArray[index.row];
    model.roleName = @"请选择";
    [self.hasSetArray replaceObjectAtIndex:index.row withObject:model];
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
//        _saveSetButton.hidden = YES;
    }
    return _saveSetButton;
}

@end
