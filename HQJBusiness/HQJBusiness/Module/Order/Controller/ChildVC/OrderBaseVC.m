//
//  OrderBaseVC.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/26.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderBaseVC.h"
#import "OrderViewModel.h"
#import "OrderOneCell.h"
#import "OrderModel.h"
#import "OrderTwoCell.h"
#import "OrderTableViewHeader.h"
#import "OrderTableViewCell.h"
#import "OrderTableViewFooterView.h"
#import "HQJBusinessAlertView.h"
#import "OrderCompleteFootView.h"
#import "OrderDetailsViewController.h"
@interface OrderBaseVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>
@property (nonatomic, strong) OrderViewModel *viewModel;
@property (nonatomic, strong) NSString *typeStr;
@end

@implementation OrderBaseVC


- (void)requstType:(NSString *)type andPage:(NSString *)page {
    self.typeStr = type;
    [self.viewModel orderRequstWithPage:[page integerValue] andType: [type integerValue] andReturnBlock:^(NSArray *sender) {
        if (0 == [page integerValue]) {
            [self.listArray  removeAllObjects];
            [self.listArray addObjectsFromArray:sender];
            self.page  = self.listArray.count;

        } else {
            if (sender.count == 0 ) {
                
                [SVProgressHUD showErrorWithStatus:@"没有更多数据了"];
            } else {
                [self.listArray addObjectsFromArray:sender];
                self.page  = self.listArray.count;

            }
        }

        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];

    }];
    
    
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 44, WIDTH - 20, HEIGHT - 44 - ToolBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.rowHeight = 394/3.f;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderTableViewCell class ])];
        [_tableView registerClass:[OrderTwoCell class] forCellReuseIdentifier:NSStringFromClass([OrderTwoCell class ])];
        [_tableView registerClass:[OrderTableViewHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([OrderTableViewHeader class])];
        [_tableView registerClass:[OrderTableViewFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([OrderTableViewFooterView class])];
        [_tableView registerClass:[OrderCompleteFootView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([OrderCompleteFootView class])];

        
    }
    _tableView.contentInset = UIEdgeInsetsZero;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requstType:_type andPage:@"0"];
        
        
    }];
    
    _tableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requstType:_type andPage:[NSString stringWithFormat:@"%ld",(long)_page]];
    }];
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _page = 0;
    _listArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    @weakify(self);
    self.viewModel.ErrorBlock = ^(NSString *error) {
        @strongify(self);
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    };

}




#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArray.count;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    OrderModel *model = self.listArray[section];
  
    return ! model.goodslist.count ? 1 : model.goodslist.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderModel *model = self.listArray[indexPath.section];
    cell.orderDate = [NSString stringWithFormat:@"%ld",(long)model.date];
    if (model.type == 1) {
        cell.orderGoodsModel = model.goodslist[indexPath.row];

    } else {
        cell.orderModel = model;
    }
    return cell;
//    OrderModel *model = self.listArray[indexPath.row];
//
//    if (model.type == 2) {
//        OrderOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderOneCell class ]) forIndexPath:indexPath];
//        cell.model = model;
//        return cell;
//
//http://shoptest.heqijia.net/order/shopfindorderlist.action?memberid=579ef84e8eb9b658215652&start=1&pageSize=15&type=2} else {
//        OrderTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderTwoCell class]) forIndexPath:indexPath];
//        cell.model = model;
//        return cell;
//    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 53.f;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    OrderModel *model = self.listArray[section];
    if ([model.state isEqualToString:@"待评价"] || [model.state isEqualToString:@"交易完成"]) {
       
        return CompleteFootHeight;
    }
    return 44.f + 44.f;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OrderModel *model = self.listArray[section];

    OrderTableViewHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([OrderTableViewHeader class])];

    [headerView setState:model.state orderNumber:model.nid];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    OrderModel *model = self.listArray[section];
    if ([model.state isEqualToString:@"待评价"] || [model.state isEqualToString:@"交易完成"]) {
        OrderCompleteFootView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([OrderCompleteFootView class])];
        __block NSInteger allCount = 0;
        [model.goodslist enumerateObjectsUsingBlock:^(GoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            allCount = allCount + obj.goodscount;
        }];
        @weakify(self);
        footerView.contactBuyerBlock = ^{
            @strongify(self);
            if ([model.state isEqualToString:@"交易完成"]) {
                [OrderViewModel requestCustomerInformationWith:model.userid complete:^(NSString *mobile, NSString *realname) {
                    HQJBusinessAlertView * alertView = [[HQJBusinessAlertView alloc]initWithisWarning:NO];
                    //    [alertView zw_showAlertWithContent];
                    [alertView zw_showAlertWithName:realname mobile:mobile];
                }];
            } else {
                OrderDetailsViewController *vc = [[OrderDetailsViewController alloc]initWithModel:model];
                [self.navigationController pushViewController:vc animated:YES];
            }
           
            
            
        };
        [footerView setfootOrderModel:model count:allCount  isUseDate:model.usedate ? YES : NO];
        
        //    [footerView setTimer:model.date usedate:model.usedate count:allCount allPrice:model.price];
        return footerView;
    } else {
        OrderTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([OrderTableViewFooterView class])];
        __block NSInteger allCount = 0;
        [model.goodslist enumerateObjectsUsingBlock:^(GoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            allCount = allCount + obj.goodscount;
        }];
        footerView.contactBuyerBlock = ^{
            [OrderViewModel requestCustomerInformationWith:model.userid complete:^(NSString *mobile, NSString *realname) {
                HQJBusinessAlertView * alertView = [[HQJBusinessAlertView alloc]initWithisWarning:NO];
                //    [alertView zw_showAlertWithContent];
                [alertView zw_showAlertWithName:realname mobile:mobile];
            }];
            
            
        };
        [footerView setfootOrderModel:model count:allCount  isUseDate:model.usedate ? YES : NO];
        
        //    [footerView setTimer:model.date usedate:model.usedate count:allCount allPrice:model.price];
        return footerView;
    }
   
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"brokenNetwork"];
}
//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    [self requstType:_type andPage:@"1"];
    
}

- (OrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[OrderViewModel alloc]init];
    }
    return _viewModel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    OrderModel *model = self.listArray[indexPath.section];
    if (model.type == 1) {
        !self.selectRowBlock ? : self.selectRowBlock(model);
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
