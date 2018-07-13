//
//  ToAuditViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ToAuditViewModel.h"
#import "ZHSetModel.h"
#import "MyListModel.h"

@interface ToAuditViewModel()
@property (nonatomic,strong)NSMutableArray *ary;
@end


@implementation ToAuditViewModel

-(NSMutableArray *)ary {
    if (!_ary) {
        _ary = [NSMutableArray array];
    }
    
    return _ary;
}

+ (void)toAuditRequstwithType:(NSString *)type page:(NSInteger)page andBlock:(void(^)(NSMutableArray *listBlock))sender andCompletion:(void(^)())completion  {
    
    NSMutableDictionary *dict = @{@"memberid":MmberidStr,@"page":[NSString stringWithFormat:@"%ld",page]}.mutableCopy;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?",HQJBBonusDomainName,type];
    HQJLog(@"....%@",urlStr);
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict  complete:^(NSDictionary *dic) {
        if ([type isEqualToString:HQJBApplyListInterface]) {
            NSArray *listarray = dic[@"result"][@"applies"];
            NSMutableArray *listModelAry =[NSMutableArray arrayWithCapacity:listarray.count];
            for (NSDictionary *dicOne in listarray) {
                MyListModel *model = [MyListModel mj_objectWithKeyValues:dicOne];
                [listModelAry addObject:model];
            }
            
            NSArray *zhSetarray = dic[@"result"][@"zhset"];
            NSMutableArray *zhSetModelAry =[NSMutableArray arrayWithCapacity:zhSetarray.count];

            for (NSDictionary *dicOne in zhSetarray) {
                ZHSetModel *model = [ZHSetModel mj_objectWithKeyValues:dicOne];
                [zhSetModelAry addObject:model];
            }
            
            [listModelAry addObjectsFromArray:zhSetModelAry];
            
            sender(listModelAry);
            completion();
        } else {
            if([type isEqualToString:HQJBZHSetupInterface]) {
                
                NSArray *zhSetarray = dic[@"result"];
                NSMutableArray *zhSetModelAry =[NSMutableArray arrayWithCapacity:zhSetarray.count];
                
                for (NSDictionary *dicOne in zhSetarray) {
                    
                    
                    ZHSetModel *model = [ZHSetModel mj_objectWithKeyValues:dicOne];
                    [zhSetModelAry addObject:model];
                }
                sender(zhSetModelAry);
                completion();
                
            } else {
                NSArray *listarray = dic[@"result"];
                NSMutableArray *listModelAry =[NSMutableArray arrayWithCapacity:listarray.count];
                for (NSDictionary *dicOne in listarray) {
                    MyListModel *model = [MyListModel mj_objectWithKeyValues:dicOne];
                    [listModelAry addObject:model];
                }
                sender(listModelAry);
                completion();
            }
        }
        
        
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}




-(NSInteger)zw_ToAuditNumberOfSectionsInTableView:(UITableView *)tableView {


    return self.ary.count;

}






@end
