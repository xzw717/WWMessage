//
//  StoreModel.h
//  HQJBusiness
//
//  Created by mymac on 2019/6/25.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreSubItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface StoreModel : NSObject
@property (nonatomic, strong) NSString *imageViewName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray <StoreSubItemModel *>*itemModel;
@property (nonatomic, assign) CGFloat cellHeight;
@end

NS_ASSUME_NONNULL_END
