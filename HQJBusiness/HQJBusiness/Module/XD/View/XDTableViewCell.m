//
//  MyTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDTableViewCell.h"

@interface XDTableViewCell()

@property (nonatomic,strong) UILabel * descLabel;

@property (nonatomic,strong) UIImageView * accessImageView;
@end

@implementation XDTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    }
    
    return self;
}
- (UIImageView *)iconImageView{
    if ( _iconImageView == nil ) {
        _iconImageView = [[UIImageView alloc]init];
        [self addSubview:_iconImageView];

    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    if ( _nameLabel == nil ) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:16.f];
        _nameLabel.textColor = [ManagerEngine getColor:@"333333"];
        [self addSubview:_nameLabel];

    }
    return _nameLabel;
}
- (UILabel *)descLabel {
    if ( _descLabel == nil ) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = [UIFont systemFontOfSize:12.f];
        _descLabel.textColor = [ManagerEngine getColor:@"b3b2b2"];
        [self addSubview:_descLabel];

    }
    return _descLabel;
}
- (UIImageView *)accessImageView{
    if ( _accessImageView == nil ) {
        _accessImageView = [[UIImageView alloc]init];
        _accessImageView.image = [UIImage imageNamed:@"enter"];
        [self addSubview:_accessImageView];

    }
    return _accessImageView;
}

-(void)layoutSubviews {
    [self setViewFrame];
    [super layoutSubviews];
}

- (void)setViewFrame {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50/3);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(84/3, 84/3));
        
    }];
    [self.accessImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-68/3);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(33/3, 50/3));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.right).offset(27/3);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(self.accessImageView.left);
        make.height.mas_equalTo(20);
    }];

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
