//
//  CALScanQRCodeViewController.m
//  WuWuMap
//
//  Created by mymac on 16/6/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "CALScanQRCodeViewController.h"
#import "CALScanQRCodeCameraView.h"
#import "CALScanQRCodeTitleView.h"

#import <AVFoundation/AVFoundation.h>

#define CALScreenWidth          (CGRectGetWidth([[UIScreen mainScreen]  bounds]))
#define CALScreenHeight         (CGRectGetHeight([[UIScreen mainScreen] bounds]))

#define CALStatusBarHeight     (20.0f)
#define CALNavigationBarHeight (44.0f)
#define CALGetMethodReturnObjc(objc) if (objc) return objc
#define CALWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self

@interface CALScanQRCodeViewController() <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureDevice            *captureDevice;
@property (nonatomic, strong) AVCaptureDeviceInput       *captureDeviceInput;
@property (nonatomic, strong) AVCaptureMetadataOutput    *captureMetadataOutPut;
@property (nonatomic, strong) AVCaptureSession           *capturesession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (nonatomic, strong) CALScanQRCodeTitleView  *scanQRCodeTitleView;
@property (nonatomic, strong) CALScanQRCodeCameraView *cameraView;

@end

@implementation CALScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.cameraView];
    [self.view addSubview:self.scanQRCodeTitleView];
    
#if TARGET_IPHONE_SIMULATOR
    
//    self.view.backgroundColor = [UIColor blackColor];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"模拟器没有摄像头功能" message:@"请使用真机测试" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
#elif TARGET_OS_IPHONE
    
    [self initScanQRCode];
    
#endif
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }

}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];

    
    
}

#pragma mark - Init ScanQRCode
- (void)initScanQRCode {
    
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    _captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
    
    _captureMetadataOutPut    = [[AVCaptureMetadataOutput alloc] init];
    _captureMetadataOutPut.rectOfInterest = CGRectMake(0, 0, CALScreenWidth, CALScreenHeight);
    
    [_captureMetadataOutPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _capturesession = [[AVCaptureSession alloc] init];
    
    [_capturesession setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_capturesession canAddInput:self.captureDeviceInput]) {
        [_capturesession addInput:self.captureDeviceInput];
    }
    
    if ([_capturesession canAddOutput:self.captureMetadataOutPut]) {
        [_capturesession addOutput:self.captureMetadataOutPut];
    }
    
    _captureMetadataOutPut.metadataObjectTypes = @[AVMetadataObjectTypeUPCECode,
                                                   AVMetadataObjectTypeCode39Code,
                                                   AVMetadataObjectTypeCode39Mod43Code,
                                                   AVMetadataObjectTypeEAN13Code,
                                                   AVMetadataObjectTypeEAN8Code,
                                                   AVMetadataObjectTypeCode93Code,
                                                   AVMetadataObjectTypeCode128Code,
                                                   AVMetadataObjectTypePDF417Code,
                                                   AVMetadataObjectTypeQRCode,
                                                   AVMetadataObjectTypeAztecCode,
                                                   AVMetadataObjectTypeInterleaved2of5Code,
                                                   AVMetadataObjectTypeITF14Code,
                                                   AVMetadataObjectTypeDataMatrixCode];
    
    _captureVideoPreviewLayer              = [AVCaptureVideoPreviewLayer layerWithSession:_capturesession];
    _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _captureVideoPreviewLayer.frame        = CGRectMake(0, 0, CALScreenWidth, CALScreenHeight);
    
    [self.view.layer insertSublayer:_captureVideoPreviewLayer atIndex:0];
    
    [_capturesession startRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    [_capturesession stopRunning];
    
    if ([metadataObjects count] > 0) {
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        
        NSString *stringValue = metadataObject.stringValue;
       
//        self.CALScanQRCodeGetMetadataObjectsBlock(metadataObjects);
        self.CALScanQRCodeGetMetadataStringValue(stringValue);
        
        [self.cameraView stopAnimation];
    }
    
    [_captureMetadataOutPut setMetadataObjectsDelegate:nil queue:nil];
}

#pragma mark - Set ScanQRCode Title View
- (CALScanQRCodeTitleView *)scanQRCodeTitleView {
    
    CALGetMethodReturnObjc(_scanQRCodeTitleView);
    
    _scanQRCodeTitleView = [[CALScanQRCodeTitleView alloc] init];
    
    CALWeakSelf(ws);
    
    [_scanQRCodeTitleView setCALScanQRCodeTitleViewBackButtonBlock:^(UIButton *sender) {
        [ws popViewController];
    }];
    
    return _scanQRCodeTitleView;
}

#pragma mark - Set ScanQRCode Camera View
- (CALScanQRCodeCameraView *)cameraView {
    
    CALGetMethodReturnObjc(_cameraView);
    
    _cameraView = [[CALScanQRCodeCameraView alloc] init];
    
    return _cameraView;
}

#pragma mark - Pop View Controller
- (void)popViewController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --- 开闪光灯
- (void)openFlash {
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    if ([captureDevice hasTorch]) {
        BOOL locked = [captureDevice lockForConfiguration:&error];
        if (locked) {
            captureDevice.torchMode = AVCaptureTorchModeOn;
            [captureDevice unlockForConfiguration];
        }
    }
}

#pragma mark --- 关闪光灯
- (void)closeFlash {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }

}
@end
