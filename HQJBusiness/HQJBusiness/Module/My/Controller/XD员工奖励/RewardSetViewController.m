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
#import "SetProportionViewModel.h"
@interface RewardSetViewController ()<UITableViewDelegate,UITableViewDataSource,RewardSetEditDelegate>{
    BOOL _isEnabled;
}
@property (nonatomic, strong) UITableView *rewardSetTableView;
@property (nonatomic, strong) RewardSetHeaderView *headerView;
@property (nonatomic, strong) RewardSetFootView *footView;
@property (nonatomic, strong) UIButton *saveSetButton;

/// 已有的角色
@property (nonatomic, strong) NSMutableArray <RoleListModel *>*roleList;
/// 可显示的角色列表<可操作>
@property (nonatomic, strong) NSMutableArray <RoleListModel *>*roleArray;

/// 界面上显示的角色及其比例
@property (nonatomic, strong) NSMutableArray <RoleListModel *>*hasSetArray;
/// 已设置的奖励及其比例（界面删除此数组不删除，删除代表其数值为0）
@property (nonatomic, strong) NSMutableArray <RoleListModel *>*roleSetArray;



@end

@implementation RewardSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"奖励设置";
    _isEnabled = NO;
    [self.view addSubview:self.rewardSetTableView];
    [self.view addSubview:self.saveSetButton];
    self.roleSetArray = [NSMutableArray array];
    self.roleList = [NSMutableArray array];
    self.hasSetArray = [NSMutableArray array];
    self.roleArray = [NSMutableArray array];
    [AddStaffViewModel getTitlesWithCompletion:^(NSArray<RoleListModel *> * _Nonnull modelArray) {
        self.roleList  = modelArray.copy;
        [self.roleArray addObjectsFromArray:modelArray];
        [modelArray enumerateObjectsUsingBlock:^(RoleListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.roleRate && ![obj.roleRate isEqualToString:@"0"]) {
                [self.hasSetArray addObject:obj];
                [self.roleSetArray addObject:obj];
                [self.roleArray removeObject:obj];
            }
            if (modelArray.count - 1 == idx) {
                if (!self.hasSetArray.count || self.hasSetArray.count == 0) {
                    RoleListModel *objs = [[RoleListModel alloc]init];
                    objs.roleName = @"请选择";
                    [self.hasSetArray insertObject:objs atIndex:0];
                    [self.roleSetArray insertObject:objs atIndex:0];
                    
                }
                [self.rewardSetTableView reloadData];
            }
            
        }];
        if (!modelArray.count || modelArray.count == 0) {
            RoleListModel *objs = [[RoleListModel alloc]init];
            objs.roleName = @"请选择";
            [self.hasSetArray insertObject:objs atIndex:0];
            [self.roleSetArray insertObject:objs atIndex:0];
            
            [self.rewardSetTableView reloadData];
        }
        
    }];
}
- (void)textFieldDidChanged:(NSNotification *)noti {
    UITextField *textField=noti.object;
    NSIndexPath *indexPath = textField.indexPath;
    RewardSetCell *cell = [self.rewardSetTableView dequeueReusableCellWithIdentifier:NSStringFromClass([RewardSetCell class]) forIndexPath:indexPath];
    HQJLog(@"%@",cell.btnTitle);
    [self setModelRoleWithIndexpath:indexPath titleid:nil number:textField.text];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:)name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)saveAction {
     BOOL isSuccess = NO;
    NSMutableDictionary *setDict = [NSMutableDictionary dictionary];
    for (NSInteger i = self.roleSetArray.count - 1; i >= 0; i --) {
        RoleListModel *  obj = self.roleSetArray[i];
       if (obj.roleName == nil && obj.roleRate == nil) {
           [self.roleSetArray removeObjectAtIndex:i];
           continue;
        }
        if ( [obj.roleName isEqualToString:@"请选择"]||  [obj.roleRate isEqualToString:@""] || obj.roleRate == nil) {
            [SVProgressHUD showErrorWithStatus:@"数据未设置"];
            isSuccess = NO;

            return;
            
        } else {
            if ([obj.roleRate deptNumInputShouldNumber]) {
                if ([obj.roleRate integerValue] > 100 || [obj.roleRate integerValue] < 0 ) {
                    [SVProgressHUD showErrorWithStatus:@"请输入正确的比例"];
                    isSuccess = NO;
                    return;

                } else {
                    [setDict setValue:obj.roleRate forKey:obj.nid];
                    if (0 == i) {
                        isSuccess = YES;
                    }
                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:@"请输入正确的比例"];
                isSuccess = NO;
                return;

            }
        }
    }
//    [self.roleSetArray enumerateObjectsUsingBlock:^(RoleListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//        if ( [obj.roleName isEqualToString:@"请选择"]||  [obj.roleRate isEqualToString:@""] || obj.roleRate == nil) {
//            [SVProgressHUD showErrorWithStatus:@"数据未设置"];
//            isSuccess = NO;
//            *stop = YES;
//        } else {
//            if ([obj.roleRate deptNumInputShouldNumber]) {
//                if ([obj.roleRate integerValue] > 100 || [obj.roleRate integerValue] < 0 ) {
//                    [SVProgressHUD showErrorWithStatus:@"请输入正确的比例"];
//                    isSuccess = NO;
//                    *stop = YES;
//
//                } else {
//                    [setDict setValue:obj.roleRate forKey:obj.nid];
//                    if (self.roleSetArray.count - 1 == idx) {
//                        isSuccess = YES;
//                    }
//                }
//
//            } else {
//                [SVProgressHUD showErrorWithStatus:@"请输入正确的比例"];
//                isSuccess = NO;
//                *stop = YES;
//
//            }
//        }
//    }];
    HQJLog(@"保存操作里的数组：%@, %@",self.roleSetArray,self.hasSetArray);

    if (isSuccess) {
        @weakify(self);
        [SetProportionViewModel setReward:setDict completion:^{
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    
    HQJLog(@"我要设置的角色比例：%@",setDict);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hasSetArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RewardSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RewardSetCell class]) forIndexPath:indexPath];
    cell.cellModel = self.hasSetArray[indexPath.row];
    cell.isFull = self.roleList.count > self.hasSetArray.count ? NO : YES;
  
    @weakify(self);
    [cell setAddAction:^{
        @strongify(self);
        /// 设置的条数不能大于总角色数+1（全部角色算一条）
        [self.hasSetArray addObject:[[RoleListModel alloc]init]];
        [self.roleSetArray addObject:[[RoleListModel alloc]init]];
        [self addNewRole];
        [self.rewardSetTableView reloadData];
        
        
        HQJLog(@"添加操作里的数组：%@, %@",self.roleSetArray,self.hasSetArray);

        //        }
        
    }];
    [cell setRemoveAction:^{
        @strongify(self);
        RoleListModel *btnModel = self.roleSetArray[indexPath.row].copy;

        if ([self.roleSetArray[indexPath.row].roleName isEqualToString:@"请选择"] || self.roleSetArray[indexPath.row].roleRate == nil) {
            [self.roleSetArray removeObjectAtIndex:indexPath.row];
        } else {
            [self setModelRoleWithIndexpath:indexPath titleid:nil number:@"0"];

        }
        if (![btnModel.roleName isEqualToString:@"请选择"] && btnModel.nid) {
            [self.roleArray addObject:btnModel];

        }
        HQJLog(@"删除操作里的数组：%@, %@",self.roleSetArray,self.hasSetArray);
        [self.hasSetArray removeObjectAtIndex:indexPath.row];
        
        [self.rewardSetTableView reloadData];
        
    }];
    [cell setSelectRoleAction:^(ZGRelayoutButton *btn) {
        @strongify(self);
        btn.enabled =  NO;
        if (self.roleArray && self.roleArray.count > 0) {
            [self.roleArray enumerateObjectsUsingBlock:^(RoleListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                          HQJLog(@"弹窗前:%@",obj.roleName);

            }];
            [self showRoleView:self.roleArray clickView:btn];
        }
   /**
    
    else {
                [AddStaffViewModel getTitlesWithCompletion:^(NSArray<RoleListModel *> * _Nonnull modelArray) {
                           if (modelArray.count && modelArray.count > 0) {
                               [self showRoleView:modelArray clickView:btn];
                           } else {
                               [SVProgressHUD showInfoWithStatus:@"没有角色请添加"];
                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                   @strongify(self);
                                   [SVProgressHUD dismiss];
                                   btn.enabled =  YES;
                                   StaffRoleViewController *vc = [[StaffRoleViewController alloc]init];
                                   [self.navigationController pushViewController:vc animated:YES];
                               });
                           }
                           
                       }];
           }
    
    
    */
        
    }];
    return cell;
    
}
- (void)showRoleView:(NSArray *)ary clickView:(ZGRelayoutButton *)view{
    @weakify(self);
    [[SelectMenuView showMenuWithView:view].munuAry(ary) setClickModel:^(RoleListModel * _Nonnull model) {
        @strongify(self);
                     
        if (model) {
           
            RoleListModel *btnModel = self.roleSetArray[view.btnIndexPath.row].copy;
            if (![btnModel.roleName isEqualToString:@"请选择"] && btnModel.nid) {
                 [self.roleArray addObject:btnModel];
            }
           

            RoleListModel *selectModel = model.copy;
            
            
            [self.roleArray enumerateObjectsUsingBlock:^(RoleListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.roleName isEqualToString:selectModel.roleName]) {
                    [self.roleArray removeObjectAtIndex:idx];
                    *stop = YES;
                }
            }];
            
            [view setTitle:model.roleName forState:UIControlStateNormal];
            [self setaryWithMpdel:model index:view.btnIndexPath];
            [self.roleArray enumerateObjectsUsingBlock:^(RoleListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HQJLog(@"操作别的数组之后:%@.....%@",obj.roleName,self.roleSetArray[view.btnIndexPath.row]);

            }];
            [self.rewardSetTableView reloadData];
        }
        view.enabled =  YES;;
                  
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull RewardSetCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [cell setCellIndexPath:indexPath];
    
}
- (void)setaryWithMpdel:(RoleListModel *)model  index:(NSIndexPath *)index {
    if (model) {
          [self.hasSetArray replaceObjectAtIndex:index.row withObject:model];
             [self.roleSetArray replaceObjectAtIndex:index.row withObject:model];
      } else {
        [self setModelRoleWithIndexpath:index titleid:model.nid number:model.roleRate];
      }
}
#pragma mark --- 更新数据
- (void )setModelRoleWithIndexpath:(NSIndexPath *)index
                           titleid:(NSString *)titleid
                            number:(NSString *)num  {
    RoleListModel *model = self.roleSetArray[index.row];
    [self.roleList enumerateObjectsUsingBlock:^(RoleListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.nid isEqualToString:titleid]) {
            model.roleName = obj.roleName;
            *stop = YES;
        }
     
    }];
    model.nid = titleid ? titleid : model.nid;
    model.roleRate = num ? num :model.roleRate;
  
    
    [self.hasSetArray replaceObjectAtIndex:index.row withObject:model];
    [self.roleSetArray replaceObjectAtIndex:index.row withObject:model];
    
}

#pragma mark ---添加新的一行角色
- (void)addNewRole {
    NSIndexPath *index= [NSIndexPath indexPathForRow:self.hasSetArray.count - 1 inSection:0];
    RoleListModel *model = self.hasSetArray[index.row];
    model.roleName = @"请选择";
    [self.hasSetArray replaceObjectAtIndex:index.row withObject:model];
    [self.roleSetArray replaceObjectAtIndex:index.row withObject:model];
    
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
