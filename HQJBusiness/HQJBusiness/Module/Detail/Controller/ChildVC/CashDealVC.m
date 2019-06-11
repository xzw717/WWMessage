//
//  CashDealVC.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//



#import "CashDealVC.h"
#import "SelectButtonView.h"
#import "CashOnlineCell.h"
#import "DetailViewModel.h"
#import "DetailModel.h"
@interface CashDealVC ()
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
@property (nonatomic, assign) CGFloat  cellHeight;
@property (nonatomic, strong) NSString *selecttypeStr;
@end

@implementation CashDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    _cellHeight = 90.f;
    [self requstPage:[NSString stringWithFormat:@"%ld",(long)self.page] title:@"线上支付" complete:^{
        [self setDataSource];
    }];
//    SelectButtonView *view1 = [[SelectButtonView alloc]initWithFrame:CGRectMake(0, kNAVHEIGHT + 44 , WIDTH, 40)];
//    view1.titleStr = ^(NSString *buttonTitle) {
//        [self.listArray  removeAllObjects];
//          _page = 1;
//          [self requstPage:@"1" title:buttonTitle complete:^{
//            [self setDataSource];
//        }];
//        _cellHeight = [buttonTitle isEqualToString:@"线上支付"] ? 90.f : 70.f;
//        _selecttypeStr = buttonTitle;
//
//    };
//    view1.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:view1];
    [self.view addSubview:self.tableView];
    _listArray = [NSMutableArray array];
  
}



- (void)setDataSource{

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
    [self requstPage:@"1" title:_selecttypeStr complete:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return _listArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CashOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    cell.isManualGift = NO;
    cell.cashModel = _listArray[indexPath.row];
    return cell;

}




-(UITableView *)tableView {
    if ( _tableView == nil ) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.frame = CGRectMake(0, 44 + NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight - 44 - 49);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[CashOnlineCell class] forCellReuseIdentifier:@"cellid"];
    }
    _tableView.contentInset = UIEdgeInsetsZero;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self requstPage:[NSString stringWithFormat:@"%ld",(long)_page] title: @"线上支付"  complete:^{
            [self setDataSource];
        }];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [self requstPage:[NSString stringWithFormat:@"%ld",(long)_page] title:@"线上支付" complete:^{
            [self setDataSource];
        }];
        
    }];
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    return _tableView;
}

@end
