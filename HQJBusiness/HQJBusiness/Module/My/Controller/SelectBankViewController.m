//
//  SelectBankViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/27.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SelectBankViewController.h"
#import "SelectBankViewModel.h"
#import "SelectBankCell.h"
#import "SelectBankModel.h"
#import "AddBankcCardViewController.h"
#import "HQJBusinessAlertView.h"


NSString *const kActionBank = @"actionBank";


@interface SelectBankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *bankTableView;
@property (nonatomic,strong)NSMutableArray * bankListArray;
@end

@implementation SelectBankViewController
- (UITableView *)bankTableView {
    if (!_bankTableView) {
        _bankTableView = [[UITableView alloc]initWithFrame: CGRectMake(0, NavigationControllerHeight + 10 , WIDTH, HEIGHT - NavigationControllerHeight - 10) style:UITableViewStylePlain];
//        _bankTableView.frame = CGRectMake(0, kNAVHEIGHT + 10 , WIDTH, HEIGHT - kNAVHEIGHT - 10);
        _bankTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _bankTableView.rowHeight = 75;
        _bankTableView.delegate = self;
        _bankTableView.dataSource = self;
        [_bankTableView registerClass:[SelectBankCell class] forCellReuseIdentifier:NSStringFromClass([SelectBankCell class])];
        _bankTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bankTableView.tableFooterView = [UIView new];
    }
    return _bankTableView;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requstBankCard];
    
}

#pragma mark --- 请求银行卡列表
- (void)requstBankCard {
    @weakify(self);
    [SelectBankViewModel selectBankBLock:^(id sender) {
        @strongify(self);
        [self.bankListArray removeAllObjects];
        [self.bankListArray addObjectsFromArray:sender];
        [self.bankTableView reloadData];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _bankListArray = [NSMutableArray array];
    self.zw_title = @"选择商家账户";
    [self.view addSubview:self.bankTableView];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    rightBtn.bounds = CGRectMake(0, 0, 22, 22);
    self.zw_rightOneButton = rightBtn;
    
    [rightBtn bk_addEventHandler:^(id  _Nonnull sender) {
        if (self.bankListArray.count >= 5) {
            HQJBusinessAlertView * alertView = [[HQJBusinessAlertView alloc]initWithisWarning:YES];
            [alertView zw_showAlertWithContent];
        }  else {
            
            AddBankcCardViewController *addVC = [[AddBankcCardViewController alloc]init];
            [self.navigationController pushViewController:addVC animated:YES];
        }
        

        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [RACObserve(self, bankListArray) subscribeNext:^(NSMutableArray *ary) {
        if (ary.count > 0) {
            rightBtn.hidden = YES;
        } else {
            rightBtn.hidden = NO;
        }
    }];
}
#pragma mark ---  UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.bankListArray.count != 0) {
        return self.bankListArray.count;
        
    } else {
        return 0;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectBankCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SelectBankCell class])forIndexPath:indexPath];
    if(self.bankListArray.count != 0) {
        cell.model = self.bankListArray[indexPath.row];
        
    }
    if (indexPath.row == self.bankListArray.count - 1) {
//        CellLine(cell);
        cell.lineView.hidden = YES;
    } else {
        cell.lineView.hidden = NO;
    }
    return cell;
    
}

#pragma mark ---  UITableView Delegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteCardRequst:indexPath.row];

        [self.bankListArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [self.bankTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setEditing:YES animated:YES];
    SelectBankModel *model = self.bankListArray[indexPath.row];
    NSDictionary *bankDic = [NSDictionary dictionary];
    bankDic = @{@"icon":model.bankDetail[@"bankIcon"],@"payName":model.bankDetail[@"bankName"],@"payAccount":model.bankCard,@"id":model.bid};
    [[NSNotificationCenter defaultCenter]postNotificationName:kActionBank object:nil userInfo:bankDic];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark --- 删除 银行卡
- (void)deleteCardRequst:(NSInteger)index {
    SelectBankModel *model = self.bankListArray[index];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBMerchantInterface,HQJBDeleteBankCardInterface];
    NSDictionary *dict = @{@"bankid":model.bid,@"memberid":MmberidStr};
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:strUrl parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"code"]integerValue] == 49000) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [[NSNotificationCenter defaultCenter]postNotificationName:kActionBank object:nil userInfo:@{@"deleted":model.bid}];
        } else {
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
        }
    } andError:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"删除失败"];

    } ShowHUD:YES];
    
    
}
@end
