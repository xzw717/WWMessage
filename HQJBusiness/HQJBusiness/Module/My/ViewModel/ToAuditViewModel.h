//
//  ToAuditViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToAuditViewModel : NSObject



+ (void)toAuditRequstwithType:(NSString *)type andBlock:(void(^)(id listBlock))sender andZHsetBlock:(void(^)(id zhBlock))zhSender andCompletion:(void(^)())completion ;


//-(NSInteger)zw_ToAuditNumberOfSectionsInTableView:(UITableView *)tableView ;
@end
