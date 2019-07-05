//
//  ScanQRCodeToolView.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/2.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ScanQRCodeToolBlcok)(void);
@interface ScanQRCodeToolView : UIView
/// 手电筒点击
@property (nonatomic, copy) ScanQRCodeToolBlcok fl_block;
/// 手动核销点击
@property (nonatomic, copy) ScanQRCodeToolBlcok mv_block;

@end

NS_ASSUME_NONNULL_END
