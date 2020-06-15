//
//  LivenessViewController.h
//  IDLFaceSDKDemoOC
//
//  Created by 阿凡树 on 2017/5/23.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "FaceBaseViewController.h"

@interface LivenessViewController : FaceBaseViewController
typedef void (^skipButtonCompletion)(void);
typedef void (^successResult)(UIImage *bestImage);
@property (nonatomic, readwrite, copy) skipButtonCompletion skipResult;
@property (nonatomic, readwrite, copy) successResult result;

@property (nonatomic, readwrite, assign) BOOL isJump;//是否显示跳过按钮

- (void)livenesswithList:(NSArray *)livenessArray order:(BOOL)order numberOfLiveness:(NSInteger)numberOfLiveness;

@end
