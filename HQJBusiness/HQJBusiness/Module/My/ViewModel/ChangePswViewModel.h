//
//  ChangePswViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/22.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangePswViewModel : NSObject


+(void)changePswWithOldpwd:(NSString *)old andNewpwd:(NSString *)new andBlock:(void(^)(id changepswBlock))sender;


@end
