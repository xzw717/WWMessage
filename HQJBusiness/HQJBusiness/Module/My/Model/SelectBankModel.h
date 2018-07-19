//
//  SelectBankModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/27.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectBankModel : NSObject

@property (nonatomic,strong)NSString *createTime;

/// 银行卡id
@property (nonatomic,strong)NSString *bid;


@property (nonatomic,strong)NSString *bankId;

@property (nonatomic,strong)NSString *bankCard;

@property (nonatomic,strong)NSDictionary *bankDetail;
/// 用户id
@property (nonatomic,strong)NSString *mid;

@property (nonatomic,strong)NSString *bankType;

@end
