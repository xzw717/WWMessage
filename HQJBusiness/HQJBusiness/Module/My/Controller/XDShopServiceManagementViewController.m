//
//  XDShopServiceManagementViewController.m
//  HQJBusiness
//   XD商家服务费订单
//  Created by mymac on 2020/5/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDShopServiceManagementViewController.h"
#import "HQJSelectToolView.h"
#import "XDSSMTableViewCell.h"

@interface XDShopServiceManagementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView  *xdssmTableView;
@end

@implementation XDShopServiceManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zwTitLabel.text = @"XD商家服务费订单";
    HQJSelectToolView *view = [[HQJSelectToolView alloc]initWithTitleAry:@[@"支付成功",@"待付款"]];
      @weakify(self);
     [view setIndex:^(NSInteger indx) {
         @strongify(self);
     
     }];
       view.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, NewProportion(132));
       [self.view addSubview:view];
    [self.view addSubview:self.xdssmTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 2;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    XDSSMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XDSSMTableViewCell class]) forIndexPath:indexPath];
    return cell;
    
    
    
    
    
}

- (UITableView *)xdssmTableView {
    if (!_xdssmTableView) {
        _xdssmTableView = [[UITableView alloc]init];
        _xdssmTableView.frame = CGRectMake(0, NavigationControllerHeight + NewProportion(132), WIDTH, HEIGHT - NavigationControllerHeight - NewProportion(132));
        _xdssmTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _xdssmTableView.delegate = self;
        _xdssmTableView.dataSource = self;
        _xdssmTableView.rowHeight = NewProportion(520);
        [_xdssmTableView registerClass:[XDSSMTableViewCell class] forCellReuseIdentifier:NSStringFromClass([XDSSMTableViewCell class])];
        _xdssmTableView.tableFooterView = [UIView new];
        _xdssmTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _xdssmTableView.backgroundColor = [ManagerEngine getColor:@"f3f2f7"];
    }
    return _xdssmTableView;
}


@end
