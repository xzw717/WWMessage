//
//  InvitedRecordViewController.m
//  HQJBusiness
//  邀请 —— 消费   记录控制器
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "InvitedRecordViewController.h"
#import "InvitedRecordTableViewCell.h"

@interface InvitedRecordViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *invitedRecordTableView;
@property (nonatomic, assign) listStyle style;

@end

@implementation InvitedRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.invitedRecordTableView];
    
}
- (instancetype)initRecordWithStyle:(listStyle)style {
    self = [super init];
    if (self) {
        _style = style;
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  10;
 
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    InvitedRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([InvitedRecordTableViewCell class]) forIndexPath:indexPath];
//    cell.textLabel.text = self.modelArray[indexPath.row];
    return cell;
   
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
        _invitedRecordTableView.tableFooterView = [UIView new];
        
    }
    return _invitedRecordTableView;
}

@end
