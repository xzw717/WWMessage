//
//  MessageListVC.m
//  消息主界面
//
//  Created by Ethan on 2021/7/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageListVC.h"
#import "MessageListViewModel.h"
#import "MessageListCell.h"
#import "FTPopOverMenu.h"
#import "MessageListModel.h"
#import "MessageSetVC.h"
#import "MessageVC.h"

@interface MessageListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *messageListTableView;
@property (nonatomic, strong) MessageListViewModel *viewModel;
@end

@implementation MessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageTitle  = @"消息";
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
    rightBtn.bounds = CGRectMake(0, 0, 60, 44);
    [rightBtn addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    self.messageRightOneButton = rightBtn;
    [self.view addSubview:self.messageListTableView];
}
- (void)more:(UIButton *)btn {
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.menuWidth = NewProportion(385.f);
    configuration.imageSize = CGSizeMake(19.5f, 19.5f);
    configuration.menuTextMargin = NewProportion(28.f);
    configuration.menuIconMargin = NewProportion(54.f);
    configuration.textAlignment = NSTextAlignmentLeft;
    @weakify(self);
    [FTPopOverMenu showForSender:btn withMenuArray:@[@"标记已读",
                                                     @"消息设置"] imageArray:@[@"icon_markread",
                                                                           @"icon_message_setup"] configuration:configuration doneBlock:^(NSInteger selectedIndex) {
        @strongify(self);
        if (selectedIndex == 0) {
            for (MessageListModel *model in self.viewModel.messageListModelArray) {
                model.messageCount = @"0";
            }
            [self.messageListTableView reloadData];
        } else {
            MessageSetVC * vc = [[MessageSetVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageListModel *model = self.viewModel.messageListModelArray[indexPath.row];
    MessageVC *vc = [[MessageVC alloc]init];
    vc.messageTitle = model.mainTitle;
    [self.navigationController pushViewController:vc animated:YES];
}
- (UITableView *)messageListTableView {
    if (!_messageListTableView) {
        _messageListTableView = [[UITableView alloc]init];
        _messageListTableView.frame = CGRectMake(0, NavigationControllerHeight, Message_WIDTH, Message_HEIGHT - NavigationControllerHeight);
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
