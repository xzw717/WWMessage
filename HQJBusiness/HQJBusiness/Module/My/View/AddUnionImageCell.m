//
//  AddUnionImageCell.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/3.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddUnionImageCell.h"
#import "ZWActionSheetView.h"
#import "AddUnionActivityViewModel.h"
#define LeftMargin 10
@interface AddUnionImageCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@end
@implementation AddUnionImageCell
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc]initWithString:@"* 活动图片："];
        [attributed addAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(0, 1)];
        _nameLabel.attributedText = attributed;
    }
    return _nameLabel;
}
- (UIImageView *)contentImageView{
    if (_contentImageView == nil) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.image = [UIImage imageNamed:@"Addbox"];
        _contentImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showCamera)];
        [_contentImageView addGestureRecognizer:tap];
    }
    return _contentImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentImageView];
        
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)updateConstraints {
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(LeftMargin);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(LeftMargin);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [super updateConstraints];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showCamera{
    BOOL canCamera = [self canUserCamera];
    if (canCamera) {
        ZWActionSheetView *action = [[ZWActionSheetView alloc]initWithActionTitle:@"选择图片" action:@[@"拍照",@"从相册中选择"]];
        [action ActionStyleDestructive:@"取消"];
        [action showActionSheet];
        action.optionBlock = ^(NSString *optionsTitle,NSInteger index) {
            if ([optionsTitle isEqualToString:@"拍照"]) {
                [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
                
            } else {
                [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
            }
        };
    }
}
#pragma mark - 检查相机权限
- (BOOL)canUserCamera{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请打开相机权限" message:@"设置-隐私-相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView show];
        return NO;
    }
    else{
        return YES;
    }
    return YES;
}

- (void)showImagePicker:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate      = self;
    picker.sourceType    = type;
    picker.allowsEditing = YES;
    [[ManagerEngine currentViewControll] presentViewController:picker animated:YES completion:nil];
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([UIDevice currentDevice].systemVersion.floatValue < 11) {
        return;
    }
    if ([viewController isKindOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")]) {
        [viewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.frame.size.width < 42) {
                [viewController.view sendSubviewToBack:obj];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerEditedImage];
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBUploadImageInterface];
        [AddUnionActivityViewModel uploadImage:image andUrl:urlStr alertText:@"上传中" completion:^(NSURLResponse * _Nonnull response, id  _Nonnull responseObject, NSError * _Nonnull error, UIImage * _Nonnull image) {
            if (!error) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    NSData *resData = (NSData *)responseObject;
                    NSDictionary * dic =[NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:&error];
                    if (_uploadResultBlock) {
                        _uploadResultBlock(dic);
                    }
                    
                } else {
                    
                }
            }else{
                NSLog(@"error = %@",error);
            }
        }];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
