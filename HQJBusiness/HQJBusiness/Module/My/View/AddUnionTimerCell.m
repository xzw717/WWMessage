//
//  AddUnionTimerCell.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/3.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddUnionTimerCell.h"
#import "SelectTimeView.h"
#define LeftMargin 10
@interface AddUnionTimerCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) SelectTimeView *timerView;
@end
@implementation AddUnionTimerCell
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
        _textField.inputView = self.timerView;
        @weakify(self);
        [self.timerView setFinish:^(NSString * _Nonnull timer) {
            @strongify(self);
            self.textField.text = timer;
            !self.timerResult ?:self.timerResult(timer);
        }];
    }
    return _textField;
}


- (SelectTimeView *)timerView {
    if (!_timerView) {
        _timerView = [[SelectTimeView alloc]init];
        NSTimeInterval oneDay = 24 * 60 * 60;
        [_timerView.datePicker setMinimumDate:[[NSDate date] initWithTimeIntervalSinceNow: oneDay * 3]];
    }
    return _timerView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.nameLabel.mas_right);
        make.right.mas_equalTo(-10);
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
    self.textField.placeholder = dataArray[2];
    if ([self.model valueForKey:dataArray[3]]) {
        self.textField.text = [self.model valueForKey:dataArray[3]];
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
