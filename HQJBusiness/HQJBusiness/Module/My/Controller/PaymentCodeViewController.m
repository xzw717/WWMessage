//
//  PaymentCodeViewController.m
//  HQJBusiness
//  收款码
//  Created by mymac on 2017/9/27.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "PaymentCodeViewController.h"
#import "PaymentCodeTableViewCell.h"
#import "AddPaymentCodeViewController.h"
#import "PaymentCodeViewModel.h"
#import "PaymentCodeModel.h"
@interface PaymentCodeViewController ()<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate>
@property (nonatomic, strong) UITableView *paymentCodeTableView;
@property (nonatomic, strong) NSMutableArray <PaymentCodeModel *>*listArray;
@property (nonatomic, strong) PaymentCodeViewModel *viewModel;
@end

@implementation PaymentCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"收款码";
    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.paymentCodeTableView];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    [rightBtn setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
    rightBtn.bounds = CGRectMake(0, 0, 60, 44);
    self.ZWrightOneButton = rightBtn;
    [rightBtn addTarget:self action:@selector(addCode) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setDataSource];
}

- (void)addCode {
    AddPaymentCodeViewController *addcode = [[AddPaymentCodeViewController alloc]init];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8", nil];
    for (PaymentCodeModel *model in self.listArray) {
        [array removeObject:model.useage];
    }
    addcode.codeTypelistArray = array;
    [self.navigationController pushViewController:addcode animated:YES];
}

- (void)setDataSource{
    @weakify(self);
    [self.viewModel paymentCodeRequstList:^(NSArray *models) {
        @strongify(self);
        if (models.count <= 0) {
            [SVProgressHUD showInfoWithStatus:@"还未绑定收款码，请添加收款码"];

        }
        [self.listArray removeAllObjects];
        [self.listArray addObjectsFromArray:models];
        [self.paymentCodeTableView reloadData];
    } codelistNull:^{

    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    PaymentCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PaymentCodeTableViewCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:60.f];
    [cell setTitleModel:self.listArray[indexPath.row]];
    return cell;
   
}

- (NSArray *)rightButtons {
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor whiteColor] icon:
     [UIImage imageNamed:@"icon_trash"]];

    return leftUtilityButtons;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)updateViewConstraints {
//    [self modifiDeleteBtn];
    [super updateViewConstraints];
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0: {
            NSIndexPath *cellIndexPath = [self.paymentCodeTableView indexPathForCell:cell];
            [self.viewModel paymentCodeDeletList:self.listArray[cellIndexPath.row].nid complete:^{
                [self.paymentCodeTableView reloadData];
            }];
            [self.listArray removeObjectAtIndex:cellIndexPath.row];
            [self.paymentCodeTableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        default:
            break;
    }
    
}
- (void)swipeableTableViewCell:(PaymentCodeTableViewCell *)cell scrollingToState:(SWCellState)state {
}

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (UITableView *)paymentCodeTableView {
    if (!_paymentCodeTableView) {
        _paymentCodeTableView = [[UITableView alloc]init];
        _paymentCodeTableView.frame = CGRectMake(0, NavigationControllerHeight + 5, WIDTH, HEIGHT - NavigationControllerHeight);
        _paymentCodeTableView.rowHeight = 60;
        _paymentCodeTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _paymentCodeTableView.delegate = self;
        _paymentCodeTableView.dataSource = self;
        _paymentCodeTableView.backgroundColor = [UIColor whiteColor];
        [_paymentCodeTableView registerClass:[PaymentCodeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PaymentCodeTableViewCell class])];
        _paymentCodeTableView.tableFooterView = [UIView new];
        _paymentCodeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _paymentCodeTableView;
}



- (PaymentCodeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PaymentCodeViewModel alloc]init];
    }
    return _viewModel;
}
@end
