//
//  AddStaffViewController.m
//  HQJBusiness
//    添加员工和编辑员工通用界面
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddStaffViewController.h"
#import "AddStaffTableViewCell.h"
#import "UITextField+IndexPath.h"
#import "SelectMenuView.h"
#import "RoleSelectView.h"
#import "AddStaffViewModel.h"
#import "RoleListModel.h"
#import "MemberStaffModel.h"
#import "SelectTimeView.h"

@interface AddStaffViewController ()<UITableViewDelegate,UITableViewDataSource,RoleDelegate>
@property (nonatomic, strong) UITableView *addStaffTableView;
@property (nonatomic, strong) NSArray *titleAry;
@property (nonatomic, strong) NSMutableArray <NSString *>*dataSouceAry;
@property (nonatomic, strong) UITextField *numberTextField;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) RoleSelectView *roleButton;
@property (nonatomic, assign) BOOL isClear;
@property (nonatomic, strong) MemberStaffModel *staffModel;
@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation AddStaffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zw_title = !self.staffModel ? @"添加员工" : @"编辑员工";
    self.titleAry = @[@"员工编号",@"员工姓名",@"手机号码",@"员工角色",@"入职时间"];
    [self.view addSubview:self.addStaffTableView];
    [self.view addSubview:self.saveButton];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(50));
        make.right.mas_equalTo(-NewProportion(50));
        make.top.mas_equalTo(self.addStaffTableView.mas_bottom).mas_offset(NewProportion(100));
        make.height.mas_equalTo(NewProportion(130));
    }];
    self.numberTextField = [[UITextField alloc]init];
    self.nameTextField = [[UITextField alloc]init];
    self.phoneTextField = [[UITextField alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:)name:UITextFieldTextDidChangeNotification object:nil];
    [self.dataSouceAry replaceObjectAtIndex:4 withObject:[ManagerEngine currentDateStr]];

    
    
}
- (instancetype)initWithStaffModel:(MemberStaffModel *)model{
    self = [super init];
    if (self) {
        self.staffModel = model;
    }
    return self;
}



- (void)textFieldDidChanged:(NSNotification *)noti{
    UITextField *textField=noti.object;
    NSIndexPath *indexPath = textField.indexPath;
    [self.dataSouceAry replaceObjectAtIndex:indexPath.row withObject:textField.text];
    [self changeSaveButtonState];
    
}
- (void)SelectRole:(UIButton *)btn {
    @weakify(self);
    [AddStaffViewModel getTitlesWithCompletion:^(NSArray<RoleListModel *> * _Nonnull modelArray) {
        [[SelectMenuView showMenuWithView:btn].munuAry(modelArray) setClickModel:^(RoleListModel * _Nonnull model) {
            @strongify(self);
            [btn setTitle:model.roleName forState:UIControlStateNormal];
            //        self.roleButton = btn;
            [self.dataSouceAry replaceObjectAtIndex:3 withObject:model.roleName];
            [self changeSaveButtonState];
        }];
    }];
    
    
}
- (void)changeSaveButtonState {
    BOOL saveState = NO;
    if (self.staffModel) {
        saveState =  ![self.dataSouceAry[0] isEqualToString:@""] && ![self.dataSouceAry[1] isEqualToString:@""] &&![self.dataSouceAry[2] isEqualToString:@""];
    } else {
        saveState =  ![self.dataSouceAry[0] isEqualToString:@""] && ![self.dataSouceAry[1] isEqualToString:@""] &&![self.dataSouceAry[2] isEqualToString:@""] && self.roleButton && ![self.roleButton.roleTitleString isEqualToString:@"请选择角色"];
    }
    self.saveButton.enabled = saveState;
    self.saveButton.backgroundColor = saveState ? DefaultAPPColor : [ManagerEngine getColor:@"b9b9b9"];
}
- (void)clickRoleView:(RoleSelectView *)view {
    @weakify(self);
    [AddStaffViewModel getTitlesWithCompletion:^(NSArray<RoleListModel *> * _Nonnull modelArray) {
        [[SelectMenuView showMenuWithView:view].munuAry(modelArray) setClickModel:^(RoleListModel * _Nonnull model) {
            @strongify(self);
            if (model) {
                view.roleTitleString = model.roleName;
                self.roleButton = view;
                [self.dataSouceAry replaceObjectAtIndex:3 withObject:model.nid];
                [self changeSaveButtonState];
            }
            
        }];
    }];
    
}
- (void)addStaffAction {
    NSDictionary *dict = @{@"sid":MmberidStr,
                           @"nickname":self.dataSouceAry[1],
                           @"mobile":self.dataSouceAry[2],
                           @"title":@"1", /// 许峰说随便填
                           @"gender":@"1",
                           @"age":@"1",
                           @"account":@"1",/// 许峰说随便填
                           @"empNo":self.dataSouceAry[0],
                           @"entryTime":[ManagerEngine getTimeStrWithString:self.dataSouceAry[4] timeType:@"YYYY-MM-dd"],
                           @"role":@([self.dataSouceAry[3] integerValue])};
    @weakify(self);
    [AddStaffViewModel addStaff:dict completion:^{
        @strongify(self);
        self.dataSouceAry = nil;
        self.isClear = YES;
        [self  changeSaveButtonState];
        [self.addStaffTableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];

    }];
}

- (void)editStaffAction {
    NSDictionary *dict = @{@"id":self.staffModel.nid,
                           @"sid":MmberidStr,
                           @"nickname":self.dataSouceAry[1],
                           @"mobile":self.dataSouceAry[2],
                           @"title":@"1", /// 许峰说随便填
                           @"gender":@"1",
                           @"age":@"1",
                           @"account":@"1",/// 许峰说随便填
                           @"cid":self.staffModel.cid,
                           @"empNo":self.dataSouceAry[0],
                           @"entryTime":[ManagerEngine getTimeStrWithString:self.dataSouceAry[4] timeType:@"YYYY-MM-dd"],
                           @"role":@([self.dataSouceAry[3] integerValue])};
    @weakify(self);
    [AddStaffViewModel editStaff:dict editID:self.staffModel.nid  completion:^{
        @strongify(self);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeStaff" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.titleAry.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddStaffTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddStaffTableViewCell class]) forIndexPath:indexPath];
    cell.cellIndexPath = indexPath;
    cell.isClear = self.isClear;
    cell.title = self.titleAry[indexPath.row];
    cell.selectButton.delegate = self;
    if (self.staffModel) {
        cell.contentText = self.dataSouceAry[indexPath.row];
        
    }
    @weakify(self);
    [cell setTimeBlock:^(NSString *timer) {
        @strongify(self);
        [self.dataSouceAry replaceObjectAtIndex:4 withObject:timer];
//        [self.addStaffTableView reloadData];
    }];
    return cell;
    
}
- (UITableView *)addStaffTableView {
    if (!_addStaffTableView) {
        _addStaffTableView = [[UITableView alloc]init];
        _addStaffTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, 44 * 5);
        _addStaffTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _addStaffTableView.delegate = self;
        _addStaffTableView.dataSource = self;
        _addStaffTableView.scrollEnabled = NO;
        [_addStaffTableView registerClass:[AddStaffTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AddStaffTableViewCell class])];
        _addStaffTableView.tableFooterView = [UIView new];
        
    }
    return _addStaffTableView;
}
- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveButton setBackgroundColor:[ManagerEngine getColor:@"b9b9b9"]];
        _saveButton.layer.masksToBounds = YES;
        _saveButton.layer.cornerRadius = 5.f;
        if (self.staffModel) {
            [_saveButton addTarget:self action:@selector(editStaffAction) forControlEvents:UIControlEventTouchUpInside];
            
        } else {
            [_saveButton addTarget:self action:@selector(addStaffAction) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    return _saveButton;
}
- (NSMutableArray *)dataSouceAry {
    if (!_dataSouceAry) {
        if (!self.staffModel) {
            _dataSouceAry = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@""]];
            
        } else {
            _dataSouceAry = [NSMutableArray arrayWithArray:@[self.staffModel.empNo,self.staffModel.nickname,self.staffModel.mobile,self.staffModel.roleName,[ManagerEngine zzReverseSwitchTimer:self.staffModel.createTime dateFormat:@"YYYY-MM-dd"]]];
            
        }
    }
    return _dataSouceAry;
}
@end
