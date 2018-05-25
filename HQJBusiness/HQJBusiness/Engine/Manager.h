//
//  Manager.h
//  HQJFacilitator
//
//  Created by mymac on 2016/10/18.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manager : NSObject
+(Manager *)sharedManager ;
@property (nonatomic,copy) NSString *bonus;
@property (nonatomic,copy) NSString *is_shopaholic;
@end
