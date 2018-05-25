//
//  DealTableViewCell.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/13.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealTableViewCell : ZW_TableViewCell

@property (nonatomic,strong)NSIndexPath *cellIndexPath;
@property (nonatomic,strong)UIImageView *titleImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)NSArray *titleImageViewArray;
@property (nonatomic,strong)NSArray *titleLabelArray;

@end
