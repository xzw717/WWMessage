//
//  InformationCell.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/22.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"
#import "informationModel.h"
@interface InformationCell : ZW_TableViewCell
@property (nonatomic,strong)informationModel *model;

@property (nonatomic,strong)NSArray *titleArray;

-(void)setModel:(informationModel *)model andindexPath:(NSIndexPath *)indexPath ;
@end
