//
//  AddUnionSectionView.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/5.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddUnionSectionView.h"
#define LeftMargin 10
@interface AddUnionSectionView ()
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIButton *addButton;
@end
@implementation AddUnionSectionView
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc]init];
        _textField.userInteractionEnabled = NO;
        _textField.font = [UIFont systemFontOfSize:16];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return _textField;
}
- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"icon_plus"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.nameLabel];
        [self addSubview:self.textField];
        [self addSubview:self.addButton];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)updateConstraints {
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(LeftMargin);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-LeftMargin);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.nameLabel.mas_right);
        make.right.mas_equalTo(self.addButton.mas_left);
        make.height.mas_equalTo(30);
    }];
    [super updateConstraints];
}
- (void)setDataArray:(NSArray *)dataArray{
    if ([dataArray[1] hasPrefix:@"*"]) {
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc]initWithString:dataArray[1]];
        [attributed addAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(0, 1)];
        self.nameLabel.attributedText = attributed;
    }else{
        self.nameLabel.text = dataArray[1];
    }
    self.textField.text = dataArray[2];
}
- (void)addButtonClicked{
    if (_addButtonBlock) {
        _addButtonBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
