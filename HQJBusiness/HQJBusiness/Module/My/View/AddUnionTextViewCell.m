//
//  AddUnionTextViewCell.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/3/4.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddUnionTextViewCell.h"
@interface AddUnionTextViewCell ()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *textNumberLabel;
@end
@implementation AddUnionTextViewCell
- (ContentTextView *)textView {
    if (!_textView) {
        _textView = [[ContentTextView alloc]init];
        _textView.placeholder = @"请输入规则说明";
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:NewProportion(48)];
        _textView.placeholderFont = [UIFont systemFontOfSize:NewProportion(48)];
    }
    return _textView;
}
- (UILabel *)textNumberLabel {
    if (!_textNumberLabel) {
        _textNumberLabel = [[UILabel alloc]init];
        _textNumberLabel.text = @"0/500";
        _textNumberLabel.textColor = [ManagerEngine getColor:@"999999"];
        _textNumberLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
    }
    return _textNumberLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.textNumberLabel];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)updateConstraints {
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.bottom.right.mas_equalTo(-10);
    }];
    [self.textNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.textView);
        make.size.mas_equalTo(CGSizeMake(60, 15));
    }];
    [super updateConstraints];
}
- (void)setDataArray:(NSArray *)dataArray{
    self.textView.placeholder = dataArray[2];
    if ([self.model valueForKey:dataArray[3]]) {
        self.textView.text = [self.model valueForKey:dataArray[3]];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length>500) {
        [SVProgressHUD showErrorWithStatus:@"输入文字超出限制"];
    }else{
        !self.textFieldResult ? : self.textFieldResult(textView.text);
    }
    
}
- (void)textViewDidChangeSelection:(UITextView *)textView {
    self.textNumberLabel.text = [NSString stringWithFormat:@"%ld/500",textView.text.length];
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
