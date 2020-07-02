//
//  DealTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/13.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "DealTableViewCell.h"
//#import "MyViewModel.h"

@interface DealTableViewCell ()

@end
@implementation DealTableViewCell
-(UIImageView *)titleImageView {
    if ( _titleImageView == nil ) {
        _titleImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_titleImageView];
    }
    
    return _titleImageView;
}
-(UILabel *)titleLabel {
    if ( _titleLabel == nil ) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:17.0];
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
//-(NSArray *)titleLabelArray {
//    if ( _titleLabelArray == nil ) {
//        _titleLabelArray = @[@[],
//                             @[@"店铺管理",
//                               @"交易",
//                               @"消费码核销",
//                               @"待审核申请",
//                               @"消息通知",
//                               @"优惠券"],/*,
//                               */
//                             @[@"台卡下载",
//                               @"设置"]];
//    }
//    return _titleLabelArray;
//}
//
//-(NSArray *)titleImageViewArray {
//    if ( _titleImageViewArray == nil ) {
//        _titleImageViewArray = @[@[],
//                                 @[@"icon_my_storemanagement",
//                                   @"icon_transaction",
//                                   @"icon_xfm",
//                                   @"icon_unverify",
//                                   @"icon_notice",
//                                   @"icon_my_coupon"],/*,
//                                   */
//                                 @[@"mine_icon_download",
//                                   @"icon_setting"]];
//    }
//    
//    return _titleImageViewArray;
//}
//

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleImageView.mas_right).mas_offset(10);
            make.centerY.mas_equalTo(self.contentView);
              
        }];
        
    }
    
    
    return self;
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
