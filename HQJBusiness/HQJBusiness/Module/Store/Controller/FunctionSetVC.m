//
//  FunctionSetVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/27.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "FunctionSetVC.h"
#import "SetCell.h"
@interface FunctionSetVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *functionSetTableView;
@end

@implementation FunctionSetVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"功能设置";
    [self.view addSubview:self.functionSetTableView];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavType:HQJNavigationBarWhite];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 1;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SetCell class]) forIndexPath:indexPath];
    cell.textLabel.text = @"开店宝典关闭";
    cell.setSwitch.on =  [[[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"]  objectForKey:CreateStoreTreasureKey] boolValue];
    [cell setClickSwitchBlock:^(BOOL switchBlock) {
        [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"]  setObject:[NSNumber numberWithBool:switchBlock] forKey:CreateStoreTreasureKey];
        [[NSNotificationCenter defaultCenter] postNotificationName:CreateStoreTreasure object:nil userInfo:@{@"isHide":switchBlock?@"开":@"关"}];
    }];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
    
}
- (UITableView *)functionSetTableView {
    if (!_functionSetTableView) {
        _functionSetTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
//        _functionSetTableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        _functionSetTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _functionSetTableView.delegate = self;
        _functionSetTableView.dataSource = self;
        [_functionSetTableView registerClass:[SetCell class] forCellReuseIdentifier:NSStringFromClass([SetCell class])];
        _functionSetTableView.tableFooterView = [UIView new];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40/3.f)];
//        view.backgroundColor = [UIColor redColor];
        _functionSetTableView.tableHeaderView = view;
  
    }
    return _functionSetTableView;
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
