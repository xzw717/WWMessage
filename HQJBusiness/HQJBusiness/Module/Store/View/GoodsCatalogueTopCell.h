//
//  GoodsCatalogueTopCell.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/16.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodsCatalogueTopCell : ZW_TableViewCell
@property (nonatomic, assign) CGFloat cellHeight;

- (void)itemArray:(NSArray *)ary;
@end

NS_ASSUME_NONNULL_END
