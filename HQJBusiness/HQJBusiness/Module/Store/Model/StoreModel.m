//
//  StoreModel.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/25.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreModel.h"
#import "StoreMainCell.h"

@implementation StoreModel
+ (NSDictionary *)mj_objectClassInArray {
        return @{@"itemModel":[StoreSubItemModel class]};
   
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        StoreMainCell *cell = [[StoreMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([StoreMainCell class])];
        
    }
    return _cellHeight;
}
@end
