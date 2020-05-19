//
//  MyTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDDetailTableViewCell.h"

@interface XDDetailTableViewCell()
@property (nonatomic,strong) UIButton * selectBtn;
@end

@implementation XDDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    }
    
    return self;
}
- (UIButton *)selectBtn{
    if ( _selectBtn == nil ) {
        _selectBtn = [[UIButton alloc]init];
        _selectBtn.userInteractionEnabled = NO;
        [_selectBtn setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
        [self addSubview:_selectBtn];

    }
    return _selectBtn;
}
- (UILabel *)nameLabel {
    if ( _nameLabel == nil ) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:40/3];
        _nameLabel.textColor = [ManagerEngine getColor:@"333333"];
        [self addSubview:_nameLabel];

    }
    return _nameLabel;
}
- (UILabel *)descLabel {
    if ( _descLabel == nil ) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = [UIFont systemFontOfSize:40/3];
        _descLabel.numberOfLines = 0;
        _descLabel.textColor = [ManagerEngine getColor:@"969799"];
        [self addSubview:_descLabel];

    }
    return _descLabel;
}

-(void)layoutSubviews {
    [self setViewFrame];
    [super layoutSubviews];
}

- (void)setViewFrame {
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50/3);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(36/3, 36/3));
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(106/3);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(100, 12));
        
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(106/3);
        make.top.mas_equalTo(22);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(-50/3);
    }];

}


- (void)addSubview:(UIView *)view
{
    if (![view isKindOfClass:[NSClassFromString(@"_UITableViewCellSeparatorView") class]] && view)
        [super addSubview:view];
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
