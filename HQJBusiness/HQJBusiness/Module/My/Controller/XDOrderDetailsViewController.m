//
//  XDOrderDetailsViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/20.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDOrderDetailsViewController.h"
#import "XDSSMModel.h"
#import "XDOrderDetailsTableViewCell.h"
@interface XDOrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *wwTitleLabel;
@property (nonatomic, strong) UILabel *priceTitleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) XDSSMModel *model;

@property (nonatomic, strong) UITableView *xdOrderDetailsTableView;
@property (nonatomic, strong) NSArray *titArtray;
@property (nonatomic, strong) NSArray *subTitArtray;

@end

@implementation XDOrderDetailsViewController
- (instancetype)initWithXDSSMModel:(XDSSMModel *)model {
    self = [super init];
    if (self) {
        self.model = model;
        self.titArtray  = @[@"支付状态",@"商品名称",@"支付时间",@"支付方式",@"订单号码"];
        self.subTitArtray = @[@"支付成功",!model.proname ? @"" :model.proname ,!model.paytime ? @"" : model.paytime,!model.paywayname?@"":model.paywayname,!model.orderid?@"":model.orderid];
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"订单详情";
    [self addView];
 
}
- (void)addView {
    [self.view addSubview:self.xdOrderDetailsTableView];
     self.view.backgroundColor = [UIColor whiteColor];
    
    self.logoImageView = [[UIImageView alloc]init];
    self.logoImageView.image = [UIImage imageNamed:@"logowuwumap_big"];
    [self.view addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(NavigationControllerHeight + NewProportion(88));
    }];
    
    self.wwTitleLabel = [[UILabel alloc]init];
    self.wwTitleLabel.text = @"第一时间科技投资股份有限公司";
    self.wwTitleLabel.textColor = [ManagerEngine getColor:@"000000"];
    self.wwTitleLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
    [self.view addSubview:self.wwTitleLabel];
    [self.wwTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.logoImageView.mas_bottom).mas_offset(NewProportion(47));
    }];
    
    self.priceTitleLabel = [[UILabel alloc]init];
     self.priceTitleLabel.text = @"支付金额";
     self.priceTitleLabel.textColor = [ManagerEngine getColor:@"969799"];
     self.priceTitleLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
     [self.view addSubview:self.priceTitleLabel];
     [self.priceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.wwTitleLabel.mas_bottom).mas_offset(NewProportion(74));
     }];
    
    self.priceLabel = [[UILabel alloc]init];
    NSMutableAttributedString *arttirbu = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@",self.model.ordermoney]];
     [arttirbu setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} range:NSMakeRange(1, self.model.ordermoney.length)];
     self.priceLabel.attributedText = arttirbu;
     self.priceLabel.textColor = [ManagerEngine getColor:@"ff4949"];
     self.priceLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
     [self.view addSubview:self.priceLabel];
     [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.priceTitleLabel.mas_bottom).mas_offset(NewProportion(49));
     }];
    
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [ManagerEngine getColor:@"e5e5e5"];
    [self.view addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(70));
        make.right.mas_equalTo(-NewProportion(70));
        make.height.mas_equalTo(0.5);
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.titArtray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XDOrderDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XDOrderDetailsTableViewCell class]) forIndexPath:indexPath];
    [cell setTitLabel:self.titArtray[indexPath.row] subTitle:self.subTitArtray[indexPath.row]];
    return cell;
    
    
    
    
    
}

- (UITableView *)xdOrderDetailsTableView {
    if (!_xdOrderDetailsTableView) {
        _xdOrderDetailsTableView = [[UITableView alloc]init];
        _xdOrderDetailsTableView.frame = CGRectMake(0, NavigationControllerHeight + NewProportion(584), WIDTH, HEIGHT - NavigationControllerHeight - NewProportion(584));
        _xdOrderDetailsTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _xdOrderDetailsTableView.delegate = self;
        _xdOrderDetailsTableView.dataSource = self;
        [_xdOrderDetailsTableView registerClass:[XDOrderDetailsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([XDOrderDetailsTableViewCell class])];
        _xdOrderDetailsTableView.tableFooterView = [UIView new];
        _xdOrderDetailsTableView.backgroundColor = [UIColor whiteColor];
        _xdOrderDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _xdOrderDetailsTableView.scrollEnabled = NO;
    }
    return _xdOrderDetailsTableView;
}

@end
