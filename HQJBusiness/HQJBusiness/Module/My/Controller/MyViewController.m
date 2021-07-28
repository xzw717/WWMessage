//
//  MyViewController.m
//  HQJBusiness
//   我的
//  Created by mymac on 2016/12/9.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MyViewController.h"
#import "MyTableViewCell.h"
#import "ShopModel.h"
#import "MyHeaderView.h"
#import "ShopViewModel.h"
#import "MyModel.h"
#import "MyViewModel.h"
#import "HQJWebViewController.h"
#import "HintView.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceAry;
@property (nonatomic, strong) MyHeaderView *my_headerView;
@property (nonatomic, strong) MyModel *model;
@property (nonatomic, strong) MyViewModel *my_viewModel;
@property (nonatomic, strong) ShopViewModel *sp_viewModel;
/// 失败原因 
@property (nonatomic, strong) NSString *reason;
/// 合同地址
@property (nonatomic, strong) NSString *signUrl;
@property (nonatomic, assign) NSInteger rolecheckstate;


@end

@implementation MyViewController
-(UITableView *)myTableView {
    if ( _myTableView == nil ) {
        _myTableView = [[UITableView alloc]init];
        _myTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT- NavigationControllerHeight - ToolBarHeight);
        _myTableView.backgroundColor = DefaultBackgroundColor;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight = 44.f;
        [_myTableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MyTableViewCell class])];
        
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
//        footerView.backgroundColor = DefaultBackgroundColor;
        
        _myTableView.tableFooterView = [UIView new];
        _myTableView.tableHeaderView = self.my_headerView;
        
//
//        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//
//
//        }];
        
//        _myTableView.mj_header = header;
//        header.lastUpdatedTimeLabel.hidden = YES;
        
    }
    
    return _myTableView;
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *ary = self.dataSourceAry[section];
    return ary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.my_model = self.dataSourceAry[indexPath.section][indexPath.row];
    //        [cell setModel:_model];
    if ([Peugeotid integerValue] == 6) {
        //            cell.cellReward = self.reward;
    }
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopModel *model = self.dataSourceAry[indexPath.section][indexPath.row];
    if ([model.sp_title isEqualToString:@"联系客服"]) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",model.sp_subTitle]];
        [[UIApplication sharedApplication] openURL:url];
    } else if ([model.sp_title isEqualToString:@"激活店铺"])  {
        if (self.rolecheckstate == 9999) {
            HQJWebViewController *webVC = [[HQJWebViewController alloc]init];
            webVC.webUrlStr = self.signUrl;
            [self.navigationController pushViewController:webVC animated:YES];
        } else if(self.rolecheckstate == 1001) {
            [HintView enrichSubviews:[NSString stringWithFormat:@"%@",self.reason] andSureTitle:@"修改" cancelTitle:@"取消" sureAction:^{
                [ManagerEngine jumpShopManageH5:YES];
            }];
        } else if (self.rolecheckstate == 1000 || self.rolecheckstate == 6666) {
            [ManagerEngine jumpShopManageH5:YES];
            
        }
    }
    else {
        [self.sp_viewModel clickItemWithIndexPath:indexPath dataArray:self.dataSourceAry];
        
    }
}





- (MyHeaderView *)my_headerView {
    if (!_my_headerView) {
        _my_headerView = [[MyHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 106.66f)];
        
    }
    return _my_headerView;
}
#pragma mark --
#pragma mark ---
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.zwNavView.backgroundColor = DefaultAPPColor;
    [self.view addSubview:self.myTableView];
    self.zwBackButton.hidden = YES;
    self.zw_title = @"我的";
    self.zwTitLabel.textColor = [UIColor whiteColor];
    self.bottomLineView.hidden = YES;
    
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
    
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self.viewModel jumpAlert];
    //    });
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    @weakify(self);
        [RACObserve(self, model)subscribeNext:^(MyModel *x) {
            @strongify(self);
            NSString *nameStr = !x.realname ||[x.realname isEqualToString:@"null"] ? @"" : x.realname;
    
            if (x.mobile) {
                [self.my_headerView shopName:nameStr shopRole:x.role];

//                if ([[NameSingle shareInstance].role containsString:@"利益"]) {
//                    [self.my_headerView shopName:nameStr shopRole:[NSString stringWithFormat:@"%@(利益共同体)",nameStr]];
////                    [self.titleView setTitleStr:[NSString stringWithFormat:@"%@(利益共同体)",nameStr] andisNav:YES andColor:DefaultAPPColor];
//                } else {
////                    [self.titleView setTitleStr:[NSString stringWithFormat:@"%@(%@)",nameStr,[self setShopTitle:[self roleStr]]] andisNav:YES andColor:DefaultAPPColor];
//                    [self.my_headerView shopName:nameStr shopRole:[self setShopTitle:[self roleStr]]];
//
//                }
    
            }
    
    
        }];
        if (MmberidStr) {
            [self requst];
        }
    NSString *url = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBGetShopUpgradeStateInterface];
    
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:@{@"shopid":Shopid} complete:^(NSDictionary *dic) {
     
        self.reason = [dic[@"resultMsg"][@"rolecheckremark"] stringByReplacingOccurrencesOfString:@"_&_" withString:@"\n"];
        self.rolecheckstate = [dic[@"resultMsg"][@"rolecheckstate"] integerValue];
     
        self.signUrl = dic[@"resultMsg"][@"signUrl"];
        [self.myTableView reloadData];
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}
- (void)requst {
    @weakify(self);
    [self.my_viewModel  setMyrequstBlock:^(MyModel * xzw_model) {
        @strongify(self);

        self.model = xzw_model;
    }];
    [self.my_viewModel setMyrequstErrorBlock:^{
        @strongify(self);
//        [self.collectionView.mj_header endRefreshing];

    }];
    [MyViewModel getUseBookingInfo];
    [self.my_viewModel myRequst];

}
- (NSString *)roleStr {
    if ([Ttypeid integerValue] == 13) {
        return @"物联商家";
    } else if ([Ttypeid integerValue] == 14){
        return @"联盟商家";
    }  else if ([Ttypeid integerValue] == 15){
        return @"合作商家";
    }  else if ([Ttypeid integerValue] == 16){
        return @"股份商家";
    }  else if ([Ttypeid integerValue] == 17){
        return @"命运共同体";
    }  else if ([Ttypeid integerValue] == 113){
        return @"XD商企";
    } else {
        return @"未认证商家";
    }
}

- (NSString *)setShopTitle:(NSString *)title {
    NSString *name;
    if ([title containsString:@"共同体"]) {
        title = @"共同体";
    } else {
        title = [title substringToIndex:2];
    }
    
    if ([LlockedDuration integerValue] == 7) {
        name = @"XD";
        
    }
    if ([LlockedDuration integerValue] <= 6&&[LlockedDuration integerValue] >= 1) {
        /// ;//XD企业类型 0非XD企业 1.标识企业 2.异盟企业 3.标杆企业 4.兄弟企业 5.生态企业 6.XD商家
        NSArray * ary = @[@"",@"标识",@"异盟",@"标杆",@"兄弟",@"生态",@"XD"];
        NSInteger titleTag = [NameSingle shareInstance].peugeotid;
        titleTag = titleTag >6 || titleTag < 0 ? 0 : titleTag;
        
        if (titleTag == 0) {
            name = [NSString stringWithFormat:@"%@",title];
            
            
            
        } else {
            
            name = [NSString stringWithFormat:@"%@·%@",title,ary[titleTag]];
            
            
        }
        
    }
    if ([LlockedDuration integerValue] == 0) {
        name = title;
    }
    return  name;
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}





- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (NSMutableArray *)dataSourceAry {
    if (!_dataSourceAry) {
        _dataSourceAry = [NSMutableArray array];
        NSMutableArray *rowAry = [NSMutableArray arrayWithArray:@[@{@"sp_image":@"icon_Accountsecurity",
                                                                    @"sp_title":@"账号安全",
                                                                    @"sp_action":@"AccountSecurityViewController"},
                                                                  @{@"sp_image":@"icon_Basicinformation",
                                                                    @"sp_title":@"基础信息",
                                                                    @"sp_action":@"InformationViewController"},
                                                                  @{@"sp_image":@"icon_contractmanagement",
                                                                    @"sp_title":@"合同管理",
                                                                    @"sp_action":@"ContactManagerViewController"},
                                                                  @{@"sp_image":@"icon_StoreActivate",
                                                                    @"sp_title":@"激活店铺",
                                                                    @"sp_action":@""},
                                                                  @{@"sp_image":@"icon-Messagenotification",
                                                                    @"sp_title":@"消息通知",
                                                                    @"sp_action":@"MessageNotificationViewController"},
                                                                  @{@"sp_image":@"icon_Contactcustomerservice",
                                                                    @"sp_title":@"联系客服",
                                                                    @"sp_subTitle":@"400591081",
                                                                    @"sp_action":@""},
                                                                  @{@"sp_image":@"icon_setup",
                                                                    @"sp_title":@"设置",
                                                                    @"sp_action":@"SetViewController"}]];
        if (self.rolecheckstate != 1000 && self.rolecheckstate != 6666) {
            [rowAry removeObject:@{@"sp_image":@"icon_StoreActivate",
                                                              @"sp_title":@"激活店铺",
                                                   @"sp_action":@""}];
        }
        NSMutableArray *rowTitleWithImageArray =[NSMutableArray arrayWithArray:@[rowAry]];
      
        [rowTitleWithImageArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *allData = [NSMutableArray array];
            allData = [ShopModel mj_objectArrayWithKeyValuesArray:obj];
            [_dataSourceAry addObject:allData];
            
            
        }];
        
    }
    return _dataSourceAry;
}
- (MyViewModel *)my_viewModel {
    if (!_my_viewModel) {
        _my_viewModel = [[MyViewModel alloc]init];
    }
    return _my_viewModel;
}
- (ShopViewModel *)sp_viewModel {
    if (!_sp_viewModel) {
        _sp_viewModel = [[ShopViewModel alloc]init];
    }
    return _sp_viewModel;
}
@end
