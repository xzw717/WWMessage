//
//  ShopModel.h
//  HQJBusiness
//
//  Created by Ethan on 2021/6/4.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopModel : NSObject
@property (nonatomic, strong) NSString *sp_number;
@property (nonatomic, strong) NSString *sp_image;
@property (nonatomic, strong) NSString *sp_title;
@property (nonatomic, strong) NSString *sp_subTitle;
@property (nonatomic, strong) NSString *sp_action;
@property (nonatomic, strong) NSDictionary *sp_parameter;
@end

NS_ASSUME_NONNULL_END
