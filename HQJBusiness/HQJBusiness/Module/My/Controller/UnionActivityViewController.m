//
//  UnionActivityViewController.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/1/26.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UnionActivityViewController.h"
#import "ContactManagerHeadView.h"
#import "UnionActivityCell.h"
#import "UnionActivityViewModel.h"
#import "AddUnionActivityViewController.h"
#import "EditUnionActivityViewController.h"
#import "AddUnionCoponViewController.h"
#import "UnionActivityDetailViewController.h"
#import "UnionActivityEmptyView.h"
#import "AppDelegate.h"
#define TableViewCellHeight 300.f
#define HeadHeight  132/3.f
#define TableViewTopSpace 40/3.f
@interface UnionActivityViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, assign) NSInteger topTag;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ContactManagerHeadView *headView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@end

@implementation UnionActivityViewController
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
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
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.headView;
        [_tableView registerClass:[UnionActivityCell class] forCellReuseIdentifier:NSStringFromClass([UnionActivityCell class])];
        @weakify(self);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            self.page = 1;
            [self requsetData];
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            self.page++;
            [self requsetData];
            
        } ];
        
    }
    
    return _tableView;
}

- (ContactManagerHeadView *)headView{
    if (_headView == nil) {
        _headView = [[ContactManagerHeadView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HeadHeight) andTitleArray:@[@"全部联盟",@"我参与的",@"我发起的"] andIsBlue:YES];
        _headView.selectIndex = 0;
        @weakify(self);
        [_headView setItemBlock:^(NSInteger selectedIndex) {
            @strongify(self);
            self.topTag = selectedIndex;
            [self requsetData];
        }];
    }
    return _headView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"联盟活动";
    [self initUI];
    self.page = 1;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requsetData];
}
- (void)initUI{
    self.zwNavView.backgroundColor = DefaultAPPColor;
    self.zwTitLabel.textColor = [UIColor whiteColor];
    self.bottomLineView.hidden = YES;
    [self.zwBackButton setImage:[UIImage imageNamed:@"icon_back_arrow_white"] forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(addUnionActivity) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"icon_add_white"] forState:UIControlStateNormal];
    self.zw_rightOneButton = rightBtn;
}
- (void)requsetData{
    NSInteger type;
    if (self.topTag == 0) {
        type = 0;
    }else if (self.topTag == 1){
        type = 2;
    }else{
        type = 1;
    }
    
    [UnionActivityViewModel getUnionActivityList:MmberidStr activityCurstate:type andPage:self.page completion:^(NSArray<UnionActivityListModel *> * _Nonnull list) {
        if (1 == self.page) {
            self.dataArray = nil;
        }
        if (self.page != 1) {
            if (list.count == 0) {
                [SVProgressHUD showErrorWithStatus:@"已经是最后一页了"];
                self.page = self.page - 1;
            }
        }
        [self.dataArray addObjectsFromArray:list];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
- (void)deleteActicityById:(NSString *)activityId{
    [UnionActivityViewModel modifyCurstate:activityId completion:^(NSDictionary * _Nonnull dic) {
        if ([dic[@"code"] integerValue] == 49000) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [self requsetData];
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        }
    }];
}

- (void)addUnionActivity{
    if ([NameSingle shareInstance].peugeotid == 6) {
        AddUnionActivityViewController *vc = [[AddUnionActivityViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"XD商企专享权限\n是否申请成为XD商企？" message:self.zw_title preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            UITabBarController *tabViewController = (UITabBarController *) appDelegate.window.rootViewController;
            [tabViewController setSelectedIndex:3];
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark --- UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TableViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UnionActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UnionActivityCell class]) forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
    
}
#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UnionActivityListModel *model = self.dataArray[indexPath.row];
    if (self.topTag == 0) {
        if ([model.curstate isEqualToString:@"报名中"]) {
            if (model.isSelfHost.integerValue == 0&&model.isModify.integerValue == 0) {
                EditUnionActivityViewController *vc = [[EditUnionActivityViewController alloc]initWithActivityId:model.activityId];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                if (model.isHost.integerValue == 1&model.isModifyCoupon.integerValue == 0) {
                    AddUnionCoponViewController *vc = [[AddUnionCoponViewController alloc]initWithActivityId:model.activityId];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    if (model.isSignUp.integerValue == 0) {
                        AddUnionCoponViewController *vc = [[AddUnionCoponViewController alloc]initWithActivityId:model.activityId];
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        UnionActivityDetailViewController *vc = [[UnionActivityDetailViewController alloc]initWithModel:model];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }
                
            }
            
        }else{
            UnionActivityDetailViewController *vc = [[UnionActivityDetailViewController alloc]initWithModel:model];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (self.topTag == 1){
        if ([model.curstate isEqualToString:@"报名中"]) {
            
            if (model.isHost.integerValue == 1&model.isModifyCoupon.integerValue == 0) {
                AddUnionCoponViewController *vc = [[AddUnionCoponViewController alloc]initWithActivityId:model.activityId];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                if (model.isSignUp.integerValue == 0) {
                    AddUnionCoponViewController *vc = [[AddUnionCoponViewController alloc]initWithActivityId:model.activityId];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    UnionActivityDetailViewController *vc = [[UnionActivityDetailViewController alloc]initWithModel:model];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            
        }else{
            UnionActivityDetailViewController *vc = [[UnionActivityDetailViewController alloc]initWithModel:model];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else{
        if ([model.curstate isEqualToString:@"报名中"]&&model.isModify.integerValue == 0) {
            EditUnionActivityViewController *vc = [[EditUnionActivityViewController alloc]initWithActivityId:model.activityId];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            UnionActivityDetailViewController *vc = [[UnionActivityDetailViewController alloc]initWithModel:model];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.topTag == 2) {
        return YES;
    }
    return NO;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UnionActivityListModel *model = self.dataArray[indexPath.row];
        if ([model.curstate isEqualToString:@"报名中"]){
            [self deleteActicityById:model.activityId];
        }else{
            [SVProgressHUD showErrorWithStatus:@"活动已经不能删除!"];
        }
        
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    UnionActivityEmptyView *view = [[UnionActivityEmptyView alloc]init];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
    return view;
}

//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    [self addUnionActivity];
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
