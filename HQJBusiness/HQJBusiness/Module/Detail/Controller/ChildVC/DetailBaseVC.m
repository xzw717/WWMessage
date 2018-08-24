//
//  DetailBaseVC.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "DetailBaseVC.h"
#import "DetailViewModel.h"
#import "DetailCell.h"

@interface DetailBaseVC ()<UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>



@end

@implementation DetailBaseVC

-(UITableView *)tableView {
    if ( _tableView == nil ) {
        _tableView = [[UITableView alloc]init];
        _tableView.rowHeight = 70.0;
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.frame = CGRectMake(0, 44 + kNAVHEIGHT, WIDTH, HEIGHT - kNAVHEIGHT - 44 - 49);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[DetailCell class] forCellReuseIdentifier:@"cellid"];
    }
    _tableView.contentInset = UIEdgeInsetsZero;
  
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self requstType:_type andPage:@"1"];
        
        
    }];
    _tableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [self requstType:_type andPage:[NSString stringWithFormat:@"%ld",(long)_page]];
    }];
    
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _page = 1;
    _listArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    
}
-(void)requstType:(NSString *)type andPage:(NSString *)page {
    [DetailViewModel detailRequsttype:type types:nil page:page listBlock:^(NSArray<DetailModel *> *sender) {
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
//        self.tableView.emptyDataSetSource = self;
//        self.tableView.emptyDataSetDelegate = self;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
  
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
      [cell setModel:self.listArray[indexPath.row] andPaging:_typePage];
        return cell;
    
    
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"brokenNetwork"];
}
//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    [self requstType:_type andPage:@"1"];

}


@end
