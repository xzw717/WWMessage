//
//  ManualGiftRYViewController.m
//  HQJBusiness
//
//  Created by mymac on 2019/1/18.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ManualGiftRYViewController.h"
#import "CashOnlineCell.h"
#import "DetailViewModel.h"
#import "DetailModel.h"
@interface ManualGiftRYViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate
>
@property (nonatomic, assign) NSInteger  page;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray <DetailModel *>*listArray;
@property (nonatomic, strong) NSMutableArray <DetailModel *>*selectArray;
@end

@implementation ManualGiftRYViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    [self requstPage:[NSString stringWithFormat:@"%ld",(long)self.page] title:@"线下支付" complete:^{
        [self setDataSource];
    }];

    [self.view addSubview:self.tableView];
    _listArray = [NSMutableArray array];
   
}



- (void)setDataSource{
    //    [_listArray enumerateObjectsUsingBlock:^(DetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        if ([title isEqualToString:@"线下支付"]) {
    //            if ([obj.tradetype isEqualToString:@"现金消费"]) {
    //                [_selectArray addObject:obj];
    //            }
    //        } else {
    //            if (![obj.tradetype isEqualToString:@"现金消费"]) {
    //                [_selectArray addObject:obj];
    //
    //            }
    //        }
    //    }];
    //    self.tableView.emptyDataSetSource = self;
    //    self.tableView.emptyDataSetDelegate = self;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
    
}


-(void)requstPage:(NSString *)page title:(NSString *)title complete:(void(^)(void))completeBlcok {
    [DetailViewModel detailRequsttype:HQJBCashTradeListInterface types:title page:page listBlock:^(NSArray<DetailModel *> *sender)  {
        if (1 == _page) {
            [_listArray  removeAllObjects];
            [_listArray addObjectsFromArray:sender];
            
        } else {
            if (sender.count == 0 ) {
                _page --;
                [SVProgressHUD showErrorWithStatus:@"没有更多数据了"];
            } else {
                [_listArray addObjectsFromArray:sender];
                
            }
        }
        
        !completeBlcok ? : completeBlcok();
        
    }];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"brokenNetwork"];
}
//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    [self requstPage:@"1" title:@"线下支付" complete:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CashOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    cell.isManualGift = YES;
    cell.cashModel = _listArray[indexPath.row];
    return cell;
    
}




-(UITableView *)tableView {
    if ( _tableView == nil ) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - NavigationControllerHeight - 44);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[CashOnlineCell class] forCellReuseIdentifier:@"cellid"];
    }
    _tableView.contentInset = UIEdgeInsetsZero;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self requstPage:[NSString stringWithFormat:@"%ld",(long)_page] title: @"线下支付"  complete:^{
            [self setDataSource];
        }];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [self requstPage:[NSString stringWithFormat:@"%ld",(long)_page] title:@"线下支付" complete:^{
            [self setDataSource];
        }];
        
    }];
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    return _tableView;
}

@end

