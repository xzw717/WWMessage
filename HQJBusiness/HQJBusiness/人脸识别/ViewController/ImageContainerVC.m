//
//  ImageContainerVC.m
//  WuWuMap
//
//  Created by 姚 on 2019/8/28.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ImageContainerVC.h"
#import "ZZImageContainer.h"
#import "FaceRegViewModel.h"
@interface ImageContainerVC ()

@end

@implementation ImageContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    ZZImageContainer *imageContainer = [[ZZImageContainer alloc]init];
    imageContainer.dataImage = self.dataImage;
    @weakify(self);
    imageContainer.confirmBlock = ^{
        @strongify(self);
        NSData *imageData = UIImagePNGRepresentation(self.dataImage);//NSDataBase64EncodingEndLineWithLineFeed这个枚举值是base64串不换行
        NSString *bestImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//        NSString *urlStr = [NSString stringWithFormat:@"%@%@",@"",WWMStoreImageInterface];
//        NSDictionary * dic = @{@"mobile":T_MOBILE,@"ba":bestImageStr};
//        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:dic];
//        NSData *bodyData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
//        [WWMProgressHUD showHUDMeassage:@"人像采集中"];
//        [FaceRegViewModel uploadImage:urlStr body:bodyData completion:^(id dict) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [WWMProgressHUD hiddenHUD];
//                if ([dict[@"code"]integerValue] == 49000) {
//                    [ToolManager setDataObject:@1 key:@"isFaceSet"];
//                    [ToolManager setDataObject:dict[@"result"] key:@"faceUrl"];
//                    UIViewController * presentingViewController = self.presentingViewController;
//                    while (presentingViewController.presentingViewController) {
//                        presentingViewController = presentingViewController.presentingViewController;
//                    }
//                    [presentingViewController dismissViewControllerAnimated:YES completion:^{
//                        [MBProgressHUD showSuccess:@"采集成功"];
//                    }];
//                    !self.sureResult ? : self.sureResult();
//                    NSLog(@"上传成功");
//                } else {
//                    NSLog(@"msg = %@",dict[@"msg"]);
//                    [self dismissViewControllerAnimated:YES completion:^{
//                        [MBProgressHUD showError:dict[@"msg"]];
//                    }];
//                }
//            });
//        }];
        
    };
    imageContainer.cancelBlock = ^{
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    [self.view addSubview:imageContainer];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

