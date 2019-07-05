//
//  CALScanQRCodeViewController.h
//  WuWuMap
//
//  Created by mymac on 16/6/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALScanQRCodeViewController : UIViewController

/**
 * If You Need String Value, You Can Copy Code
 *
 * AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
 * NSString *stringValue = metadataObject.stringValue;
 */
@property (nonatomic, copy) void(^CALScanQRCodeGetMetadataObjectsBlock)(NSArray *metadataObjects);

@property (nonatomic, copy) void(^CALScanQRCodeGetMetadataStringValue)(NSString *metadataObject);
/// 开闪光灯
- (void)openFlash;
/// 关闪光灯
- (void)closeFlash ;
@end
