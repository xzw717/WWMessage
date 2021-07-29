//
//  MessageListVC.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageListVC.h"
#import "MessageListViewModel.h"
#import "MessageListCell.h"
#import "FTPopOverMenu.h"

@interface MessageListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *messageListTableView;
@property (nonatomic, strong) MessageListViewModel *viewModel;
@end

@implementation MessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title  = @"消息";
    self.zwNavView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self.zwBackButton setImage:[UIImage imageNamed:@"return_black"] forState:UIControlStateNormal];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
    rightBtn.bounds = CGRectMake(0, 0, 60, 44);
    [rightBtn addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    self.zw_rightOneButton = rightBtn;
    [self.view addSubview:self.messageListTableView];
}
- (void)more:(UIButton *)btn {
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
        configuration.menuWidth = 120.f;
        configuration.menuIconMargin = 10.f;
        configuration.menuTextMargin = 10.f;
        configuration.textAlignment = NSTextAlignmentLeft;
        @weakify(self);
        [FTPopOverMenu showForSender:btn withMenuArray:@[@"标记已读",
                                                            @"消息设置"] imageArray:@[@"icon_markread",
                                                                                @"icon_setup"] doneBlock:^(NSInteger selectedIndex) {
    
    
        } dismissBlock:^{
    
        }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return self.viewModel.messageListModelArray.count;
 
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageListCell class]) forIndexPath:indexPath];
    cell.messageListCellModel = self.viewModel.messageListModelArray[indexPath.row];
    return cell;
    
    
    
    
    
}

- (UITableView *)messageListTableView {
    if (!_messageListTableView) {
        _messageListTableView = [[UITableView alloc]init];
        _messageListTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _messageListTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _messageListTableView.delegate = self;
        _messageListTableView.dataSource = self;
        [_messageListTableView registerClass:[MessageListCell class] forCellReuseIdentifier:NSStringFromClass([MessageListCell class])];
        _messageListTableView.tableFooterView = [UIView new];
        _messageListTableView.rowHeight = NewProportion(230);
        _messageListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _messageListTableView;
}

- (MessageListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MessageListViewModel alloc]init];
    }
    return _viewModel;
}
@end
