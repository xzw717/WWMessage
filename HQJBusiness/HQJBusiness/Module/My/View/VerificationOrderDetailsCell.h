//
//  VerificationOrderDetailsCell.h
//  HQJBusiness
//
//  Created by mymac on 2017/9/14.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface VerificationOrderDetailsCell : UITableViewCell

- (void)settitleImage:(NSString *)imageStr
                 name:(NSString *)name
                price:(NSString *)price
                count:(NSString *)count;
@end
