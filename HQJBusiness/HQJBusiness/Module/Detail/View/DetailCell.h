//
//  DetailCell.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"
#import "DetailModel.h"

@interface DetailCell : ZW_TableViewCell

-(void)setModel:(DetailModel *)model andPaging:(NSInteger)page;
- (CGFloat)cellHeightWithModel:(DetailModel *)model;
@end
