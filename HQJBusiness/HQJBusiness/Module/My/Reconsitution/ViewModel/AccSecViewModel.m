//
//  PersonInfoViewModel.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/4.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AccSecViewModel.h"
#import "AccSecInfoCell.h"
#import "ChangeTradePWViewController.h"
#import "ChangeLoginPswViewController.h"
#import "PaymentCodeViewController.h"
#import "ChangeMobileViewController.h"
@interface AccSecViewModel ()
@property (nonatomic,strong)UIViewController *superVC;
@end
@implementation AccSecViewModel
- (instancetype)initWithViewContoller:(id)object
{
    self = [super init];
    if (self) {
        self.superVC = object;
    }
    return self;
}

#pragma mark --- 剥离控制器中的cell
- (UITableViewCell *)cellManageWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AccSecInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AccSecInfoCell class]) forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.detailLabel.text = [NameSingle shareInstance].mobile ? [[NameSingle shareInstance].mobile  stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"] :@"";
    }
    cell.titleLabel.text = [self cellDataArray][indexPath.row];
    return cell;


}

- (void)selectCellForIndex:(NSIndexPath *)index {
        switch (index.row) {
            case 0:{
                ChangeMobileViewController *cmvc =[[ChangeMobileViewController alloc]init];
                [self.superVC.navigationController pushViewController:cmvc animated:YES];
                break;
            }
                
            case 1:{
                ChangeLoginPswViewController *clvc =[[ChangeLoginPswViewController alloc]init];
                [self.superVC.navigationController pushViewController:clvc animated:YES];
                break;
            }
                
            case 2:{
                ChangeTradePWViewController *ctvc =[[ChangeTradePWViewController alloc]init];
                [self.superVC.navigationController pushViewController:ctvc animated:YES];
                break;
            }
                
            case 3:{
                PaymentCodeViewController * pcvc = [[PaymentCodeViewController alloc]init];
                [self.superVC.navigationController pushViewController:pcvc animated:YES];
                break;
            }
                
                
            default:
                break;
        }
    
    
}

- (NSArray *)cellDataArray {
    if (!_cellDataArray) {
        _cellDataArray =@[@"绑定手机",@"修改登录密码",@"修改交易密码",@"收款码设置"];
    }
    return _cellDataArray;
}

@end
