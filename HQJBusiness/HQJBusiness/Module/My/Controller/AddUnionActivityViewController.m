//
//  AddUnionActivityViewController.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/1/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddUnionActivityViewController.h"
#import "AddUnionActivityViewModel.h"
#import "AddUnionSectionView.h"
#import "AddUnionActivityCell.h"
#import "AddUnionImageCell.h"
#import "AddUnionTimerCell.h"
#import "AddUnionSelectCell.h"
#import "AddUnionSubCell.h"
#import "AddUnionTextViewCell.h"
#import "pickerView.h"
#import "ShowMobileView.h"
#import "AddUnionModel.h"
#define TableViewCellHeight 50.f
#define HeadHeight  132/3.f
#define TableViewTopSpace 40/3.f
@interface AddUnionActivityViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *tempIdArray;
@property (nonatomic, strong) NSMutableArray *tempDataArray;
@property (nonatomic, strong) AddUnionModel *model;
@property (nonatomic, strong) pickerView *pickView;
@property (nonatomic, strong) ShowMobileView *mobileView;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation AddUnionActivityViewController

- (NSMutableArray *)tempIdArray{
    if (_tempIdArray == nil) {
        _tempIdArray = [[NSMutableArray alloc]initWithObjects:@"-1", nil];
    }
    return _tempIdArray;
}
- (NSMutableArray *)tempDataArray{
    if (_tempDataArray == nil) {
        _tempDataArray = [[NSMutableArray alloc]initWithObjects:@"不限", nil];
    }
    return _tempDataArray;
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
        [_tableView registerClass:[AddUnionImageCell class] forCellReuseIdentifier:NSStringFromClass([AddUnionImageCell class])];
        [_tableView registerClass:[AddUnionTimerCell class] forCellReuseIdentifier:NSStringFromClass([AddUnionTimerCell class])];
        [_tableView registerClass:[AddUnionSelectCell class] forCellReuseIdentifier:NSStringFromClass([AddUnionSelectCell class])];
        [_tableView registerClass:[AddUnionSubCell class] forCellReuseIdentifier:NSStringFromClass([AddUnionSubCell class])];
        [_tableView registerClass:[AddUnionTextViewCell class] forCellReuseIdentifier:NSStringFromClass([AddUnionTextViewCell class])];
        
        
    }
    
    return _tableView;
}
- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
        UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(10, 10, WIDTH - 20, 40);
        addButton.backgroundColor = DefaultAPPColor;
        addButton.layer.masksToBounds = YES;
        addButton.layer.cornerRadius = 5;
        [addButton setTitle:@"确认添加" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:addButton];
    }
    return _bottomView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"创建联盟活动";
    [self.view addSubview:self.tableView];
    [self initData];
    // Do any additional setup after loading the view.
}
- (void)initData{
    self.model = [[AddUnionModel alloc]init];
    
    self.model.rule = [NSString stringWithFormat:@"默认规则：\n1、本规则对参与所有商家同等有效；\n2、联盟活动成立，联盟活动券生效；\n3、联盟活动券使用规则见券面信息；\n4、联盟券不可叠加使用；\n5、活动有效期%@ - %@\n6、本活动最终解释权归活动创建方所有，如有疑问请致电%@。",[ManagerEngine getTrueField:self.model.start],[ManagerEngine getTrueField:self.model.end],Mmobile];
    self.dataArray = [AddUnionActivityViewModel getDataArray];
    /*
     0:AddUnionActivityCell
     1:AddUnionTimerCell
     2:AddUnionSelectCell
     3:AddUnionImageCell
     4:AddUnionSubCell
     5:AddUnionTextViewCell
     **/
    [self.tableView reloadData];
}
- (void)showMobileView:(NSString *)key{
    self.mobileView = [[ShowMobileView alloc]initWithFrame:CGRectMake(30, HEIGHT*0.2, WIDTH - 60 , HEIGHT*0.6)];
    [self.mobileView show];
    @weakify(self);
    self.mobileView.sureButtonBlock = ^(NSString * _Nonnull mobile, NSString * _Nonnull memberid) {
        @strongify(self);
        [self updateModel:key andValue:mobile andIsMuti:YES];
        [self updateModel:@"mobile" andValue:mobile andIsMuti:YES];
        [self updateModel:[NSString stringWithFormat:@"%@Id",key] andValue:memberid andIsMuti:YES];
        [self.tableView reloadData];
    };
}
- (void)removeTempArray{
    [self.tempIdArray removeAllObjects];
    [self.tempDataArray removeAllObjects];
    [self.tempIdArray addObject:@"-1"];
    [self.tempDataArray addObject:@"不限"];
}
- (void)addButtonClicked{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认发布？" message:self.zw_title preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @weakify(self);
        [AddUnionActivityViewModel addUnionActivity:self.model andActivityId:@"" completion:^(NSDictionary * _Nonnull dic) {
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
- (void)updateModel:(NSString *)key andValue:(NSString *)value andIsMuti:(BOOL)isMuti{
    if (isMuti) {
        if ([self.model valueForKey:key]) {
            NSMutableArray *sepArray = [NSMutableArray arrayWithArray:[[self.model valueForKey:key] componentsSeparatedByString:@","]];
            NSMutableString *tempValue = [NSMutableString string];
            if ([sepArray containsObject:value]) {
                [sepArray removeObject:value];
                if (sepArray.count>0) {
                    for (NSString *str in sepArray) {
                        [tempValue appendString:[NSString stringWithFormat:@"%@,",str]];
                    }
                    [tempValue deleteCharactersInRange:NSMakeRange(tempValue.length-1, 1)];
                    [self.model setValue:tempValue forKey:key];
                }else{
                    [self.model setValue:nil forKey:key];
                }
                
            }else{
                [tempValue appendString:[self.model valueForKey:key]];
                [tempValue appendString:[NSString stringWithFormat:@",%@",value]];
                [self.model setValue:tempValue forKey:key];
            }
        }else{
            [self.model setValue:value forKey:key];
        }
    }else{
        [self.model setValue:value forKey:key];
    }
    
}

#pragma mark --- UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * sectionArray = self.dataArray[section];
    if (section == 1||section == 2||section == 3||section == 4) {
        NSString *key = [sectionArray lastObject];
        NSString *value = [self.model valueForKey:key];
        if (value) {
            if ([value containsString:@","]) {
                NSArray *sepArray = [value componentsSeparatedByString:@","];
                return sepArray.count;
            }else{
                return 1;
            }
            
        }else{
            return 0;
        }
        
    }
    return sectionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1||section == 2||section == 3||section == 4) {
        return 50;
    }
    return TableViewTopSpace;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1||section == 2||section == 3||section == 4) {
        NSArray * sectionArray = self.dataArray[section];
        AddUnionSectionView *view = [[AddUnionSectionView alloc]init];
        view.dataArray = sectionArray;
        @weakify(self);
        view.addButtonBlock = ^{
            @strongify(self);
            [self removeTempArray];
            NSString *urlStr,*tempKey;
            switch (section) {
                case 1:
                    urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetAreaInterface];
                    tempKey = @"pname";
                    break;
                case 2:
                    urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetMerchantTypeInterface];
                    tempKey = @"value";
                    break;
                case 3:
                    [self showMobileView:[sectionArray lastObject]];
                    break;
                case 4:
                    urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetIndustryInterface];
                    tempKey = @"name";
                    break;
                    
                default:
                    break;
            }
            if (section != 3) {
                @weakify(self);
                [AddUnionActivityViewModel getTempData:urlStr completion:^(NSDictionary * _Nonnull dic) {
                    NSArray *resultAry = dic[@"result"];
                    for (NSDictionary *temoDict in resultAry) {
                        [self.tempIdArray addObject:[NSString stringWithFormat:@"%@",temoDict[@"id"]]];
                        [self.tempDataArray addObject:[NSString stringWithFormat:@"%@",temoDict[tempKey]]];
                    }
                    self.pickView = [[pickerView alloc]initWithFrame:CGRectMake(30, HEIGHT*0.2, WIDTH - 60 , HEIGHT*0.6) andTitleAry:self.tempDataArray];
                    self.pickView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
                    [self.pickView showView];
                    [self.pickView setSenderBlock:^(id sender) {
                        @strongify(self);
                        [self updateModel:[sectionArray lastObject] andValue:self.tempDataArray[[sender integerValue]] andIsMuti:YES];
                        [self updateModel:[NSString stringWithFormat:@"%@Id",[sectionArray lastObject]] andValue:self.tempIdArray[[sender integerValue]] andIsMuti:YES];
                        [self.tableView reloadData];
                    }];
                }];
                
            }
            
        };
        return view;
    }else{
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 5) {
        if (indexPath.row == 0||indexPath.row == 1) {
            return 100;
        }
    }
    if (indexPath.section == 7) {
        return 150;
    }
    return TableViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1||indexPath.section == 2||indexPath.section == 3||indexPath.section == 4) {
        NSArray *sectionArray = self.dataArray[indexPath.section];
        NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        AddUnionSubCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[AddUnionSubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        NSString *key = [sectionArray lastObject];
        NSString *value = [self.model valueForKey:key];
        if (value) {
            NSString *tempValue;
            if ([value containsString:@","]) {
                NSArray *sepArray = [value componentsSeparatedByString:@","];
                tempValue = sepArray[indexPath.row];
                cell.nameLabel.text = sepArray[indexPath.row];
            }else{
                tempValue = value;
                cell.nameLabel.text = value;
                
            }
            @weakify(self);
            cell.minusButtonBlock = ^{
                @strongify(self);
                [self updateModel:key andValue:tempValue andIsMuti:YES];
                [self.tableView reloadData];
            };
        }
        
        return cell;
    }else{
        
        NSArray *sectionArray = self.dataArray[indexPath.section][indexPath.row];
        /*
         0:AddUnionActivityCell
         1:AddUnionTimerCell
         2:AddUnionSelectCell
         3:AddUnionImageCell
         4:AddUnionSubCell
         5:AddUnionTextViewCell
         **/
        switch ([sectionArray[0] integerValue]) {
            case 0:{
                NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
                AddUnionActivityCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                
                if (cell == nil) {
                    cell = [[AddUnionActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                cell.model = self.model;
                cell.dataArray = sectionArray;
                if (indexPath.section == 6&&indexPath.row == 1) {
                    cell.textField.userInteractionEnabled = NO;
                }else{
                    cell.textField.userInteractionEnabled = YES;
                    @weakify(self);
                    cell.textFieldResult = ^(NSString * _Nonnull value) {
                        @strongify(self);
                        NSLog(@"value = %@",value);
                        [self updateModel:[sectionArray lastObject] andValue:value andIsMuti:NO];
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
                    [self updateModel:[sectionArray lastObject] andValue:value andIsMuti:NO];
                    if ([[sectionArray lastObject] isEqualToString:@"start"]||[[sectionArray lastObject] isEqualToString:@"end"]) {
                        self.model.rule = [NSString stringWithFormat:@"默认规则：\n1、本规则对参与所有商家同等有效；\n2、联盟活动成立，联盟活动券生效；\n3、联盟活动券使用规则见券面信息；\n4、联盟券不可叠加使用；\n5、活动有效期%@ - %@\n6、本活动最终解释权归活动创建方所有，如有疑问请致电%@。",[ManagerEngine getTrueField:self.model.start],[ManagerEngine getTrueField:self.model.end],Mmobile];
                        [self.tableView reloadData];
                    }
                };
                
                return cell;
            }
                break;
            case 2:{
                NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
                AddUnionSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                if (!cell) {
                    cell = [[AddUnionSelectCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                }
                cell.model = self.model;
                cell.dataArray = sectionArray;
                @weakify(self);
                cell.clickBlock = ^(NSString * _Nonnull value) {
                    @strongify(self);
                    NSLog(@"value = %@",value);
                    
                    if ([[sectionArray lastObject] isEqualToString:@"isHost"]) {
                        [self updateModel:[sectionArray lastObject] andValue:value andIsMuti:NO];
                        [self updateModel:[NSString stringWithFormat:@"%@Id",[sectionArray lastObject]] andValue:[value isEqualToString:@"发起人"]?@"0":@"1" andIsMuti:NO];
                        [self.tableView reloadData];
                    }else{
                        [self updateModel:[sectionArray lastObject] andValue:value andIsMuti:YES];
//                        if ([[sectionArray lastObject] isEqualToString:@"pushSettings"]) {
//                            [self updateModel:[NSString stringWithFormat:@"%@Id",[sectionArray lastObject]] andValue:[value isEqualToString:@"消费后"]?@"0":@"1" andIsMuti:YES];
//                        }
                    }
                };
                return cell;
            }
                break;
            case 3:{
                NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
                AddUnionImageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                if (cell == nil) {
                    cell = [[AddUnionImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                if ([self.model valueForKey:[sectionArray lastObject]]) {
                    NSURL *url = [NSURL URLWithString:[self.model valueForKey:[sectionArray lastObject]]];
                    [cell.contentImageView sd_setImageWithURL:url];
                }
                cell.uploadResultBlock = ^(id  _Nonnull dict) {
                    if ([dict[@"code"]integerValue] == 49000) {
                        NSLog(@"上传成功");
                        [self updateModel:[sectionArray lastObject] andValue:dict[@"result"] andIsMuti:NO];
                        [self.tableView reloadData];
                    } else {
                        NSLog(@"msg = %@",dict[@"msg"]);
                        [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
                    }
                };
                
                return cell;
            }
            case 5:{
                NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,indexPath.row];
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
                    [self updateModel:[sectionArray lastObject] andValue:value andIsMuti:NO];
                };

                return cell;
            }
                break;
            default:
                return nil;
                break;
        }
    }
    
    
    
}
#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 6) {
        if (indexPath.row == 1) {
            NSArray *sectionArray = self.dataArray[indexPath.section][indexPath.row];
            if (self.model.couponType) {
                NSMutableArray *sepArray = [NSMutableArray arrayWithArray:[self.model.couponType componentsSeparatedByString:@","]];
                self.pickView = [[pickerView alloc]initWithFrame:CGRectMake(30, HEIGHT*0.2, WIDTH - 60 , HEIGHT*0.6) andTitleAry:sepArray];
                self.pickView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
                [self.pickView showView];
                @weakify(self);
                [self.pickView setSenderBlock:^(id sender) {
                    @strongify(self);
                    [self updateModel:[sectionArray lastObject] andValue:sepArray[[sender integerValue]] andIsMuti:NO];
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
