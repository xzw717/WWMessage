//
//  ScanViewController.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/19.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "CALScanQRCodeViewController.h"

@interface ScanViewController : CALScanQRCodeViewController
@property (nonatomic, assign) BOOL isAddCode;
@property (nonatomic, strong) NSString *addcodeType;

@end
