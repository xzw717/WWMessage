//
//  BookScoreViewController.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/12/16.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "BookScoreViewController.h"
#import "BookScoreViewModel.h"
#import "BookScoreCell.h"
#import "NoticeView.h"
#import "BuyZHViewModel.h"
@interface BookScoreViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic,strong)  NSMutableArray *dataArray;
@property (nonatomic,strong) NSString *totalScore ;
@property (nonatomic,strong) NoticeView *titleView ;  // ---- 黄色广告条

@end

@implementation BookScoreViewController
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

-(NoticeView *)titleView {
    if (!_titleView) {
        _titleView = [[NoticeView alloc]initWithFrame:CGRectMake(0, NavigationControllerHeight, WIDTH, 64) withNav:NO];
        [self.view addSubview:_titleView];
    }
    
    return _titleView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, NavigationControllerHeight + 64 , WIDTH, HEIGHT - NavigationControllerHeight - 64);
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = NewProportion(184) + 20;
        
        [_tableView registerClass:[BookScoreCell class] forCellReuseIdentifier:NSStringFromClass([BookScoreCell class])];
        @weakify(self);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            self.page = 1;
            [self requstBookScoreList];
            
            
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            self.page ++;
            [self requstBookScoreList];
        }];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"预约积分";
    self.page = 1;
    [self.view addSubview:self.tableView];
    [self requstBookScoreList];
    
    // Do any additional setup after loading the view.
}
- (void)requstBookScoreList {
    @weakify(self);
    [BookScoreViewModel requsetBookScoreList:self.page andSize:10 completion:^(NSString * _Nonnull totalScore, NSArray<BooKScoreModel *> * _Nonnull array) {
        @strongify(self);
        self.totalScore = totalScore;
        [self.titleView setTitleStr:[NSString stringWithFormat:@"当前可用预约积分%@个积分",[ManagerEngine retainScale:self.totalScore afterPoint:5]] andisNav:NO andColor:[ManagerEngine getColor:@"fff2b2"]];
        if (1 == self.page) {
            self.dataArray = nil;
        }
        if (self.page != 1) {
            if (array.count == 0) {
                
                //                [SVProgressHUD showErrorWithStatus:@"已经是最后一页了"]];
                self.page = self.page - 1;
            }
        }
        [self.dataArray addObjectsFromArray:array];
        [self.tableView reloadData];
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookScoreCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [self jumpDetailsWithModel:self.listModel.data[indexPath.row]];
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
