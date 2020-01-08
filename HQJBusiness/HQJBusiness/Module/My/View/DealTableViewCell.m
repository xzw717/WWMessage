//
//  DealTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/13.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "DealTableViewCell.h"
@interface DealTableViewCell ()

@end
@implementation DealTableViewCell
-(UIImageView *)titleImageView {
    if ( _titleImageView == nil ) {
        _titleImageView = [[UIImageView alloc]init];
        [self addSubview:_titleImageView];
    }
    
    return _titleImageView;
}
-(UILabel *)titleLabel {
    if ( _titleLabel == nil ) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:17.0];
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
-(NSArray *)titleLabelArray {
    if ( _titleLabelArray == nil ) {
        _titleLabelArray = @[@[],
                             @[@"交易",
                               @"消费码核销",
                               @"待审核申请",
                               @"消息通知",
                               @"优惠券"],/*,
                               */
                             @[@"台卡下载",
                               @"设置"]];
    }
    return _titleLabelArray;
}

-(NSArray *)titleImageViewArray {
    if ( _titleImageViewArray == nil ) {
        _titleImageViewArray = @[@[],
                                 @[@"icon_transaction",
                                   @"icon_xfm",
                                   @"icon_unverify",
                                   @"icon_notice",
                                   @"icon_my_coupon"],/*,
                                   */
                                 @[@"mine_icon_download",
                                   @"icon_setting"]];
    }
    
    return _titleImageViewArray;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    
    
    return self;
}

-(void)setCellIndexPath:(NSIndexPath *)cellIndexPath {
  
    
        self.titleImageView.image = [UIImage imageNamed:self.titleImageViewArray[cellIndexPath.section][cellIndexPath.row]];
        self.titleLabel.text = self.titleLabelArray[cellIndexPath.section][cellIndexPath.row];
    
   
    
        CGFloat labelWidth = [ManagerEngine setTextWidthStr:self.titleLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.titleImageView.sd_layout.leftSpaceToView(self,15).topSpaceToView(self,(self.frame.size.height - 18)/2).heightIs(18).widthIs(18);
    self.titleLabel.sd_layout.leftSpaceToView(self.titleImageView,10).topSpaceToView(self,(self.frame.size.height - 17)/2).heightIs(17).widthIs(labelWidth);
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
