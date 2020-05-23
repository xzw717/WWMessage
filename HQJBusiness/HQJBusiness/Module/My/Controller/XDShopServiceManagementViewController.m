//
//  XDShopServiceManagementViewController.m
//  HQJBusiness
//   XD商家服务费订单
//  Created by mymac on 2020/5/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDShopServiceManagementViewController.h"
#import "HQJSelectToolView.h"
#import "XDSSMTableViewCell.h"
#import "XDSSMViewModel.h"
#import "XDSSMModel.h"
#import "XDPayModel.h"
#import "XDPayViewController.h"

#import "XDOrderDetailsViewController.h"
@interface XDShopServiceManagementViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView  *xdssmTableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSMutableArray <XDSSMModel *>*modelArray;
@end

@implementation XDShopServiceManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zwTitLabel.text = @"XD商家服务费订单";
    HQJSelectToolView *view = [[HQJSelectToolView alloc]initWithTitleAry:@[@"支付成功",@"待付款"]];
      @weakify(self);
     [view setIndex:^(NSInteger indx) {
         @strongify(self);
         self.state = indx == 0 ? 5 : 1;
         [self requstList];
         self.modelArray = [NSMutableArray array];
     }];
       view.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, NewProportion(132));
       [self.view addSubview:view];
    [self.view addSubview:self.xdssmTableView];
    self.page = 1;
    self.state = 5;
    [self requstList];
    self.modelArray = [NSMutableArray array];

}
- (void)requstList {
    @weakify(self);
    [XDSSMViewModel requstXDShopServiceManagementList:self.page orderstate:self.state  completion:^(NSArray<XDSSMModel *> * _Nonnull modelAry) {
        @strongify(self);
        if (modelAry.count >0) {
            if (self.page <= 1) {
                self.modelArray = modelAry.mutableCopy;
                } else {
                    [self.modelArray addObjectsFromArray:modelAry];
                }
        } else {
            if (self.page > 1) {
                
                self.page --;
            } else {
                self.modelArray = nil;
            }
            
            
        }
        [self.xdssmTableView.mj_header endRefreshing];
        [self.xdssmTableView.mj_footer endRefreshing];
        [self.xdssmTableView reloadData];
    } error:^(NSError * _Nonnull error) {
        self.modelArray = nil;
        [self.xdssmTableView.mj_header endRefreshing];
        [self.xdssmTableView.mj_footer endRefreshing];
        [self.xdssmTableView reloadData];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.modelArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    XDSSMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XDSSMTableViewCell class]) forIndexPath:indexPath];
    XDSSMModel *ssmModel = self.modelArray[indexPath.row];
    cell.model = ssmModel;
    @weakify(self);
    [cell setPayBlock:^{
        @strongify(self);
        XDPayModel *model = [[XDPayModel alloc]init];
        model.orderid = ssmModel.orderid;
        model.paymoney =  ssmModel.ordermoney ;
        model.proid = ssmModel.proid;
        
        XDPayViewController *xdVC = [[XDPayViewController alloc]initWithXDPayModel:model];
        [self.navigationController pushViewController:xdVC animated:YES];
    }];
    return cell;

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.state == 0) {
        XDOrderDetailsViewController *xdVc = [[XDOrderDetailsViewController alloc]initWithXDSSMModel:self.modelArray[indexPath.row]];
        [self.navigationController pushViewController:xdVc animated:YES];
    }

}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"brokenNetwork"];
}
//空白页点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
     [self requstList];
}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    if (self.modelArray) {
        return NO;
    } else {
       return YES;
    }
    
}
- (UITableView *)xdssmTableView {
    if (!_xdssmTableView) {
        _xdssmTableView = [[UITableView alloc]init];
        _xdssmTableView.frame = CGRectMake(0, NavigationControllerHeight + NewProportion(132), WIDTH, HEIGHT - NavigationControllerHeight - NewProportion(132));
        _xdssmTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _xdssmTableView.delegate = self;
        _xdssmTableView.dataSource = self;
        _xdssmTableView.rowHeight = NewProportion(520);
        [_xdssmTableView registerClass:[XDSSMTableViewCell class] forCellReuseIdentifier:NSStringFromClass([XDSSMTableViewCell class])];
        _xdssmTableView.tableFooterView = [UIView new];
        _xdssmTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _xdssmTableView.backgroundColor = [ManagerEngine getColor:@"f3f2f7"];
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            [self requstList];
         
        }];
        MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
            self.page ++;
             [self requstList];
        }];
        _xdssmTableView.mj_header = header;
        _xdssmTableView.mj_footer = footer;
        _xdssmTableView.emptyDataSetSource = self;
        _xdssmTableView.emptyDataSetDelegate = self;
       
    }
    return _xdssmTableView;
}


@end
