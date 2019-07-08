//
//  MineViewModel.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/2.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MineViewModel.h"

#import "MineCell.h"
#import "MineLogoutCell.h"
#import "JPUSHService.h"
#import "LoginViewController.h"
#import "DealViewController.h"
#import "SetUpViewController.h"
#import "DeccaDownloadViewController.h"
#import "InformationViewController.h"
#import "AppDelegate.h"

#import "MyModel.h"

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
    if (indexPath.section < self.cellDataArray.count - 1) {
        MineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineCell class]) forIndexPath:indexPath];
        cell.itemArray = [self cellDataArray][indexPath.section][indexPath.row];
        return cell;
    }else{
        MineLogoutCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineLogoutCell class]) forIndexPath:indexPath];
        return cell;
        
    }
    
    
}

- (void)selectCellForIndex:(NSIndexPath *)index {
    
    if (index.section == 0) {
        
    }else if (index.section == 1) {
        switch (index.row) {
            case 0:
                
                break;
            case 1:{
                InformationViewController *IFVC =[[InformationViewController alloc]init];
                [self.superVC.navigationController pushViewController:IFVC animated:YES];
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
    }else if (index.section == 2) {
        SetUpViewController *setVC = [[SetUpViewController alloc]init];
        [self.superVC.navigationController pushViewController:setVC animated:YES];
    }else{
        [self removeData];
        [self.superVC.navigationController popViewControllerAnimated:YES];
        
        LoginViewController *loginVC =[[LoginViewController alloc]init];
        ZWNavigationController *Nav= [[ZWNavigationController alloc]initWithRootViewController:loginVC];
        AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        
        [UIView transitionWithView:delegate.window
                          duration:0.5
                           options: UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            delegate.window.rootViewController = Nav;
                            
                        }
                        completion:nil];
    }
    
    
}

- (NSArray *)cellDataArray {
    if (!_cellDataArray) {
        _cellDataArray =@[@[@[@"店铺管理",@"my_icon_shop"]],
                          @[@[@"账号安全",@"my_icon_safe"],@[@"账户管理",@"my_icon_account"],@[@"交易管理",@"my_icon_transaction"],@[@"台卡下载",@"my_icon_download"]],
                          @[@[@"设置",@"my_icon_Setup"]],
                          @[@"退出登录"]];
    }
    return _cellDataArray;
}
- (void)myRequst {
    NSMutableDictionary *dict = @{@"memberid":MmberidStr}.mutableCopy;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetMerchantInfoInterface];
    HQJLog(@"地址：%@",urlStr);
    if (MmberidStr) {
        [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
            MyModel *model = [MyModel mj_objectWithKeyValues:dic[@"result"]];
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

#pragma mark --
#pragma mark --- 删除用户信息
-(void)removeData {
    
    [FileEngine fileRemove:fileLoginStyle];    //  ---用户登录信息
    [FileEngine fileRemove:fileDefaultStyle];  // ---手机号等信息
    [FileEngine fileRemove:fileHomeDataStyle];  // -- 积分信息
    [FileEngine fileRemove:filePathlocationStyle]; // --- 用户类型
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"%ld %@ %ld",iResCode,iAlias,seq);
        if (iResCode) {
            
        }
        
    } seq:1];
    [JPUSHService removeNotification:nil];
}
@end
