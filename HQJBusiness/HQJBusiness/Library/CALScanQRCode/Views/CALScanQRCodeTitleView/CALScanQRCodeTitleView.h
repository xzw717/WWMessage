//
//  CALScanQRCodeTitleView.h
//  WuWuMap
//
//  Created by mymac on 16/6/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALScanQRCodeTitleView : UIView

@property (nonatomic, strong) NSString *scanQRCodeTitle;
@property (nonatomic, strong) UIColor  *scanQRCodeTitleColor;
@property (nonatomic, strong) UIColor  *titleViewBackgroundColor;
@property (nonatomic, strong) UIImage  *backButtonImage;

@property (nonatomic, copy) void(^CALScanQRCodeTitleViewBackButtonBlock)(UIButton *backButton);

@end
