//
//  MessageSetViewController.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/28.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageSetViewController.h"

@interface MessageSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *messageSetTableView;
@end

@implementation MessageSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"消息设置";

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return 6;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    return cell;
    
    
    
    
    
}

- (UITableView *)messageSetTableView {
    if (!_messageSetTableView) {
        _messageSetTableView = [[UITableView alloc]init];
        _messageSetTableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        _messageSetTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _messageSetTableView.delegate = self;
        _messageSetTableView.dataSource = self;
        [_messageSetTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _messageSetTableView.tableFooterView = [UIView new];
        
    }
    return _messageSetTableView;
}

@end
