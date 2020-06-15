//
//  DetectionViewController.h
//  IDLFaceSDKDemoOC
//
//  Created by 阿凡树 on 2017/5/23.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "FaceBaseViewController.h"
typedef void (^scanButtonCompletion)(void);
typedef void (^successResult)(UIImage *bestImage);
@interface DetectionViewController : FaceBaseViewController
@property (nonatomic, readwrite, copy) scanButtonCompletion scanResult;
@property (nonatomic, readwrite, copy) successResult result;
@end
