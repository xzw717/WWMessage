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
#import "ZWActionSheetView.h"

@interface PersonInfoViewModel ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,strong)UIViewController *superVC;
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

#pragma mark --- 剥离控制器中的cell
- (UITableViewCell *)cellManageWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     if (indexPath.row == 1||indexPath.row == 2||indexPath.row == 6) {
        PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonInfoCell class]) forIndexPath:indexPath];
        if (indexPath.row == 1||indexPath.row == 2) {
            if (indexPath.row == 1) {
                cell.detailLabel.text = [NameSingle shareInstance].name;
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
            case 0:{
                BOOL canCamera = [self canUserCamear];
                if (canCamera) {
                    ZWActionSheetView *action = [[ZWActionSheetView alloc]initWithActionTitle:@"设置头像" action:@[@"大图预览",@"拍照",@"从相册中选择"]];
                    [action ActionStyleDestructive:@"取消"];
                    [action showActionSheet];
                    action.optionBlock = ^(NSString *optionsTitle,NSInteger index) {
                        if ([optionsTitle isEqualToString:@"大图预览"]) {
                            [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
                            
                        }else if ([optionsTitle isEqualToString:@"拍照"]) {
                            [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
                            
                        } else {
                            [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
                        }
                    };
                }
                break;
            }
                
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

- (void)showImagePicker:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate      = self;
    picker.sourceType    = type;
    picker.allowsEditing = YES;
    [self.superVC presentViewController:picker animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
//        [self uploadImage:image];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 检查相机权限
- (BOOL)canUserCamear{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请打开相机权限" message:@"设置-隐私-相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alertView.tag = 100;
        [alertView show];
        return NO;
    }
    else{
        return YES;
    }
    return YES;
}
@end
