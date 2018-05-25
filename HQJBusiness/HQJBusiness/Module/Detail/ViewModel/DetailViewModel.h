//
//  DetailViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailModel.h"
@interface DetailViewModel : NSObject


+ (void)detailRequsttype:(NSString *)type types:(NSString *)types page:(NSString *)page listBlock:(void(^)(NSArray <DetailModel *>*sender))detailBlock ;

@end
