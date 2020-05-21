//
//  XDPaySureViewController.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDPaySureViewController.h"

@interface XDPaySureViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *xdTableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UIButton *sureButton;
@property(nonatomic,strong) XDPayModel *model;
@end

@implementation XDPaySureViewController

- (instancetype)initWithXDPayModel:(XDPayModel *)model {
    self = [super init];
    if (self) {
        
        self.model = model;
        
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.zwNavView.backgroundColor = DefaultAPPColor;
    self.zw_title = @"订单详情";
    [self.view addSubview:self.xdTableView];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-271/3);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(812/3, 115/3));
    }];
    // Do any additional setup after loading the view.
}
#pragma mark --- lazy load
- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = @[@[@"收款方",@"第一时间科技投资股份有限公司"],@[@"支付方式",@"支付宝"],@[@"支付金额",self.model.paymoney],@[@"订单号",self.model.orderid],@[@"支付时间",self.model.paytime]];
    }
    return _dataArray;
}

-(UITableView *)xdTableView {
    if ( _xdTableView == nil ) {
        _xdTableView = [[UITableView alloc]init];
        _xdTableView.frame = CGRectMake(0, NavigationControllerHeight + 40/3, WIDTH, HEIGHT- NavigationControllerHeight - 40/3);
        _xdTableView.backgroundColor = DefaultBackgroundColor;
        _xdTableView.delegate = self;
        _xdTableView.dataSource = self;
        
        [_xdTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        
        _xdTableView.tableFooterView = [UIView new];
        
    }
    
    return _xdTableView;
}
- (UIButton *)sureButton{
    if ( _sureButton == nil ) {
        _sureButton = [[UIButton alloc]init];
        _sureButton.backgroundColor = DefaultAPPColor;
        _sureButton.layer.masksToBounds = YES;
        _sureButton.layer.cornerRadius = 115/6;
        [_sureButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:48/3];
        [self.view addSubview:_sureButton];

    }
    return _sureButton;
}
#pragma mark --- tableView  data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"XDPaySurecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [ManagerEngine getColor:@"909399"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = self.dataArray[indexPath.row][0];
    cell.detailTextLabel.textColor = [ManagerEngine getColor:@"000000"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.text = self.dataArray[indexPath.row][1];
    cell.detailTextLabel.backgroundColor = [UIColor greenColor];
    return cell;
    
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
