//
//  PersonInfoViewModel.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/4.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "PersonInfoViewModel.h"
#import "PersonInfoCell.h"
#import "PersonInfoImageCell.h"
#import "SignNameViewController.h"
#import "UploadImageViewModel.h"

@interface PersonInfoViewModel ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,strong)UIViewController *superVC;
@property (nonatomic,strong)UploadImageViewModel *uploadViewModel;
@property (nonatomic,strong)ShopDetailModel *model;
@end
@implementation PersonInfoViewModel
- (instancetype)initWithViewContoller:(id)object
{
    self = [super init];
    if (self) {
        self.superVC = object;
    }
    return self;
}
- (UploadImageViewModel *)uploadViewModel {
    if (!_uploadViewModel) {
        _uploadViewModel = [[UploadImageViewModel alloc]init];
    }
    return _uploadViewModel;
}

#pragma mark --- 剥离控制器中的cell
- (UITableViewCell *)cellManageWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     if (indexPath.row == 1||indexPath.row == 2||indexPath.row == 6) {
        PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonInfoCell class]) forIndexPath:indexPath];
        if (indexPath.row == 1||indexPath.row == 2) {
            if (indexPath.row == 1) {
                cell.detailLabel.text = self.model.merchantsname;
            } else {
                cell.detailLabel.text = [NameSingle shareInstance].mobile;
            }
        } else {
            cell.detailLabel.textColor = [ManagerEngine getColor:@"13ce67"];
            
            cell.detailLabel.text = @"已实名";
            CellLine(cell);
        }
        cell.titleLabel.text = [self cellDataArray][indexPath.row];
        return cell;
    }else{
        
        PersonInfoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonInfoImageCell class]) forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.style = CellStyleBigImage;
            cell.iconImageView.image = [UIImage imageNamed:@""];
        } else if (indexPath.row == 3){
            cell.style = CellStyleImage;
            cell.iconImageView.image = [UIImage imageNamed:@"my_icon_ewm_black"];
        }
        cell.titleLabel.text = [self cellDataArray][indexPath.row];
        return cell;
    
    }

    
}

- (void)selectCellForIndex:(NSIndexPath *)index {
        switch (index.row) {
            case 0:
                [self.uploadViewModel uploadImageWithViewController:self.superVC andImageType:3 completion:^(NSString * result) {
                    NSLog(@"result = %@",result);
                    
                }];
                break;
                
            case 1:
                
            case 2:
                
            case 3:
                
            case 4:{
                SignNameViewController *sv = [[SignNameViewController alloc]init];
                [self.superVC.navigationController pushViewController:sv animated:YES];
            }
                    
            case 5:
                
                
            default:
                break;
        }
    
    
}

- (NSArray *)cellDataArray {
    if (!_cellDataArray) {
        _cellDataArray =@[@"头像",@"姓名",@"手机号码",@"我的二维码",@"个性签名",@"我的名片",@"实名认证",];
    }
    return _cellDataArray;
}
-(void)requestShopDetail{
    NSMutableDictionary *dict = @{@"mid":MmberidStr}.mutableCopy;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJReconsitutionName,HQJBShopDetailInterface];
    HQJLog(@"地址：%@",urlStr);
    if (MmberidStr) {
        [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
            self.model = [ShopDetailModel mj_objectWithKeyValues:dic[@"result"]];
        } andError:^(NSError *error) {
        } ShowHUD:YES];
    }
}

@end
