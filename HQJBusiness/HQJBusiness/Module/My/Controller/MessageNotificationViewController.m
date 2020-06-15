//
//  MessageNotificationViewController.m
//  HQJBusiness
//
//  Created by mymac on 2017/4/17.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageNotificationViewController.h"
#import "MessageNotificationCell.h"
#import "MessageNotificationViewModel.h"

@interface MessageNotificationViewController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView *messageTableView;
@property (nonatomic, strong) MessageNotificationViewModel *messageviewModel;
@property (nonatomic)         NSInteger messagePage;
@end

@implementation MessageNotificationViewController


- (MessageNotificationViewModel *)messageviewModel {
    if (_messageviewModel == nil) {
        _messageviewModel = [[MessageNotificationViewModel alloc]init];
    }
    return _messageviewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.messageTableView];
    self.zw_title = @"消息通知";
    [self loadmessage];
    _messagePage = 1;
   
    
}

-(UITableView *)messageTableView {
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc]init];
        _messageTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _messageTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        [_messageTableView registerClass:[MessageNotificationCell class] forCellReuseIdentifier:NSStringFromClass([MessageNotificationCell class])];
//        _messageTableView.tableFooterView = [UIView new];
        _messageTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmessage)];
        _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _messageTableView.emptyDataSetSource = self;
        _messageTableView.emptyDataSetDelegate = self;
    }
    return _messageTableView;
}

- (void)loadmessage {
    _messagePage ++;
    self.messageviewModel.messagePage = _messagePage;
    self.messageviewModel.messageState = AllMessageType;
    @weakify(self);
    [self.messageviewModel.loadMoreSignal subscribeNext:^(NSString *x) {
        @strongify(self);
        BOOL nodata = [x isEqualToString:@"nodata"] ? YES : NO;
        [self updata:nodata];
    }];
}

- (void)updata:(BOOL)noData {
    noData ? [self.messageTableView.mj_footer endRefreshingWithNoMoreData] : [self.messageTableView.mj_footer endRefreshing];
    [self.messageTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageviewModel.messageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.messageviewModel.messageArray.count > 0) {
        MessageNotificationModel *model = self.messageviewModel.messageArray[indexPath.row];
        return [self.messageTableView cellHeightForIndexPath:indexPath model:model keyPath:@"messageModel" cellClass:[MessageNotificationCell class] contentViewWidth:WIDTH];
    }
 
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageNotificationCell class]) forIndexPath:indexPath];
    cell.messageModel = self.messageviewModel.messageArray[indexPath.row];
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    return cell;
}

#pragma mark --
#pragma mark ---
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSAttributedString *attribut = [[NSAttributedString alloc]initWithString:@"暂时没有消息"];
    return attribut;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    if (self.messageviewModel.messageArray ) return NO;
    return YES;
}
//- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSLog(@"backgroundColorForEmptyDataSet");
//    return [UIColor brownColor]; // redColor whiteColor
//}
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
 
     HQJLog(@"高度是：>>>>>>>>>\n%f >>>>>>>>>>>\n%@ >>>>>>>\n%@ >>>>>>>>\n%@",[self.messageTableView cellHeightForIndexPath:indexPath model:self.messageviewModel.messageArray[indexPath.row] keyPath:@"messageModel" cellClass:[MessageNotificationCell class] contentViewWidth:WIDTH],indexPath,model.content,[MessageNotificationCell class]);
 
*/

@end
