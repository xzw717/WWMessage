//
//  AddPaymentCodeViewController.m
//  HQJBusiness
//
//  Created by mymac on 2017/9/30.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddPaymentCodeViewController.h"
#import "PaymentCodeTableViewCell.h"
#import "ScanViewController.h"

@interface AddPaymentCodeViewController () <UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate>
@property (nonatomic, strong) UITableView *addPaymentCodeTableView;
@property (nonatomic, strong) NSMutableArray *codeDateSource;
@property (nonatomic, strong) UILabel *hintLabel;
@end

@implementation AddPaymentCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"添加收款码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.addPaymentCodeTableView];
    [self.view addSubview:self.hintLabel];
    [self.hintLabel setSingleLineAutoResizeWithMaxWidth:WIDTH / 2];
    self.hintLabel.sd_layout.leftSpaceToView(self.view, kEDGE).topSpaceToView(self.view, NavigationControllerHeight  +5).heightIs(20);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addSuccess:) name:@"addCodeSuccess" object:nil];

}

- (void)addSuccess:(NSNotification *)infos {
    [self.codeTypelistArray removeObject:infos.userInfo[@"codeType"]];
    [self.addPaymentCodeTableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableView *)addPaymentCodeTableView {
    if (!_addPaymentCodeTableView) {
        _addPaymentCodeTableView = [[UITableView alloc]init];
        _addPaymentCodeTableView.frame = CGRectMake(0, NavigationControllerHeight+5 + 20, WIDTH -kEDGE, HEIGHT - NavigationControllerHeight - 5);
        _addPaymentCodeTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _addPaymentCodeTableView.backgroundColor = [UIColor whiteColor];
        _addPaymentCodeTableView.delegate = self;
        _addPaymentCodeTableView.rowHeight = 60;
        _addPaymentCodeTableView.dataSource = self;
        [_addPaymentCodeTableView registerClass:[PaymentCodeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PaymentCodeTableViewCell class])];
        _addPaymentCodeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _addPaymentCodeTableView.tableFooterView = [UIView new];
        
    }
    return _addPaymentCodeTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
        return self.codeTypelistArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PaymentCodeTableViewCell class]) forIndexPath:indexPath];
    [cell setPaymentCodeType:self.codeTypelistArray[indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ScanViewController *SVC =[[ScanViewController alloc]init];
    SVC.isAddCode = YES;
    SVC.addcodeType =  self.codeTypelistArray[indexPath.row];
    [self presentViewController:SVC animated:YES completion:nil];
   
}


- (NSArray *)rightButtons {
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor whiteColor] icon:
     [UIImage imageNamed:@"icon_trash"]];
    
    return leftUtilityButtons;
}

- (NSMutableArray *)codeDateSource {
    if (!_codeDateSource) {
        _codeDateSource = [NSMutableArray array];
        [_codeDateSource addObjectsFromArray:@[@"合其家",
                                               @"支付宝",
                                               @"微信支付",
                                               @"收钱吧",
                                               @"百度钱包",
                                               @"QQ钱包",
                                               @"京东钱包",
                                               @"其他平台"]];
    }
    return _codeDateSource;
}


- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc]init];
        _hintLabel.text = @"请绑定本店平台的收款码";
        _hintLabel.textColor = [UIColor blackColor];
        _hintLabel.font = [UIFont systemFontOfSize:13.f];
    }
    return _hintLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
