//
//  PersonInfoViewModel.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/4.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopInfoViewModel.h"
#import "ShopInfoCell.h"
#import "ShopInfoImageCell.h"
#import "ShopInfoTextCell.h"
#import "ShopInfoSetCell.h"

#import "UploadImagesViewController.h"

@interface ShopInfoViewModel ()
@property (nonatomic,strong)UIViewController *superVC;
@end
@implementation ShopInfoViewModel
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
    
    ShopInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopInfoCell class])];
    ShopInfoImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopInfoImageCell class])];
    ShopInfoTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopInfoTextCell class])];
    ShopInfoSetCell *setCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopInfoSetCell class])];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            imageCell.titleLabel.text = [self cellDataArray][indexPath.section][indexPath.row];
            if (indexPath.row == 0) {
                imageCell.imageArray = @[[UIImage imageNamed:@"tool_icon_top"]];
            }else{
                imageCell.imageArray = @[[UIImage imageNamed:@"tool_icon_top"],[UIImage imageNamed:@"tool_icon_top"],[UIImage imageNamed:@"tool_icon_top"]];
            }
            return imageCell;
        }else {
            cell.titleLabel.text = [self cellDataArray][indexPath.section][indexPath.row];
            if (indexPath.row == 2) {
                cell.textField.text = [NameSingle shareInstance].name;
            }else{
                cell.textField.text = [NameSingle shareInstance].mobile;
            }
            return cell;
        }
    
    }else if (indexPath.section == 1) {
        cell.titleLabel.text = [self cellDataArray][indexPath.section][indexPath.row];
        if (indexPath.row == 0) {
            cell.textField.text = [NameSingle shareInstance].name;
        }else{
            cell.textField.text = @"啊还是分开啦还是分开啦还是离开过哈萨克返回撒开发哈萨克啦发货啦可好看了洪水泛滥卡和饭卡上";
        }
        return cell;
    }else if (indexPath.section == 2){
        setCell.titleLabel.text = [self cellDataArray][indexPath.section][indexPath.row];
        setCell.setSwitch.on = YES;
        [setCell setClickSwitchBlock:^(BOOL switchBlock) {
        
        }];
        return setCell;
    }else{
        textCell.titleLabel.text = [self cellDataArray][indexPath.section][indexPath.row];
        textCell.textView.placeholder =[NSString stringWithFormat:@"请输入%@",[self cellDataArray][indexPath.section][indexPath.row]];
        return textCell;
    }
}

- (void)selectCellForIndex:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            UploadImagesViewController *uivc = [[UploadImagesViewController alloc]init];
            if (indexPath.row == 0 ) {
                uivc.isLogo = YES;
            }else{
                uivc.isLogo = NO;
            }
            [self.superVC.navigationController pushViewController:uivc animated:YES];
        
        }
    }
}

- (NSArray *)cellDataArray {
    if (!_cellDataArray) {
        _cellDataArray =@[@[@"店铺logo",@"店铺主图",@"商家名称",@"营业电话",@"所属区域",@"商家地址",@"分类",@"营业时间"],@[@"人均消费",@"折扣比列",@"RY值赠送比例"],@[@"免费WIFI",@"免费停车"],@[@"本店特色"],@[@"预定须知"],@[@"商家介绍"]];
    }
    return _cellDataArray;
}

@end
