//
//  SavePhotosTool.m
//  保存图片到自定义相簿中
//
//  Created by 徐流洋 on 2017/6/21.
//  Copyright © 2017年 南京南达尚诚软件科技有限公司. All rights reserved.
//

#import "SavePhotosTool.h"

@implementation SavePhotosTool

static SavePhotosTool *share;

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [SavePhotosTool new];
    });
    return share;
}

+ (void)judgePHAuthorizationStatus:(UIImage *)image{
    [self.shareManager judgePHAuthorizationStatus:image];
}

- (void)judgePHAuthorizationStatus:(UIImage *)image{
    
    //        PHAuthorizationStatusNotDetermined = 0,    用户还没有做出选择
    //        PHAuthorizationStatusDenied,               用户拒绝当前应用访问相册（用户当初点击了“不允许”）
    //        PHAuthorizationStatusAuthorized            用户允许当前应用访问相册（用户当初点击了“好”）
    //        PHAuthorizationStatusRestricted,           因为家长控制，导致应用无法访问相册（跟用户的选择没有关系）
    
    //0.判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) {         //因为家长控制，导致应用无法访问相册（跟用户的选择没有关系）
        NSLog(@"因为系统原因，无法访问相册");
    }else if (status == PHAuthorizationStatusDenied){        //用户拒绝当前应用访问相册（用户当初点击了“不允许”）
        /// 没有获得权限
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存失败,请开启相册访问权限后重试" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //无权限 引导去开启
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                
                [[UIApplication sharedApplication] openURL:url];
                
            }
        }]];
        [[ManagerEngine currentViewControll] presentViewController:alert animated:YES completion:nil];
        
    }else if (status == PHAuthorizationStatusAuthorized){    //用户允许当前应用访问相册（用户当初点击了“好”）
        [self saveImage:image];
    }else if (status == PHAuthorizationStatusNotDetermined){ //用户还没有做出选择
        //弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) { //用户点击了好
                [self saveImage:image];
            }
        }];
    }
}

- (void)saveImage:(UIImage *)image{
    
    //PHAsset:一个资源，比如：一张图片/一段视频
    //PHAssectCollection:一个相簿
    
    //如果想对“相册”进行修改（增删改），那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary] 的performChanges方法的block中
    
    //PHAsset的标识，利用这个标识可以找到对应的PHAsset对象（图片对象）
    __block NSString *assetLocalIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //1.保存图片A到“相机胶卷”
        //创建图片的请求
        assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
    }completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [self showError:@"保存图片到【相机胶卷】中失败"];
            return ;
        }
        //2.获得相簿
        PHAssetCollection *createAssetCollection = [self createAssetCollection];
        if (createAssetCollection == nil) {
            [self showError:@"创建相簿失败！"];
            return;
        }
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //3.添加刚保存到“相机胶卷”中的图片，到“相簿”中
            //获得图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
            //添加图片到相簿中的请求
            PHAssetCollectionChangeRequest *request =  [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createAssetCollection];
            //添加图片到相簿
            [request addAssets:@[asset]];
        }completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == NO) {
                [self showError:@"添加图片到【相簿】失败"];
                return ;
            }else{
                [self showSuccess:@"成功添加图片到相簿"];
            }
        }];
    }];
}

/**
 * 获取相簿
 */
- (PHAssetCollection *)createAssetCollection{
    
    // 从已存在相簿中查找这个应用的相簿
    //1.获取软件的名字
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection * assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:app_Name]) {
            return assetCollection;
        }
    }
    
    //没有找到对应的相簿，需要创建新的相簿
    NSError *error = nil;
    //PHAssetCollection的标识，利用这个标识可以找到对应的PHAssetCollection对象（相簿对象）
    __block NSString *assetCollectionLocalIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //创建“相簿”D
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:app_Name];
        PHObjectPlaceholder *placeholder = request.placeholderForCreatedAssetCollection;
        assetCollectionLocalIdentifier = placeholder.localIdentifier;
    } error:&error];
    //如果有错误信息
    if (error) return nil;
    //获得刚才创建的相簿
    return  [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
}

- (void)showError:(NSString *)text{
    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"%@",text);
                [SVProgressHUD showErrorWithStatus:text];
    });
}

- (void)showSuccess:(NSString *)text{
    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"%@",text);
                [SVProgressHUD showSuccessWithStatus:text];
    });
}


@end
