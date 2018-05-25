//
//  OrderDetailFootView.h
//  HQJBusiness
//
//  Created by mymac on 2017/9/13.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailFootView : UITableViewHeaderFooterView
- (void)orderTime:(NSString *)time count:(NSString *)count allPrice:(NSString *)price;
@end
