//
//  MineViewModel.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/2.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UploadImageViewModel.h"

#import "ZWActionSheetView.h"

@interface UploadImageViewModel (){
    UIViewController *viewController;
}

@property (nonatomic , assign) __block NSInteger imageType;
@property (nonatomic , assign) __block NSInteger successNum; //记录成功上传的个数
@property (nonatomic , assign) __block NSInteger failNum; ////记录上传失败的个数

@property(nonatomic, copy) void (^didPickImageBlock)(UIImage *);
@property(nonatomic, copy) void (^completion)(NSString *);
@end
@implementation UploadImageViewModel


- (void)uploadImageWithImageType:(UIViewController *)vc andImageType:(NSInteger)type completion:(void (^)(NSString *))completion {
    viewController = vc;
    self.imageType = type;
    [self showSheetView];
    _completion = completion;
}
- (void)uploadImageWithImageType:(UIViewController *)vc completion:(void (^)(UIImage *))completion{
    _didPickImageBlock = completion;
    viewController = vc;
    [self showSheetView];
}
- (void) showSheetView{
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
    [viewController presentViewController:picker animated:YES completion:nil];
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
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (_didPickImageBlock) {
        _didPickImageBlock(image);
        [picker dismissViewControllerAnimated:YES completion:nil];
    }else{
        [picker dismissViewControllerAnimated:YES completion:^{
            NSLog(@"image = %@",image);
            [self uploadImage:image andImageType:self.imageType alertText:@"上传中" completion:^(NSURLResponse *response, id responseObject, NSError *error) {
                if (!error) {
                    if ([responseObject isKindOfClass:[NSData class]]) {
                        NSData *resData = (NSData *)responseObject;
                        NSDictionary * dic =[NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:&error];
                        if ([dic[@"code"]integerValue] == 2400) {
                            NSLog(@"上传成功");
                            [ZGProgressHUD showSuccess:@"上传成功"];
                        } else {
                            NSLog(@"msg = %@",dic[@"msg"]);
                            [ZGProgressHUD showError:dic[@"msg"]];
                        }
                        if (_completion) {
                            _completion(dic[@"result"]);
                        }
                        
                    } else {
                        
                    }
                }else{
                    NSLog(@"error = %@",error);
                }
            }];
        }];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadImage:(UIImage *)image andImageType:(NSInteger)type alertText:(NSString *)text completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock{
    
//    NSData *imgData = UIImageJPEGRepresentation(image,0.5);
    NSData *imgData = [ManagerEngine reSizeImageData:image maxImageSize:WIDTH maxSizeWithKB:200.0];
    
    NSString *dataStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBounsOrder,HQJBSaveSignNameInterface];
    NSDictionary * dic = @{@"shopid":MmberidStr,@"picurl":dataStr,@"type":[NSNumber numberWithInteger:type]};
    NSLog(@"dataDic = %@",dic);
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    [ZGProgressHUD showMessage:text];

    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer]requestWithMethod:@"POST" URLString:urlStr parameters:nil error:nil];
    [request addValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval= 30;
    [request setHTTPBody:data];
    HQJLog(@"HTTPBody:%@",request.HTTPBody);

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                      @"text/html",
                                                                      @"text/json",
                                                                      @"text/plain",
                                                                      @"text/javascript",
                                                                      @"text/xml",
                                                                      @"image/jpeg",
                                                                      @"image/png",
                                                                      @"application/octet-stream"]];
    manager.responseSerializer = responseSerializer;


    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [ZGProgressHUD hideHUD];
        if (completionBlock) {
            completionBlock(response,responseObject,error);
        }
    }] resume];
}


- (void)uploadImages:(NSArray *)images andImageType:(NSInteger)type uploadResultBlock:(UploadRequestMgrUploadResultBlock)uploadResultBlock{
    // 准备保存结果的数组，元素个数与上传的图片个数相同，先用 NSNull 占位
    NSMutableArray* result = [NSMutableArray array];
    for (UIImage* image in images) {
        NSLog(@"%@",image);
        [result addObject:[NSNull null]];
    }
    
    dispatch_group_t group = dispatch_group_create();
    
    for (NSInteger i = 0; i < images.count; i++) {
        
        dispatch_group_enter(group);
        [self uploadImage:images[i] andImageType:type alertText:@"上传中" completion:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"第 %d 张图片上传失败: %@", (int)i + 1, error);
                self.failNum ++;
                dispatch_group_leave(group);
            } else {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    NSData *resData = (NSData *)responseObject;
                    NSDictionary * dic =[NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:&error];
                    if ([dic[@"code"]integerValue] == 49000) {
                        NSLog(@"第 %d 张图片上传成功: %@", (int)i + 1, responseObject);
                        @synchronized (result) { // NSMutableArray 是线程不安全的，所以加个同步锁
                            result[i] = responseObject;
                        }
                        self.successNum ++;
                        [ZGProgressHUD showSuccess:@"上传成功"];
                    } else {
                        [ZGProgressHUD showError:dic[@"msg"]];
                    }
                }
                dispatch_group_leave(group);
            }
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"上传完成!");
        if (uploadResultBlock) {
            uploadResultBlock(self.successNum,self.failNum);
        }
    });

}

@end
