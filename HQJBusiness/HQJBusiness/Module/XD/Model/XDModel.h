//
//  XDModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/5/18.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDSubModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XDModel : NSObject
@property (nonatomic, strong) NSString *nid;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *businessName;
@property (nonatomic, strong) NSString *addService;
@property (nonatomic, strong) NSString *platService;
@property (nonatomic, strong) NSString *serviName;
@property (nonatomic, strong) NSString *mark;
@property (nonatomic, strong) NSString *orderNum;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSArray <XDSubModel *>*list;

@end

NS_ASSUME_NONNULL_END
