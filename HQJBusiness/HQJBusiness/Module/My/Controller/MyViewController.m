//
//  MyViewController.m
//  HQJBusiness
//   我的
//  Created by mymac on 2016/12/9.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MyViewController.h"
#import "LoginViewController.h"
#import "MyModel.h"
#import "NoticeView.h"
#import "MyViewModel.h"
#import "MyTableViewCell.h"
#import "DealTableViewCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "TabBarBannerViewModel.h"
#import "TabBarBannerModel.h"
#import "MessageNotificationViewModel.h"
#import "MessageNotificationViewController.h"
#import "AppDelegate.h"
#import "ZGAudioManager.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong)NoticeView *titleView ;

@property (nonatomic,strong)MyModel *model;

@property (nonatomic,strong)MyViewModel *viewModel;

@property (nonatomic,strong)NSMutableArray *bannerArray;

@property (nonatomic, strong) MessageNotificationViewModel *myMessageViewModel;

@end

@implementation MyViewController
-(UITableView *)myTableView {
    if ( _myTableView == nil ) {
        _myTableView = [[UITableView alloc]init];
        _myTableView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64-45);
        _myTableView.backgroundColor = DefaultBackgroundColor;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];

        [_myTableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MyTableViewCell class])];
        
        [_myTableView registerClass:[DealTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DealTableViewCell class])];

        
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
        footerView.backgroundColor = DefaultBackgroundColor;
        
        _myTableView.tableFooterView = footerView;
        
    
     
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self requst];
            
            
        }];
        
        _myTableView.mj_header = header;
        header.lastUpdatedTimeLabel.hidden = YES;
        
    }
  
    return _myTableView;
}

- (MessageNotificationViewModel *)myMessageViewModel {
    if (_myMessageViewModel == nil) {
        _myMessageViewModel = [[MessageNotificationViewModel alloc]init];
    }
    return _myMessageViewModel;
}



#pragma mark --
#pragma mark --- tableView  data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        
        return 4;
    } else {
        
        return 2;
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = DefaultBackgroundColor;
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 70;
    } else {
        
        return 44;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 0.01;
    } else {
        return 15;

    }
  
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyTableViewCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:_model];
        return cell;
        
    }  else {
      
        DealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DealTableViewCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.cellIndexPath = indexPath;

        if (indexPath.section == 2&& indexPath.row == 1) {
            CellLine(cell);
    }
    
        return cell;
    }
    
    
  
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_viewModel jumpVc:self andIndexPath:indexPath];
}


/**
 点击轮播图代理

 @param cycleScrollView 轮播图
 @param index 轮播图下标
 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}


- (UIView  *)setCycleScrollView {
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 180) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    cycleScrollView.backgroundColor = DefaultBackgroundColor;
    cycleScrollView.imageURLStringsGroup = self.bannerArray;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    return cycleScrollView;
}


#pragma mark --
#pragma mark ---
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _viewModel = [[MyViewModel alloc]init];
    _model = [[MyModel alloc]init];
    self.zwNavView.backgroundColor = DefaultAPPColor;
    self.zwBackButton.hidden = YES;
    [self.view addSubview:self.myTableView];

    HQJLog(@"第几次");
  
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
  

    
    
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    @weakify(self);
    [self.titleView setTitleStr:@"" andisNav:YES andColor:DefaultAPPColor];
    [RACObserve(self, model)subscribeNext:^(MyModel *x) {
        @strongify(self);
        NSString *nameStr = !x.realname ? @"" : x.realname;
//        NSString *mobileStr= !x.mobile ? @"" : [x.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        if (x.mobile) {
            [self.titleView setTitleStr:[NSString stringWithFormat:@"%@(%@)",nameStr,x.role] andisNav:YES andColor:DefaultAPPColor];
        }
        
        
    }];
    if (MmberidStr) {
        [self requst];
    }
}



-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];

}


#pragma mark --
#pragma mark --- 请求
- (void)requst {
    @weakify(self);
    [TabBarBannerViewModel pictureRequst:^(NSMutableArray *sender) {
          self.bannerArray = [NSMutableArray array];
        @strongify(self);
        for (TabBarBannerModel * picturemdoel in sender) {
          
            [self.bannerArray addObject:[NSString stringWithFormat:@"%@%@",HQJBImageDomainName,picturemdoel.src]];
            
        }
        self.myTableView.tableHeaderView = [self setCycleScrollView];
        
    }];
    
    
    [self.titleView.activityIndicator stopAnimating];
    
    [_viewModel  setMyrequstBlock:^(MyModel * xzw_model) {
        @strongify(self);
        self.model = xzw_model;
//        [selfWeak.titleView removeFromSuperview];
//        [selfWeak.view addSubview:selfWeak.titleView];
     
        [self.zwNavView removeFromSuperview];
        
        [NameSingle shareInstance].name = xzw_model.realname; // --- 单例存商家名字
        [NameSingle shareInstance].role = xzw_model.role;   //  -----   存商家类型
        [NameSingle shareInstance].mobile = xzw_model.mobile;
        [NameSingle shareInstance].memberid = xzw_model.memberid;
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
    }];
    [_viewModel setMyrequstErrorBlock:^{
        @strongify(self);
        [self.myTableView.mj_header endRefreshing];
        [self.titleView.activityIndicator stopAnimating];
    }];
    [_viewModel myRequst];

    
    self.myMessageViewModel.messageState = UnreadMessageType;
    
    [self.myMessageViewModel.loadMoreSignal subscribeNext:^(NSString  *x) {
        if (![x isEqualToString:@"nodata"]) {
            @strongify(self);
            
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    // 网络请求
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //主线程刷新UI
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"您有%ld条消息",(unsigned long)self.myMessageViewModel.messageArray.count] preferredStyle:UIAlertControllerStyleAlert];
                        [alert addAction:[UIAlertAction actionWithTitle:@"前往查看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            MessageNotificationViewController *messageVC =[[MessageNotificationViewController alloc]init];
                            [self.navigationController pushViewController:messageVC animated:YES];
                        }]];
                        [self presentViewController:alert animated:YES completion:nil];
                        
                    });
                    
                });
            
            
        }
    }];
    
}

- (void)loginSuccess  {
    [self.titleView setTitleStr:@"" andisNav:YES andColor:DefaultAPPColor];
    [self requst];
}




- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (NoticeView *)titleView {
    if (!_titleView) {
        _titleView =  [[NoticeView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64) withNav:YES];
        [self.view addSubview:self.titleView];

    }

    return _titleView;
}

@end
