//
//  MessageSetVC.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/30.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageSetVC.h"
#import "MessageSetCell.h"

@interface MessageSetVC ()<UITableViewDelegate,UITableViewDataSource,MessageSetDelegate>
@property (nonatomic, strong) UITableView *messageSetTableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation MessageSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageTitle = @"消息设置";
    [self.view addSubview:self.messageSetTableView];
    self.dataArray = @[@{@"title":@"系统消息",@"switch":@"1"},
    @{@"title":@"会员注册消息",@"switch":@"1"},
    @{@"title":@"服务商注册消息",@"switch":@"0"},
    @{@"title":@"积分交易消息",@"switch":@"0"},
    @{@"title":@"退款/退换货消息",@"switch":@"1"}];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return self.dataArray.count;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MessageSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageSetCell class]) forIndexPath:indexPath];
    [cell titleContent:self.dataArray[indexPath.row][@"title"] switchState:[self.dataArray[indexPath.row][@"switch"] integerValue]];
    cell.delegate = self;
    return cell;
    
}
- (void)returnTitle:(NSString *)title switchState:(BOOL)state {
    NSLog(@"当前%@了%@的开关",state ? @"打开":@"关闭",title);
}
- (UITableView *)messageSetTableView {
    if (!_messageSetTableView) {
        _messageSetTableView = [[UITableView alloc]init];
        _messageSetTableView.frame = CGRectMake(0, NavigationControllerHeight, Message_WIDTH, Message_HEIGHT - NavigationControllerHeight);
        _messageSetTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _messageSetTableView.delegate = self;
        _messageSetTableView.dataSource = self;
        [_messageSetTableView registerClass:[MessageSetCell class] forCellReuseIdentifier:NSStringFromClass([MessageSetCell class])];
        _messageSetTableView.tableFooterView = [UIView new];
        _messageSetTableView.rowHeight = NewProportion(140.f);
        
    }
    return _messageSetTableView;
}

@end
