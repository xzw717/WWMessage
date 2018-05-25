//
//  HQJBusinessAlertView.h
//  HQJBusiness
//
//  Created by mymac on 2017/12/7.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQJBusinessAlertView : UIView

- (instancetype)initWithisWarning:(BOOL)isWarning ;

- (void)zw_showAlertWithContent ;
- (void)zw_showAlertWithName:(NSString *)name mobile:(NSString *)mobile;
@end
