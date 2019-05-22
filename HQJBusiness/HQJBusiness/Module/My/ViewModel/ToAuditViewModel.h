//
//  ToAuditViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToAuditViewModel : NSObject



+ (void)toAuditRequstwithType:(NSString *)type page:(NSInteger)page andBlock:(void(^)(NSMutableArray *listBlock))sender andCompletion:(void(^)(void))completion ;


//-(NSInteger)zw_ToAuditNumberOfSectionsInTableView:(UITableView *)tableView ;
@end
