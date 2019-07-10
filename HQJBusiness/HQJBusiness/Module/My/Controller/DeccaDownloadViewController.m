//
//  DeccaDownloadViewController.m
//  HQJBusiness
//
//  Created by mymac on 2017/9/15.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "DeccaDownloadViewController.h"
#import "DeccaView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "SavePhotosTool.h"
@interface DeccaDownloadViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) DeccaView *dview;
@property (nonatomic, strong) UIImageView *textImageView;
@property (nonatomic, strong) UIImageView *deccaImageView;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *goPhotoAlbumButton;
@property (nonatomic, strong) UILabel *suggestLabel;
@property (nonatomic, strong) UIImage *savedImage;

@end

/// 绘制图片的大小
static CGFloat const kPhotoAssetWidth = 620.f;
static CGFloat const kPhotoAssetHeight = 874.f;

@implementation DeccaDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"台卡下载";
    [self addView];
    [self setLayout];
    
    [self requstFid:^(NSString *fid, NSString *mobile, NSString *realname) {
        self.savedImage = [self drawImageAtImageContextfid:fid mobile:mobile realname:realname];
        self.deccaImageView.image = self.savedImage;
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navType = HQJNavigationBarBlue;
}
- (void)addView {
    [self.view addSubview:self.deccaImageView];
    [self.view addSubview:self.saveButton];
    [self.view addSubview:self.goPhotoAlbumButton];
    [self.view addSubview:self.suggestLabel];
}

- (void)setLayout {
    self.deccaImageView.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view,50).heightIs(564.f / 1136.f * HEIGHT).widthIs(400.f / 640.f * WIDTH);
    [self.suggestLabel setSingleLineAutoResizeWithMaxWidth:WIDTH / 2];
    self.suggestLabel.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.deccaImageView, 13).heightIs(12);
    self.saveButton.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.deccaImageView, 40).heightIs(45).widthIs(WIDTH/2.f);
    self.goPhotoAlbumButton.sd_layout.centerXEqualToView(self.saveButton).topSpaceToView(self.saveButton, 20).heightIs(15).widthIs(WIDTH / 2);
}

#pragma mark 利用位图上下文添加水印效果
-(UIImage *)drawImageAtImageContextfid:(NSString *)fid mobile:(NSString *)mobile realname:(NSString *)realname{
    
   
    //获得一个位图图形上下文
    CGSize size=CGSizeMake(kPhotoAssetWidth, kPhotoAssetHeight);//画布大小
    UIGraphicsBeginImageContext(size);
    
    UIImage *image=[UIImage imageNamed:@"kabg.png"];
    [image drawInRect:CGRectMake(0, 0, kPhotoAssetWidth, kPhotoAssetHeight)];//注意绘图的位置是相对于画布顶点而言，不是屏幕
    
    /// 绘制二维码 2480 3508
    UIImage *CodeImage = [ManagerEngine createNonInterpolatedUIImageFormCIImage:[ManagerEngine outputImageStr:[NSString stringWithFormat:@"%@static/?fid=%@&sid=%@",HQJBBonusDomainDeccaName,fid,mobile]] withSize:203];
    [CodeImage drawInRect:CGRectMake(209, 395, 203, 203)];//注意绘图的位置是相对于画布顶点而言，不是屏幕
    
    /// 绘制店名
    CGFloat nameStrWidth = [realname sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30]}].width;
  
    CGFloat NameStrX = (kPhotoAssetWidth - nameStrWidth)/2;
    [realname drawInRect:CGRectMake(NameStrX, 299, nameStrWidth, 40) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30],NSForegroundColorAttributeName:[ManagerEngine getColor:@"0e3481"]}];
    
    /// 绘制手机号
    CGFloat telephoneStrWidth = mobile.length * 30.5;
//    CGFloat telephoneStrX = (1181 - telephoneStrWidth)/2;
    [mobile drawInRect:CGRectMake(315, 698, telephoneStrWidth, 30.5) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30],NSForegroundColorAttributeName:[UIColor whiteColor]}];
  
    
    //返回绘制的新图形
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    //最后一定不要忘记关闭对应的上下文
    UIGraphicsEndImageContext();
    
    return newImage;

        
   
}


#pragma mark --- 请求fid
- (void)requstFid:(void(^)(NSString *fid,NSString *mobile,NSString *realname))complete {
    NSString *codeStr = [NameSingle shareInstance].memberid;
    if (codeStr) {
        NSMutableDictionary *dict = @{@"memberid":codeStr}.mutableCopy;
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetMerchantBasicInfoInterface];
        [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict  complete:^(NSDictionary *dic) {
            complete(dic[@"result"][@"fid"],dic[@"result"][@"mobile"],dic[@"result"][@"realname"]);
        } andError:^(NSError *error) {
            
        } ShowHUD:YES];
    }
}



- (void)snapAction:(UIButton *)btn {
//        UIImageWriteToSavedPhotosAlbum([self drawImageAtImageContext], self , @selector(image:didFinishSavingWithError:contextInfo:), nil);//保存图片到照片库
//    [self setPermissions];
    [SavePhotosTool judgePHAuthorizationStatus:self.savedImage];
}

- (void)goAlbum {
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    if(author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
        //无权限
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存失败,请开启相册访问权限后重试" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //无权限 引导去开启
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                
                [[UIApplication sharedApplication] openURL:url];
                
            }
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        NSString *url = @"photos-redirect://app/";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }

    
  
}



- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton addTarget:self action:@selector(snapAction:) forControlEvents:UIControlEventTouchUpInside];
        _saveButton.backgroundColor  = [ManagerEngine getColor:@"18abf5"];
        _saveButton.layer.masksToBounds = YES;
        _saveButton.layer.cornerRadius = 45/2;
        [_saveButton setTitle:@"保存到相册" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _saveButton;
}

- (UIImageView *)textImageView {
    if (!_textImageView) {
        _textImageView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH -200) / 2, 50, 200, 282)];
    }
    return _textImageView;
}

- (UILabel *)suggestLabel {
    if (!_suggestLabel) {
        _suggestLabel = [[UILabel alloc]init];
        _suggestLabel.font = [UIFont systemFontOfSize:12.0];
        _suggestLabel.textColor = [UIColor redColor];
        _suggestLabel.text = @"建议使用A6照片纸打印";
    }
    return _suggestLabel;
}

- (DeccaView *)dview {
    if (!_dview) {
        _dview = [[DeccaView alloc]init];
        _dview.frame = CGRectMake((WIDTH -200) / 2, 50, 200, 282);
    }
    return _dview;
}

- (UIButton *)goPhotoAlbumButton {
    if (!_goPhotoAlbumButton) {
        _goPhotoAlbumButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _goPhotoAlbumButton.backgroundColor = [UIColor redColor];
        [_goPhotoAlbumButton addTarget:self action:@selector(goAlbum) forControlEvents:UIControlEventTouchUpInside];
        [_goPhotoAlbumButton setTitle:@"进入相册查看" forState:UIControlStateNormal];
        [_goPhotoAlbumButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        _goPhotoAlbumButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"进入相册查看"];
        NSRange strRange = {0,[str length]};
//        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [str addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSUnderlineColorAttributeName:DefaultAPPColor} range:strRange];
//        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];

        [_goPhotoAlbumButton setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _goPhotoAlbumButton;
}

- (UIImageView *)deccaImageView {
    if (!_deccaImageView) {
        _deccaImageView = [[UIImageView alloc]init];
    }
    return _deccaImageView;
}

@end
