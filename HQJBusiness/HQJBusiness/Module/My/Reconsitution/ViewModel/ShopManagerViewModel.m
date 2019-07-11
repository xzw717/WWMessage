//
//  PersonInfoViewModel.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/4.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopManagerViewModel.h"
#import "ShopManagerCell.h"
#import "ShopInfoViewController.h"
#import "ContactManagerViewController.h"
@interface ShopManagerViewModel ()
@property (nonatomic,strong)UIViewController *superVC;
@end
@implementation ShopManagerViewModel
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
    
    ShopManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopManagerCell class]) forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.detailLabel.textColor= DefaultAPPColor;
        cell.detailLabel.text = @"去完善";
    }else if (indexPath.row == 1){
        cell.detailLabel.textColor= [UIColor blackColor];
        cell.detailLabel.text = @"99";
    }
    cell.titleLabel.text = [self cellDataArray][indexPath.row];
    return cell;


}

- (void)selectCellForIndex:(NSIndexPath *)index {
        switch (index.row) {
            case 0:{
                ShopInfoViewController *sivc =[[ShopInfoViewController alloc]init];
                [self.superVC.navigationController pushViewController:sivc animated:YES];
                break;
            }
                
            case 1:{
                ContactManagerViewController *cmvc =[[ContactManagerViewController alloc]init];
                [self.superVC.navigationController pushViewController:cmvc animated:YES];
                break;
            }
                
            case 2:{

                break;
            }
                
            default:
                break;
        }
    
    
}

- (NSArray *)cellDataArray {
    if (!_cellDataArray) {
        _cellDataArray =@[@"基本信息",@"合同管理",@"升级管理"];
    }
    return _cellDataArray;
}

@end
