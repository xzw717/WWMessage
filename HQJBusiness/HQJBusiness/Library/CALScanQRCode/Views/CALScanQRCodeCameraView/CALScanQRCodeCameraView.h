//
//  CALScanQRCodeCameraView.h
//  WuWuMap
//
//  Created by mymac on 16/6/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALScanQRCodeCameraView : UIView

@property (nonatomic, strong) UIImage *scanQRCodePickBackgroundImage;
@property (nonatomic, strong) UIImage *scanQRCodeLineImage;

@property (nonatomic, copy) NSString *tipsLabelText;

- (void)stopAnimation;

@end
