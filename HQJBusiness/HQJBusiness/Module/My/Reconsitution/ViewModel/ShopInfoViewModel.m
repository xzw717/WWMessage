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

@interface ShopInfoViewModel ()<UITextFieldDelegate,UITextViewDelegate>{
    NSMutableDictionary *dataDict;
}
@property (nonatomic,strong)UIViewController *superVC;
@property (nonatomic,strong)NSMutableDictionary *tempDict;
@end
@implementation ShopInfoViewModel
- (instancetype)initWithViewContoller:(id)object
{
    self = [super init];
    if (self) {
        self.superVC = object;
        dataDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:self.shopModel.realname?self.shopModel.realname:@"",@"请输入商家名称",
                    self.shopModel.cardNo?self.shopModel.cardNo:@"",@"请输入营业电话",
self.shopModel.businessArea?self.shopModel.businessArea:@"",@"请输入所属区域",self.shopModel.address?self.shopModel.address:@"",@"请输入商家地址",self.shopModel.shophours?self.shopModel.shophours:@"",@"请输入营业时间",self.shopModel.percapita?self.shopModel.percapita:@"",@"请输入人均消费",self.shopModel.scoreRate?self.shopModel.scoreRate:@"",@"请输入折扣比列",self.shopModel.cashRate?self.shopModel.cashRate:@"",@"请输入RY值赠送比例",self.shopModel.feature?self.shopModel.feature:@"",@"请输入本店特色",self.shopModel.bookings?self.shopModel.bookings:@"",@"请输入预定须知",self.shopModel.information?self.shopModel.information:@"",@"请输入商家介绍",nil];
    }
    return self;
}
- (NSArray *)cellDataArray {
    if (!_cellDataArray) {
        _cellDataArray =@[@[@"店铺logo",@"店铺主图",@"商家名称",@"营业电话",@"所属区域",@"商家地址",@"分类",@"营业时间"],@[@"人均消费",@"折扣比列",@"RY值赠送比例"],@[@"免费WIFI",@"免费停车"],@[@"本店特色"],@[@"预定须知"],@[@"商家介绍"]];
    }
    return _cellDataArray;
}
- (NSMutableDictionary *)tempDict{
    if (!_tempDict) {
        _tempDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"realname",@"请输入商家名称",@"cardNo",@"请输入营业电话", @"businessArea",@"请输入所属区域",@"address",@"请输入商家地址",@"hophours",@"请输入营业时间",@"percapita",@"请输入人均消费",@"scoreRate",@"请输入折扣比列",@"cashRate",@"请输入RY值赠送比例",@"feature",@"请输入本店特色",@"bookings",@"请输入预定须知",@"information",@"请输入商家介绍",nil];
    }
     return _tempDict;
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
            cell.textField.placeholder = [NSString stringWithFormat:@"请输入%@",cell.titleLabel.text];
            [cell.textField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
            if ([dataDict.allKeys containsObject:cell.textField.placeholder]) {
                cell.textField.text = [dataDict valueForKey:cell.textField.placeholder];
            }
            return cell;
        }
    
    }else if (indexPath.section == 1) {
        cell.titleLabel.text = [self cellDataArray][indexPath.section][indexPath.row];
        cell.textField.placeholder = [NSString stringWithFormat:@"请输入%@",cell.titleLabel.text];
        [cell.textField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
        if ([dataDict.allKeys containsObject:cell.textField.placeholder]) {
            cell.textField.text = [dataDict valueForKey:cell.textField.placeholder];
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
        NSLog(@"textCell.textView.text = %@",textCell.textView.text);
        textCell.textView.infoBlock = ^(NSString *text, CGSize textViewSize) {
            
            [dataDict.allKeys enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
                if ([textCell.textView.placeholder isEqualToString:obj]) {
                    [dataDict setValue:text forKey:obj];
                    *stop = YES;
                }
            }];
        };

        if ([dataDict.allKeys containsObject:textCell.textView.placeholder]) {
            textCell.textView.text = [dataDict valueForKey:textCell.textView.placeholder];
        }
        return textCell;
    }
}

- (void)setShopModel:(ShopModel *)shopModel{
    
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

- (void)textFieldTextChange:(UITextField *)textField{
    [dataDict.allKeys enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        if ([textField.placeholder isEqualToString:obj]) {
            [dataDict setValue:textField.text forKey:obj];
            *stop = YES;
        }
    }];
}

- (void)updateShopInformation{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSString *key in dataDict.allKeys) {
        if (![[dataDict valueForKey:key] isEqualToString:@""]) {
            for (NSString *temp in self.tempDict.allKeys) {
                if ([key isEqualToString:temp]) {
                    [result setValue:[dataDict valueForKey:key] forKey:[self.tempDict valueForKey:temp]];
                }
            }
            
        }
    }
    [result setValue:MmberidStr forKey:@"uid"];
    NSLog(@"result = %@",result);
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJReconsitutionName,HQJBUpdateInformationInterface];
    HQJLog(@"地址：%@",urlStr);
    if (MmberidStr) {
        [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:result complete:^(NSDictionary *dic) {
            if ([dic[@"code"]integerValue] == 49000) {
                [ZGProgressHUD showSuccess:@"保存成功"];
            } else {
                [ZGProgressHUD showError:dic[@"msg"]];
            }
        } andError:^(NSError *error) {

        } ShowHUD:YES];
    }
    
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
