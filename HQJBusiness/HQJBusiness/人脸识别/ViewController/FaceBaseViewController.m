//
//  FaceBaseViewController.m
//  IDLFaceSDKDemoOC
//
//  Created by 阿凡树 on 2017/5/23.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "FaceBaseViewController.h"
#import <IDLFaceSDK/IDLFaceSDK.h>

#import "ImageUtils.h"
#import "RemindView.h"
#import "AIPWaterView.h"

#define scaleValue 0.8

#define ScreenRect [UIScreen mainScreen].bounds
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface FaceBaseViewController () <CaptureDataOutputProtocol>

@property (nonatomic, readwrite, retain) UILabel *remindLabel;
@property (nonatomic, readwrite, retain) RemindView * remindView;
@property (nonatomic, readwrite, retain) UILabel * remindDetailLabel;
@property (nonatomic, readwrite, retain) UIImageView * successImage;
@property (nonatomic, readwrite, assign) CGFloat brightness;
@property (nonatomic, readwrite, retain) AIPWaterView* waterView;
@end

@implementation FaceBaseViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)warningStatus:(WarningStatus)status warning:(NSString *)warning
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (status == PoseStatus) {
            [weakSelf.remindLabel setHidden:true];
            [weakSelf.remindView setHidden:false];
            [weakSelf.remindDetailLabel setHidden:false];
            weakSelf.remindDetailLabel.text = warning;
        }else if (status == occlusionStatus) {
            [weakSelf.remindLabel setHidden:false];
            [weakSelf.remindView setHidden:true];
            [weakSelf.remindDetailLabel setHidden:false];
            weakSelf.remindDetailLabel.text = warning;
            weakSelf.remindLabel.text = @"脸部有遮挡";
        }else {
            [weakSelf.remindLabel setHidden:false];
            [weakSelf.remindView setHidden:true];
            [weakSelf.remindDetailLabel setHidden:true];
            weakSelf.remindLabel.text = warning;
        }
    });
}

- (void)singleActionSuccess:(BOOL)success
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (success) {
            [weakSelf.successImage setHidden:false];
        }else {
            [weakSelf.successImage setHidden:true];
        }
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化相机处理类
    self.videoCapture = [[VideoCaptureDevice alloc] init];
    self.videoCapture.delegate = self;
    
    // 用于播放视频流
    self.detectRect = CGRectMake(ScreenWidth*(1-scaleValue)/2.0, ScreenHeight*(1-scaleValue)/2.0, ScreenWidth*scaleValue, ScreenHeight*scaleValue);
    self.displayImageView = [[UIImageView alloc] initWithFrame:self.detectRect];
    self.displayImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.displayImageView];
    
    self.coverImage = [ImageUtils getImageResourceForName:@"facecover"];
    CGRect circleRect = [ImageUtils convertRectFrom:CGRectMake(125, 334, 500, 500) imageSize:self.coverImage.size detectRect:ScreenRect];
    self.previewRect = CGRectMake(circleRect.origin.x - circleRect.size.width*(1/scaleValue-1)/2.0, circleRect.origin.y - circleRect.size.height*(1/scaleValue-1)/2.0 - 60, circleRect.size.width/scaleValue, circleRect.size.height/scaleValue);
    
    CGFloat scale = circleRect.size.width / ScreenWidth;
    self.displayImageView.frame = CGRectMake(ScreenWidth*(1-scale)/2.0, ScreenHeight*(1-scale)/2.0, ScreenWidth*scale, ScreenHeight*scale);
    
    AIPWaterView* waterView = [[AIPWaterView alloc] initWithFrame:CGRectMake(circleRect.origin.x, circleRect.origin.y + circleRect.size.height - 60, circleRect.size.width, 60)];
    waterView.hidden = NO;
    self.waterView = waterView;
    [self.view addSubview:waterView];
    
    //画圈
    self.circleView = [[CircleView alloc] initWithFrame:ScreenRect];
    self.circleView.circleRect = circleRect;
    [self.view addSubview:self.circleView];
    
    // 遮罩
    UIImageView* coverImageView = [[UIImageView alloc] initWithFrame:ScreenRect];
    coverImageView.image = [ImageUtils getImageResourceForName:@"facecover"];
    coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:coverImageView];
    
    //successImage
    self.successImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(circleRect)+CGRectGetWidth(circleRect)/2.0-57/2.0, CGRectGetMinY(circleRect)-57/2.0, 57, 57)];
    self.successImage.image = [ImageUtils getImageResourceForName:@"success"];
    [self.view addSubview:self.successImage];
    [self.successImage setHidden:true];
    
    // 关闭
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];

    [closeButton addTarget:self action:@selector(closeButtomAction) forControlEvents:UIControlEventTouchUpInside];
    closeButton.frame = CGRectMake(20, 40, 30, 30);
    [self.view addSubview:closeButton];
    
    // 提示框
    self.remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, circleRect.origin.y-70, ScreenWidth, 30)];
    self.remindLabel.textAlignment = NSTextAlignmentCenter;
    self.remindLabel.textColor = [UIColor whiteColor];
    self.remindLabel.font = [UIFont boldSystemFontOfSize:22.0];
    [self.view addSubview:self.remindLabel];
    
    self.remindView = [[RemindView alloc]initWithFrame:CGRectMake((ScreenWidth-200)/2.0, CGRectGetMinY(self.remindLabel.frame), 200, 45)];
    [self.view addSubview:self.remindView];
    [self.remindView setHidden:YES];
    
    self.remindDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 100, CGRectGetMaxY(circleRect) + 40, 200, 40)];
//    self.remindDetailLabel.backgroundColor = [UIColor colorWithRed:27 green:27 blue:27 alpha:1];
//    self.remindDetailLabel.layer.masksToBounds = YES;
//    self.remindDetailLabel.layer.cornerRadius = 20.f;
    self.remindDetailLabel.font = [UIFont systemFontOfSize:20];
    self.remindDetailLabel.textColor = [ManagerEngine getColor:@"ff3341"];
    self.remindDetailLabel.textAlignment = NSTextAlignmentCenter;
    self.remindDetailLabel.text = @"建议略微抬头";
    [self.view addSubview:self.remindDetailLabel];
//    [self.remindDetailLabel setHidden:true];
    
    // 监听重新返回APP
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppWillResignAction) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    // 设置最小检测人脸阈值
    [[FaceSDKManager sharedInstance] setMinFaceSize:200];
    // 设置截取人脸图片大小
    [[FaceSDKManager sharedInstance] setCropFaceSizeWidth:400];
    // 设置人脸遮挡阀值
    [[FaceSDKManager sharedInstance] setOccluThreshold:0.5];
    // 设置亮度阀值
    [[FaceSDKManager sharedInstance] setIllumThreshold:40];
    // 设置图像模糊阀值
    [[FaceSDKManager sharedInstance] setBlurThreshold:0.7];
    // 设置头部姿态角度
    [[FaceSDKManager sharedInstance] setEulurAngleThrPitch:10 yaw:10 roll:10];
    // 设置是否进行人脸图片质量检测
    [[FaceSDKManager sharedInstance] setIsCheckQuality:YES];
    // 设置超时时间
    [[FaceSDKManager sharedInstance] setConditionTimeout:90];
    // 设置人脸检测精度阀值
    [[FaceSDKManager sharedInstance] setNotFaceThreshold:0.6];
    // 设置照片采集张数
    [[FaceSDKManager sharedInstance] setMaxCropImageNum:1];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    self.hasFinished = YES;
//    [self stopCapture];
//    self.videoCapture.runningStatus = NO;
    [UIScreen mainScreen].brightness = self.brightness;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _hasFinished = NO;
    self.videoCapture.runningStatus = YES;
    [self.videoCapture startSession];
    self.brightness = [UIScreen mainScreen].brightness;
    [UIScreen mainScreen].brightness = 1.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)startAnimation {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.waterView.hidden = NO;
        [weakSelf.waterView startAnimation];
    });
}
- (void)stopAnimation {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.waterView.hidden = YES;
        [weakSelf.waterView stopAnimation];
    });
}
- (void)faceProcesss:(UIImage *)image {
    
}

- (void)startCapture {
    [self.videoCapture startSession];
    self.videoCapture.delegate = self;
}
- (void)stopCapture {
    [self.videoCapture stopSession];
    self.videoCapture.delegate = nil;
}
- (void)closeAction {
    _hasFinished = YES;
    self.videoCapture.runningStatus = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)closeButtomAction{
    _hasFinished = YES;
    self.videoCapture.runningStatus = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Notification

- (void)onAppWillResignAction {
    _hasFinished = YES;
}

- (void)onAppBecomeActive {
    _hasFinished = NO;
}

#pragma mark - CaptureDataOutputProtocol

- (void)captureOutputSampleBuffer:(UIImage *)image {
    if (_hasFinished) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.displayImageView.image = image;
    });
    [self faceProcesss:image];
}

- (void)captureError {
    NSString *errorStr = @"出现未知错误，请检查相机设置";
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        errorStr = @"相机权限受限,请在设置中启用";
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:errorStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"知道啦" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"知道啦");
        }];
        [alert addAction:action];
        UIViewController* fatherViewController = weakSelf.presentingViewController;
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            [fatherViewController presentViewController:alert animated:YES completion:nil];
        }];
    });
}
@end
