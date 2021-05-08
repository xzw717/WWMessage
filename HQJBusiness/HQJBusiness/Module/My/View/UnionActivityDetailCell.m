//
//  UnionActivityDetailCell.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/3/1.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UnionActivityDetailCell.h"
#define LeftMargin 10
@interface UnionActivityDetailCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *textField;
@end
@implementation UnionActivityDetailCell
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.backgroundColor = [UIColor whiteColor];
    }
    return _nameLabel;
}
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc]init];
        _textField.font = [UIFont systemFontOfSize:16];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.userInteractionEnabled = NO;
    }
    return _textField;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.textField];
        
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)updateConstraints {
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(120, 50));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.nameLabel.mas_right);
        make.right.mas_equalTo(-10);
    }];
    
    [super updateConstraints];
}
- (void)setDataArray:(NSArray *)dataArray{

    self.nameLabel.text = dataArray[0];
    if ([self.model valueForKey:dataArray[1]]) {
        self.textField.text = [self.model valueForKey:dataArray[1]];
    }
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
