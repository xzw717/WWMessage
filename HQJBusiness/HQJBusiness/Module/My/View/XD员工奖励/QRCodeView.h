//
//  QRCodeView.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/30.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QRCodeView;
typedef QRCodeView * (^CompanyBlock)(NSString *str);
typedef QRCodeView * (^NameBlock)(NSString *str);
typedef QRCodeView * (^PhoneBlock)(NSString *str);
typedef QRCodeView * (^QrCodeImagelock)(UIImage *image);

NS_ASSUME_NONNULL_BEGIN

@interface QRCodeView : UIView
@property (nonatomic, copy) CompanyBlock company;
@property (nonatomic, copy) NameBlock name;
@property (nonatomic, copy) PhoneBlock phone;
@property (nonatomic, copy) QrCodeImagelock qrCode;



+ (instancetype)showQrCode;
@end

NS_ASSUME_NONNULL_END
