//
//  MessageListVC.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageListVC.h"

@interface MessageListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *messageListTableView;
@end

@implementation MessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title  = @"消息";
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return 4;
 
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    return cell;
    
    
    
    
    
}

- (UITableView *)messageListTableView {
    if (!_messageListTableView) {
        _messageListTableView = [[UITableView alloc]init];
        _messageListTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _messageListTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _messageListTableView.delegate = self;
        _messageListTableView.dataSource = self;
        [_messageListTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _messageListTableView.tableFooterView = [UIView new];
        
    }
    return _messageListTableView;
}


@end
