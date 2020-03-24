//
//  MineViewModel.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/2.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MineViewModel.h"

#import "MineCell.h"

#import "DealViewController.h"
#import "SetUpViewController.h"
#import "DeccaDownloadViewController.h"
#import "InformationViewController.h"
#import "AccSecViewController.h"
#import "ShopManagerViewController.h"


#import "ShopModel.h"

@interface MineViewModel ()
@property (nonatomic,strong)UIViewController *superVC;
@end
@implementation MineViewModel
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
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineCell class]) forIndexPath:indexPath];
    cell.itemArray = [self cellDataArray][indexPath.section][indexPath.row];
    return cell;
}
- (void)selectCellForIndex:(NSIndexPath *)index {
    
    if (index.section == 0) {

        ShopManagerViewController *smvc =[[ShopManagerViewController alloc]init];
        [self.superVC.navigationController pushViewController:smvc animated:YES];
        
    }else if (index.section == 1) {
        switch (index.row) {
            case 0:{
                AccSecViewController *asvc =[[AccSecViewController alloc]init];
                [self.superVC.navigationController pushViewController:asvc animated:YES];
            }
                
                break;
            case 1:{
                InformationViewController *ifvc =[[InformationViewController alloc]init];
                [self.superVC.navigationController pushViewController:ifvc animated:YES];
                break;
            }
            case 2:{
                // 交易
                DealViewController *DVC = [[DealViewController alloc]init];
                [self.superVC.navigationController pushViewController:DVC animated:YES];
                break;
            }
            case 3:{
                DeccaDownloadViewController *deccaVC = [[DeccaDownloadViewController alloc]init];
                [self.superVC.navigationController pushViewController:deccaVC animated:YES];
                break;
            }
                
            default:
                break;
        }
    }else {
        SetUpViewController *setVC = [[SetUpViewController alloc]init];
        [self.superVC.navigationController pushViewController:setVC animated:YES];
    }
    
    
}

- (NSArray *)cellDataArray {
    if (!_cellDataArray) {
        _cellDataArray =@[@[@[@"店铺管理",@"my_icon_shop"]],
                          @[@[@"账号安全",@"my_icon_safe"],@[@"账户管理",@"my_icon_account"],@[@"交易管理",@"my_icon_transaction"],@[@"台卡下载",@"my_icon_download"]],
                          @[@[@"设置",@"my_icon_Setup"]]];
    }
    return _cellDataArray;
}
- (void)myRequst {
    NSMutableDictionary *dict = @{@"memberid":MmberidStr}.mutableCopy;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJReconsitutionName,HQJBShopInformationInterface];
    HQJLog(@"地址：%@",urlStr);
    if (MmberidStr) {
        [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
            ShopModel *model = [ShopModel mj_objectWithKeyValues:dic[@"result"]];
            [NameSingle shareInstance].subCompanyName = dic[@"result"][@"subCompanyName"];// --- 单例存子公司名字
            if (self.myrequstBlock) {
                self.myrequstBlock(model);
            }
        } andError:^(NSError *error) {
            if (self.myrequstErrorBlock) {
                self.myrequstErrorBlock();
            }
        } ShowHUD:YES];
    }
    
    
}


@end
