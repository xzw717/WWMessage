//
//  PersonInfoCell.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/4.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopInfoCell.h"




#define LeftSpace 70/3.f
#define RightSpace 16.f
#define IconSpace 70/3.f

@interface ShopInfoCell ()
@end
@implementation ShopInfoCell


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [ManagerEngine getColor:@"909399"];
    }
    return _titleLabel;
}

- (UITextField *)textField{
    if ( _textField == nil ) {
        _textField = [[UITextField alloc]init];
        _textField.font = [UIFont systemFontOfSize:16];
        _textField.textColor = [UIColor blackColor];
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    return _textField;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addTheSubviews];
        [self layoutTheSubviews];
    }
    return self;
}
- (void)addTheSubviews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.textField];
}

- (void)layoutTheSubviews{
    self.titleLabel.sd_layout.leftSpaceToView(self, LeftSpace).centerYEqualToView(self).heightIs(20.f).widthIs(110.f);
    self.textField.sd_layout.leftSpaceToView(self, LeftSpace + 110).rightSpaceToView(self, LeftSpace).centerYEqualToView(self).heightIs(40.f);
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
