//
//  VerificationOrderDetailsViewController.m
//  HQJBusiness
//
//  Created by mymac on 2017/9/13.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "VerificationOrderDetailsViewController.h"
#import "OrderDetailsHeaderView.h"
#import "OrderDetailFootView.h"
#import "VerificationOrderDetailsCell.h"
#import "ConsumerCodeViewModel.h"

@interface VerificationOrderDetailsViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *orderDetailsTableView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIImageView *watermarkImageView;
@property (nonatomic, strong) ConsumerCodeViewModel *viewModel;
@property (nonatomic, strong) OrderVerificationModel *model;
@property (nonatomic, strong) NSString *orderString;
@property (nonatomic, strong) NSString *codeString;
@property (nonatomic, strong) NSArray *listArray;
@end

@implementation VerificationOrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"订单详情";
    self.listArray = [NSArray array];
    [self setView];
    [self loadRequst];

}


- (instancetype)initWithOrderId:(NSString *)str consumerCode:(NSString *)code {
    self = [super init];
    if (self) {
        _orderString = str;
        _codeString  = code;

    }
    return self;
}

- (void)loadRequst {
    @weakify(self);
    [self.viewModel inquireGoods:_orderString complete:^(OrderVerificationModel *model) {
        @strongify(self);
        self.listArray = model.goodslist;
        self.model = model;
        [self.orderDetailsTableView reloadData];
    }];
}




- (void)setView {
    [self.view addSubview:self.orderDetailsTableView];
    [self.view addSubview:self.confirmButton];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.watermarkImageView];
    
   
    self.cancelButton.sd_layout.
    leftSpaceToView(self.view, kEDGE).
    rightSpaceToView(self.view, kEDGE).
    heightIs(44).
    bottomSpaceToView(self.view, 30);

    self.confirmButton.sd_layout.
    leftEqualToView(self.cancelButton).
    rightEqualToView(self.cancelButton).
    heightIs(44).
    bottomSpaceToView(self.cancelButton, 12);
    
    self.orderDetailsTableView.sd_layout.
    leftSpaceToView(self.view, 0).
    rightSpaceToView(self.view, 0).
    topSpaceToView(self.view, kNAVHEIGHT + 10 ).
    bottomSpaceToView(self.confirmButton, 10);
//    self.orderDetailsTableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    self.orderDetailsTableView.didFinishAutoLayoutBlock = ^(CGRect frame) {
            HQJLog(@"self.orderDetailsTableView.frame:%@\nself.confirmButton.frame:%@\nself.cancelButton.frame:%@",NSStringFromCGRect(frame),NSStringFromCGRect(self.confirmButton.frame),NSStringFromCGRect(self.cancelButton.frame));
    };

    
}


#pragma mark --- UITableViewDelegate  Source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return self.listArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsVerificationModel *goodsModel = self.model.goodslist[indexPath.row];
    VerificationOrderDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ordercell" forIndexPath:indexPath];
    [cell settitleImage:goodsModel.mainpicture name:goodsModel.goodsname price:goodsModel.goodsprice count:goodsModel.goodscount];
    return cell;
    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OrderDetailsHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"orderHeaderView"];
    view.orderNumber = _orderString;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    OrderDetailFootView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"orderFootView"];
    [view orderTime:[ManagerEngine reverseSwitchTimer:self.model.time] count:!self.model.count ?@"":self.model.count allPrice:[NSString stringWithFormat:@"%.2f",self.model.price]];
    return view;
}


#pragma mark --- 确定核销
- (void)confirm {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否确认核销消费码" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @weakify(self);
        [self.viewModel useConsumerCode:_codeString success:^{
            @strongify(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.listArray.count <= 1) {
                    self.watermarkImageView.sd_layout.topSpaceToView(self.view,94 + kNAVHEIGHT -10 ).rightSpaceToView(self.view, 62.5).heightIs(62.5).widthEqualToHeight();
                } else {
                    self.watermarkImageView.sd_layout.topSpaceToView(self.view, 94 + kNAVHEIGHT + 10 ).rightSpaceToView(self.view, 62.5).heightIs(62.5).widthEqualToHeight();
                }
            });
            
            self.watermarkImageView.hidden = NO;
            self.confirmButton.hidden      = YES;
            self.cancelButton.hidden       = YES;
            
            
            
        }];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
   
}


#pragma mark --- 取消
- (void)cancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableView *)orderDetailsTableView {
    if (!_orderDetailsTableView) {
        _orderDetailsTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _orderDetailsTableView.delegate = self;
        _orderDetailsTableView.dataSource = self;
        _orderDetailsTableView.rowHeight = 84;
        _orderDetailsTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _orderDetailsTableView.tableFooterView = view;
        [_orderDetailsTableView registerClass:[VerificationOrderDetailsCell class] forCellReuseIdentifier:@"ordercell"];
        [_orderDetailsTableView registerClass:[OrderDetailsHeaderView class] forHeaderFooterViewReuseIdentifier:@"orderHeaderView"];
        [_orderDetailsTableView registerClass:[OrderDetailFootView class] forHeaderFooterViewReuseIdentifier:@"orderFootView"];

    }
    return _orderDetailsTableView;
}


- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.backgroundColor = DefaultAPPColor;
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius  = 5.f;
        [_confirmButton setTitle:@"核销订单" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.layer.borderWidth  = 1.f;
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius  = 5.f;
        _cancelButton.layer.borderColor = DefaultAPPColor.CGColor;
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];

    
    }
    return _cancelButton;
}

- (UIImageView *)watermarkImageView {
    if (!_watermarkImageView) {
        _watermarkImageView = [[UIImageView alloc]init];
        _watermarkImageView.hidden = YES;
        _watermarkImageView.image = [UIImage imageNamed:@"icon_verification"];
    }
    return _watermarkImageView;
}

- (ConsumerCodeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ConsumerCodeViewModel alloc]init];
    }
    return _viewModel;
}

- (OrderVerificationModel *)model {
    if (!_model) {
        _model = [[OrderVerificationModel alloc]init];
    }
    return _model;
}

@end
