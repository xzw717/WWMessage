//
//  AddStaffViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddStaffViewController.h"
#import "AddStaffTableViewCell.h"
#import "UITextField+IndexPath.h"
#import "SelectMenuView.h"
#import "RoleSelectVIew.h"
@interface AddStaffViewController ()<UITableViewDelegate,UITableViewDataSource,RoleDelegate>
@property (nonatomic, strong) UITableView *addStaffTableView;
@property (nonatomic, strong) NSArray *titleAry;
@property (nonatomic, strong) NSMutableArray <NSString *>*dataSouceAry;
@property (nonatomic, strong) UITextField *numberTextField;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) RoleSelectVIew *roleButton;

@end

@implementation AddStaffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"添加员工";
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

}
- (void)textFieldDidChanged:(NSNotification *)noti{
    UITextField *textField=noti.object;
    NSIndexPath *indexPath = textField.indexPath;
    [self.dataSouceAry replaceObjectAtIndex:indexPath.row withObject:textField.text];
    [self changeSaveButtonState];
    
}
- (void)SelectRole:(UIButton *)btn {
    @weakify(self);
    [[SelectMenuView showMenuWithView:btn].munuAry(@[@"角色一",@"角色二",@"角色三",@"角色一"]) setClickTitle:^(NSString * _Nonnull str) {
        @strongify(self);
        [btn setTitle:str forState:UIControlStateNormal];
//        self.roleButton = btn;
        [self.dataSouceAry replaceObjectAtIndex:3 withObject:str];
        [self changeSaveButtonState];
    }];
}
- (void)changeSaveButtonState {
    BOOL saveState =  ![self.dataSouceAry[0] isEqualToString:@""] && ![self.dataSouceAry[1] isEqualToString:@""] &&![self.dataSouceAry[2] isEqualToString:@""] && self.roleButton && ![self.roleButton.roleTitleString isEqualToString:@"请选择角色"];
    self.saveButton.enabled = saveState;
    self.saveButton.backgroundColor = saveState ? DefaultAPPColor : [ManagerEngine getColor:@"b9b9b9"];
}
- (void)clickRoleView:(RoleSelectVIew *)view {
    @weakify(self);
     [[SelectMenuView showMenuWithView:view].munuAry(@[@"角色一",@"角色二",@"角色三",@"角色一"]) setClickTitle:^(NSString * _Nonnull str) {
         @strongify(self);
         view.roleTitleString = str;
         self.roleButton = view;
         [self.dataSouceAry replaceObjectAtIndex:3 withObject:str];
         [self changeSaveButtonState];
     }];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setSignal {
    RACSignal *numberSignal = [self.numberTextField.rac_textSignal map:^id(NSString *value) {
        return @(value.length > 0);
    }];
    RACSignal *nameSignal = [self.nameTextField.rac_textSignal map:^id(NSString *value) {
           return @(value.length > 0);
       }];
    RACSignal *phoneSignal = [self.phoneTextField.rac_textSignal map:^id(NSString *value) {
           return @(value.length > 0);
       }];
    RACSignal *mergesignal = [RACSignal combineLatest:@[numberSignal,nameSignal,phoneSignal] reduce:^id(NSNumber *number,NSNumber *name,NSNumber *phone){
        return @([number boolValue] & [name boolValue] & [phone boolValue]);
    }];
    @weakify(self);
    [mergesignal subscribeNext:^(NSNumber *combined) {
        @strongify(self);
        self.saveButton.enabled = [combined boolValue];
        self.saveButton.backgroundColor = [combined boolValue] ? DefaultAPPColor : [ManagerEngine getColor:@"b9b9b9"];
    }];
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return  self.titleAry.count;
 
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddStaffTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddStaffTableViewCell class]) forIndexPath:indexPath];
    cell.title = self.titleAry[indexPath.row];
    cell.cellIndexPath = indexPath;
//    [cell.selectButton addTarget:self action:@selector(SelectRole:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectButton.delegate = self;
    
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
    }
    return _saveButton;
}
- (NSMutableArray *)dataSouceAry {
    if (!_dataSouceAry) {
        _dataSouceAry = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@""]];
    }
    return _dataSouceAry;
}
@end
