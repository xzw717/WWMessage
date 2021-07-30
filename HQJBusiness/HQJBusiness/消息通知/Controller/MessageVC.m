//
//  MessageVC.m
//  消息类型列表
//
//  Created by Ethan on 2021/7/30.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageVC.h"

@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *messageTableView;
@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.messageTableView];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return 3;
  
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    return cell;
    
    
    
    
    
}

- (UITableView *)messageTableView {
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc]init];
        _messageTableView.frame = CGRectMake(0, NavigationControllerHeight, Message_WIDTH, Message_HEIGHT - NavigationControllerHeight);
        _messageTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        [_messageTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _messageTableView.tableFooterView = [UIView new];
        
    }
    return _messageTableView;
}


@end
