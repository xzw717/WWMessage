//
//  MyListModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyListModel : NSObject
@property (nonatomic,copy)NSString *tradeid ;
@property (nonatomic,copy)NSString *orderid ;
@property (nonatomic,copy)NSString *tradetime ;
@property (nonatomic,copy)NSString *fromid ;
@property (nonatomic,copy)NSString *frealname ;
@property (nonatomic,copy)NSString *fmembertype ;
@property (nonatomic,copy)NSString *fmobile ;
@property (nonatomic,copy)NSString *accountId ;
@property (nonatomic,copy)NSString *payBank ;
@property (nonatomic,copy)NSString *toid ;
@property (nonatomic,copy)NSString *trealname ;
@property (nonatomic,copy)NSString *tmembertype ;
@property (nonatomic,copy)NSString *tmobile ;
@property (nonatomic,copy)NSString *currency ;
@property (nonatomic,copy)NSString *amount ;
@property (nonatomic,copy)NSString *tradetype ;
@property (nonatomic,copy)NSString *tradeDesc ;
@property (nonatomic,copy)NSString *comment ;
@property (nonatomic,copy)NSString *flag ;
@property (nonatomic,copy)NSString *is_aatrade ;
@property (nonatomic,copy)NSString *is_aamaster ;
@property (nonatomic,copy)NSString *camount ;
//修改zh比例所需字段，其他不用
@property (nonatomic,copy)NSString *scoreRate ;
@property (nonatomic,copy)NSString *cashRate ;

@end
