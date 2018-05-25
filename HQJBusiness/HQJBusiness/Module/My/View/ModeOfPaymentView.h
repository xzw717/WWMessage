//
//  ModeOfPaymentView.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/15.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModeOfPaymentView : UIView
-(void)showView ;
@property (nonatomic,assign) BOOL isArrearage;
@property (nonatomic,copy) NSString *payModeStr;
@property (nonatomic,strong)void(^cellSelectBlock)(id sender);
@end
