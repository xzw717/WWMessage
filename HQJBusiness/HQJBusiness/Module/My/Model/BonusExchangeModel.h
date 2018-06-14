//
//  BonusExchangeModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface score : NSObject
@property (nonatomic,assign) double score;
@property (nonatomic,assign) double cash;
@property (nonatomic,assign) double zhValue;
@end

@interface BonusExchangeModel : NSObject
@property (nonatomic,copy) score *score;
@property (nonatomic,copy) NSString *ownName;
@property (nonatomic,copy) NSString *parentName;
@end
