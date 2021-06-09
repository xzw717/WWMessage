//
//  ShopViewModel.h
//  HQJBusiness
//
//  Created by Ethan on 2021/6/4.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShopViewModel : NSObject
@property (nonatomic, strong) NSArray *sectionTitleArray;
//@property (nonatomic, strong) NSArray *rowTitleWithImageArray;
@property (nonatomic, strong) NSMutableArray <NSMutableArray <ShopModel *>*>*sourceArray;
- (void)clickItemWithIndexPath:(NSIndexPath *)index
                     dataArray:(NSArray <NSArray<ShopModel *> *> *)ary ;
@end

NS_ASSUME_NONNULL_END
