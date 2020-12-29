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
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.frame = CGRectMake(0, 44 + NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight - 44 - 49);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[DetailCell class] forCellReuseIdentifier:NSStringFromClass([DetailCell class])];
    }
    _tableView.contentInset = UIEdgeInsetsZero;
    @weakify(self);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        [self requstType:self.type andPage:@"1"];
        
        
    }];
    _tableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.page ++;
        [self requstType:self.type andPage:[NSString stringWithFormat:@"%ld",(long)self.page]];
    }];
    
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zwNavView.backgroundColor = DefaultAPPColor;
    self.zwBackButton.hidden = YES;
    self.zw_title = @"明细";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.zwTitLabel.textColor = [UIColor whiteColor];
    
    _page = 1;
    _listArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    
}


-(void)requstType:(NSString *)type andPage:(NSString *)page {
    @weakify(self);
    [DetailViewModel detailRequsttype:type types:nil page:page listBlock:^(NSArray<DetailModel *> *sender) {
        @strongify(self);
        if (1 == self.page) {
            [self.listArray  removeAllObjects];
            [self.self.listArray addObjectsFromArray:sender];
            
        } else {
            if (sender.count == 0 ) {
                self.page --;
                [SVProgressHUD showErrorWithStatus:@"没有更多数据了"];
            } else {
                [self.listArray addObjectsFromArray:sender];
                
            }
        }
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
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
    
    static NSString *CellIdentifier = @"DetailCell";
    DetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DetailCell class]) forIndexPath:indexPath];
    
    [cell setModel:self.listArray[indexPath.row] andPaging:_typePage];
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DetailCell class])];
    if (self.typePage == 2) {
        return [cell cellHeightWithModel:self.listArray[indexPath.row]]+ 22;
    } else {
        return [cell cellHeightWithModel:self.listArray[indexPath.row]];
    }
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"brokenNetwork"];
}
//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    [self requstType:_type andPage:@"1"];
    
}


@end
