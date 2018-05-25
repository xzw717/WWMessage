//
//  SelectButtonView.h
//  HQJBusiness
//
//  Created by mymac on 2017/9/8.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickButtonBlock)(NSString *buttonTitle);
@interface SelectButtonView : UIView
@property (nonatomic, copy) ClickButtonBlock titleStr;
@end
