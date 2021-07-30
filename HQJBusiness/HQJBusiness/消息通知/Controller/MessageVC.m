//
//  MessageVC.m
//  消息类型列表
//
//  Created by Ethan on 2021/7/30.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageVC.h"
#import "MessageViewModel.h"
#import "MessageCell.h"
@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *messageTableView;
@property (nonatomic, strong) MessageViewModel *viewModel;
@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.messageTableView];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return self.viewModel.messageModelArray.count;
  
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageCell class]) forIndexPath:indexPath];
    cell.model = self.viewModel.messageModelArray[indexPath.row];
    return cell;
   
}

- (UITableView *)messageTableView {
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc]init];
        _messageTableView.frame = CGRectMake(0, NavigationControllerHeight, Message_WIDTH, Message_HEIGHT - NavigationControllerHeight);
        _messageTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        [_messageTableView registerClass:[MessageCell class] forCellReuseIdentifier:NSStringFromClass([MessageCell class])];
        _messageTableView.tableFooterView = [UIView new];
        _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _messageTableView.rowHeight = NewProportion(480.f);
    }
    return _messageTableView;
}

- (MessageViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MessageViewModel alloc]init];
    }
    return _viewModel;
}

@end
