//
//  MyTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MyTableViewCell.h"
@interface MyTableViewCell()



@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UIImageView * titleImageView;

@property (nonatomic,strong) UIImageView * arrowImageView;

@property (nonatomic, strong) UIView * linkView;

@property (nonatomic, strong) UILabel *customerServiceLabel;
@end

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.titleImageView];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.linkView];
        [self.contentView addSubview:self.customerServiceLabel];
        
        [self setViewFrame];
        

        
    }
    
    return self;
}

- (void)setMy_model:(ShopModel *)my_model {
    _my_model = my_model;
    self.titleImageView.image = [UIImage imageNamed:my_model.sp_image];
    self.titleLabel.text = my_model.sp_title;
    self.customerServiceLabel.hidden = [my_model.sp_title isEqualToString:@"联系客服"] ? NO : YES;
    self.arrowImageView.hidden = !self.customerServiceLabel.hidden ;
    self.linkView.hidden = [my_model.sp_title isEqualToString:@"设置"] ? YES : NO;
    self.customerServiceLabel.text = my_model.sp_subTitle;
}

- (UILabel *)titleLabel {
    if ( _titleLabel == nil ) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:13.f];
        _titleLabel.textColor = [ManagerEngine getColor:@"333333"];
        
    }
    return _titleLabel;
}
- (UIImageView *)titleImageView {
    if ( _titleImageView == nil ) {
        _titleImageView = [[UIImageView alloc]init];
   
    }
    return _titleImageView;
}

- (UIImageView *)arrowImageView {
    if ( _arrowImageView == nil ) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"iocn_Select-right"];
    }
    return _arrowImageView;
}

- (UIView *)linkView {
    if (!_linkView){
        _linkView = [[UIView alloc]init];
        _linkView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
    }
    return _linkView;;
}
- (UILabel *)customerServiceLabel {
    if ( _customerServiceLabel == nil ) {
        _customerServiceLabel = [[UILabel alloc]init];
        _customerServiceLabel.font = [UIFont systemFontOfSize:13.f];
        _customerServiceLabel.textColor = [ManagerEngine getColor:@"000000"];
        
    }
    return _customerServiceLabel;
}

-(void)layoutSubviews {
//    [self setViewFrame];
    [super layoutSubviews];
}

- (void)setViewFrame {

    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(23.f);
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.titleImageView.mas_right).mas_offset(10.f);
    }];
  
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18.f);
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(18.f);
    }];
    [self.linkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(-0.5f);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5f);
    }];
   
    [self.customerServiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.mas_equalTo(self.arrowImageView);
    }];
    
    
    
}




@end
