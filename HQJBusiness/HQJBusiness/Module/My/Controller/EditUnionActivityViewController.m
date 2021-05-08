//
//  AddUnionActivityViewController.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/1/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "EditUnionActivityViewController.h"
#import "AddUnionActivityViewModel.h"
#import "AddUnionActivityCell.h"
#import "AddUnionTimerCell.h"
#import "AddUnionTextViewCell.h"
#import "pickerView.h"
#import "AddUnionModel.h"
#define TableViewCellHeight 50.f
#define HeadHeight  132/3.f
#define TableViewTopSpace 40/3.f
@interface EditUnionActivityViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) AddUnionModel *model;
@property (nonatomic, strong) NSString *activityId;
@property (nonatomic, strong) pickerView *pickView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation EditUnionActivityViewController

- (instancetype)initWithActivityId:(NSString *)activityId{
    self = [super init];
    if (self) {
        self.activityId = activityId;
        [AddUnionActivityViewModel getActivityInfoById:activityId completion:^(NSDictionary * _Nonnull dic) {
            if ([dic[@"code"] integerValue] == 49000) {
                self.model = [AddUnionModel mj_objectWithKeyValues:dic[@"result"]];
                [self.tableView reloadData];
            }else{
                self.model = [[AddUnionModel alloc]init];
                [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
            }
            
        }];
    }
    return self;
}

-(UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = self.bottomView;
        [_tableView registerClass:[AddUnionActivityCell class] forCellReuseIdentifier:NSStringFromClass([AddUnionActivityCell class])];
        [_tableView registerClass:[AddUnionTimerCell class] forCellReuseIdentifier:NSStringFromClass([AddUnionTimerCell class])];
        [_tableView registerClass:[AddUnionTextViewCell class] forCellReuseIdentifier:NSStringFromClass([AddUnionTextViewCell class])];
        
        
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
        [_addButton setTitle:@"确认修改" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_addButton];
    }
    return _bottomView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"编辑联盟活动";
    [self.view addSubview:self.tableView];
    [self initData];
    // Do any additional setup after loading the view.
}
- (void)initData{
    self.dataArray = [AddUnionActivityViewModel getEditDataArray];
    [self.tableView reloadData];
}

- (void)addButtonClicked{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认修改？" message:self.zw_title preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @weakify(self);
        [AddUnionActivityViewModel addUnionActivity:self.model andActivityId:self.activityId  completion:^(NSDictionary * _Nonnull dic) {
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
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)updateModel:(NSString *)key andValue:(NSString *)value{
    
    [self.model setValue:value forKey:key];
    
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
    if (indexPath.section == 2) {
        return 150;
    }
    return TableViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *sectionArray = self.dataArray[indexPath.section][indexPath.row];
    
    switch ([sectionArray[0] integerValue]) {
        case 0:{
            NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
            AddUnionActivityCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[AddUnionActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.model = self.model;
            cell.dataArray = sectionArray;
            if (indexPath.section == 1&&indexPath.row == 0) {
                cell.textField.userInteractionEnabled = NO;
            }else{
                cell.textField.userInteractionEnabled = YES;
                @weakify(self);
                cell.textFieldResult = ^(NSString * _Nonnull value) {
                    @strongify(self);
                    NSLog(@"value = %@",value);
                    [self updateModel:[sectionArray lastObject] andValue:value];
                };
            }
            
            return cell;
        }
            break;
        case 1:{
            NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
            AddUnionTimerCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (cell == nil) {
                cell = [[AddUnionTimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.model = self.model;
            cell.dataArray = sectionArray;
            @weakify(self);
            cell.timerResult = ^(NSString * _Nonnull value) {
                @strongify(self);
                NSLog(@"value = %@",value);
                [self updateModel:[sectionArray lastObject] andValue:value];
            };
            
            return cell;
        }
            break;
        case 5:{
            NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
            AddUnionTextViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (cell == nil) {
                cell = [[AddUnionTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.model = self.model;
            cell.dataArray = sectionArray;
            @weakify(self);
            cell.textFieldResult = ^(NSString * _Nonnull value) {
                @strongify(self);
                NSLog(@"value = %@",value);
                [self updateModel:[sectionArray lastObject] andValue:value];
            };
            
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
    
    
    
}
#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSArray *sectionArray = self.dataArray[indexPath.section][indexPath.row];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
