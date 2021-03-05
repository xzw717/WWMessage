//
//  UnionActivityViewController.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/1/26.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddUnionCoponViewController.h"
#import "AddUnionCoponViewModel.h"
#import "AddUnionActivityCell.h"
#import "AddUnionTimerCell.h"
#import "pickerView.h"
#define TableViewCellHeight 50.f
#define TableViewTopSpace 40/3.f
#import "AddUnionModel.h"
@interface AddUnionCoponViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) NSString *activityId;
@property (nonatomic, strong) AddUnionModel *model;
@property (nonatomic, strong) pickerView *pickView;
@end

@implementation AddUnionCoponViewController
- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = @[@[@[@"0",@"联盟券类型：",@"选择联盟券类型",@"typeName"],@[@"0",@"联盟券名称：",@" 请输入优惠券名称",@"couponName"],@[@"0",@"联盟券面额：",@"1 - 500",@"reducePrice"],@[@"0",@"使用条件：",@"最低订单金额",@"minPrice"],@[@"0",@"发行数量：",@"1 - 10000",@"count"],@[@"0",@"每人限领：",@"1 （默认一张，可修改）",@"receiveNumber"]],@[@[@"1",@"开始时间：",@"选择开始时间",@"startTime"],@[@"1",@"结束时间：",@"选择结束时间",@"endTime"]]];
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
        _tableView.tableFooterView = self.bottomView;
        [_tableView registerClass:[AddUnionTimerCell class] forCellReuseIdentifier:NSStringFromClass([AddUnionTimerCell class])];
        [_tableView registerClass:[AddUnionActivityCell class] forCellReuseIdentifier:NSStringFromClass([AddUnionActivityCell class])];
        
        
    }
    
    return _tableView;
}
- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(10, 10, WIDTH - 20, 40);
        _addButton.layer.masksToBounds = YES;
        _addButton.layer.cornerRadius = 5;
        _addButton.backgroundColor = DefaultAPPColor;
        [_addButton setTitle:@"确认添加" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_addButton];
    }
    return _bottomView;
    
}
- (instancetype)initWithActivityId:(NSString *)activityId{
    self = [super init];
    if (self) {
        self.activityId = activityId;
        [AddUnionCoponViewModel getUnionCouponById:activityId completion:^(NSDictionary * _Nonnull dic) {
            if ([dic[@"code"] integerValue] == 49000) {
                self.model = [AddUnionModel mj_objectWithKeyValues:dic[@"result"][@"coupon"]];
                
                if (self.model.isHost.integerValue == 0) {
                    self.zw_title =  self.model.activityName;
                    [self.addButton setTitle:@"确认加入" forState:UIControlStateNormal];
                }else{
                    self.zw_title = self.model.couponId.integerValue == 0 ? @"添加联盟券":@"修改联盟券";
                    [self.addButton setTitle:self.model.couponId.integerValue == 0 ? @"确认添加":@"确认修改" forState:UIControlStateNormal];
                }
                
                [self.tableView reloadData];
            }else{
                self.model = [[AddUnionModel alloc]init];
                [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
            }
            
        }];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    
    // Do any additional setup after loading the view.
}
- (void)initUI{
    self.zwNavView.backgroundColor = DefaultAPPColor;
    self.zwTitLabel.textColor = [UIColor whiteColor];
    self.bottomLineView.hidden = YES;
    [self.zwBackButton setImage:[UIImage imageNamed:@"icon_back_arrow_white"] forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"icon_explain"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(explainClicked) forControlEvents:UIControlEventTouchUpInside];
    self.zw_rightOneButton = rightBtn;
}
- (void)updateModel:(NSString *)key andValue:(NSString *)value{
    [self.model setValue:value forKey:key];
}
- (void)addButtonClicked{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认操作\n是否同意联盟规则？？" message:self.zw_title preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"同意并确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.model.isHost.integerValue == 0) {
            @weakify(self);
            [AddUnionCoponViewModel signUp:self.activityId completion:^(NSDictionary * _Nonnull dic) {
                if ([dic[@"code"] integerValue] == 49000) {
                    [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
                    [ManagerEngine SVPAfter:dic[@"msg"] complete:^{
                        @strongify(self);
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }else{
                    [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
                }
            }];
        }else{
            @weakify(self);
            [AddUnionCoponViewModel addUnionCopon:self.model andActivityId:self.activityId completion:^(NSDictionary * _Nonnull dic) {
                if ([dic[@"code"] integerValue] == 49000) {
                    [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
                    [ManagerEngine SVPAfter:dic[@"msg"] complete:^{
                        @strongify(self);
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }else{
                    [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
                }
            }];
        }
        
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)explainClicked{
    
}
#pragma mark --- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * sectionArray = self.dataArray[section];
    return sectionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TableViewTopSpace;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionArray = self.dataArray[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        AddUnionActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddUnionActivityCell class]) forIndexPath:indexPath];
        cell.model = self.model;
        cell.dataArray = sectionArray;
        if (indexPath.row != 0&&self.model.isHost.integerValue == 1) {
            cell.textField.userInteractionEnabled = YES;
        }else{
            cell.textField.userInteractionEnabled = NO;
        }
        @weakify(self);
        cell.textFieldResult = ^(NSString * _Nonnull value) {
            @strongify(self);
            NSLog(@"value = %@",value);
            [self updateModel:[sectionArray lastObject] andValue:value];
        };
        return cell;
    }else{
        AddUnionTimerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddUnionTimerCell class]) forIndexPath:indexPath];
        cell.model = self.model;
        cell.dataArray = sectionArray;
        if (indexPath.row == 1&&self.model.isHost.integerValue == 1) {
            cell.textField.userInteractionEnabled = YES;
        }else{
            cell.textField.userInteractionEnabled = NO;
        }
        @weakify(self);
        cell.timerResult = ^(NSString * _Nonnull value) {
            @strongify(self);
            NSLog(@"value = %@",value);
            [self updateModel:[sectionArray lastObject] andValue:value];
        };
        
        return cell;
    }
    
    
}
#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionArray = self.dataArray[indexPath.section][indexPath.row];
    if (self.model.isHost.integerValue == 1) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                if (self.model.text) {
                    NSMutableArray *sepArray = [NSMutableArray arrayWithArray:[self.model.text componentsSeparatedByString:@","]];
                    self.pickView = [[pickerView alloc]initWithFrame:CGRectMake(30, HEIGHT*0.2, WIDTH - 60 , HEIGHT*0.6) andTitleAry:sepArray];
                    self.pickView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
                    [self.pickView showView];
                    @weakify(self);
                    [self.pickView setSenderBlock:^(id sender) {
                        @strongify(self);
                        [self updateModel:[sectionArray lastObject] andValue:sepArray[[sender integerValue]]];
                        [self.tableView reloadData];
                    }];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"您还未选择优惠券类型"];
                    
                }
            }
        }
    }
    
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
