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
@end
