//
//  InvitedRecordViewController.m
//  HQJBusiness
//  邀请 —— 消费   记录控制器
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "InvitedRecordViewController.h"
#import "InvitedRecordTableViewCell.h"
#import "RecordsConsumptionCell.h"
#import "InvitedRecordModel.h"
#import "MemberStaffModel.h"
#import "StaffDetailsViewModel.h"
@interface InvitedRecordViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *invitedRecordTableView;
@property (nonatomic, assign) listStyle style;
@property (nonatomic, strong) MemberStaffModel *model;
@property (nonatomic, strong) NSArray <InvitedRecordModel *>*modelAry;

@end

@implementation InvitedRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.invitedRecordTableView];
    if (self.style == stafflistStyle) {
        [self requstInvitedRecord];

    } else {
        
    }
}
- (instancetype)initRecordWithStyle:(listStyle)style
                        detaliModel:(MemberStaffModel *)model{
    self = [super init];
    if (self) {
        self.style = style;
        self.model = model;
    }
    return self;
}

- (void)requstInvitedRecord {
    [StaffDetailsViewModel getInvitedRecordListWithStaffID:self.model.nid completion:^(NSArray<InvitedRecordModel *> * _Nonnull ary) {
         self.modelAry = ary;
        [self.invitedRecordTableView.mj_header endRefreshing];
         [self.invitedRecordTableView reloadData];
    } error:^(NSError * _Nonnull err) {
        [self.invitedRecordTableView.mj_header endRefreshing];
        if (err.code == 490) {
            [SVProgressHUD showErrorWithStatus:err.userInfo[@"msg"]];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.modelAry.count;
 
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.style == stafflistStyle) {
           InvitedRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([InvitedRecordTableViewCell class]) forIndexPath:indexPath];
        cell.model = self.modelAry[indexPath.row];
        return cell;
    } else {
           RecordsConsumptionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecordsConsumptionCell class]) forIndexPath:indexPath];
        //    cell.textLabel.text = self.modelArray[indexPath.row];
            return cell;
    }
 
}

- (UITableView *)invitedRecordTableView {
    if (!_invitedRecordTableView) {
        _invitedRecordTableView = [[UITableView alloc]init];
        _invitedRecordTableView.frame = CGRectMake(0, 45, self.view.mj_w, self.view.mj_h - NavigationControllerHeight - NewProportion(710) - 45);
        _invitedRecordTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _invitedRecordTableView.delegate = self;
        _invitedRecordTableView.dataSource = self;
        _invitedRecordTableView.rowHeight = NewProportion(214);
        [_invitedRecordTableView registerClass:[InvitedRecordTableViewCell class] forCellReuseIdentifier:NSStringFromClass([InvitedRecordTableViewCell class])];
        [_invitedRecordTableView registerClass:[RecordsConsumptionCell class] forCellReuseIdentifier:NSStringFromClass([RecordsConsumptionCell class])];

        _invitedRecordTableView.tableFooterView = [UIView new];
        @weakify(self);
        _invitedRecordTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                 @strongify(self);
                [self requstInvitedRecord];

                 
                 
             }];
    }
    return _invitedRecordTableView;
}

@end
