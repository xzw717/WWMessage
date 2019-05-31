//
//  OrderDetailsFiveCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailsFiveCell.h"

@interface OrderDetailsFiveCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *orderNumberLabel;
@property (nonatomic, strong) UIView  *verticalLineView;
@property (nonatomic, strong) UIButton *copysButton;
@end
@implementation OrderDetailsFiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.orderNumberLabel];
        [self.contentView addSubview:self.verticalLineView];
        [self.contentView addSubview:self.copysButton];

        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)setOrderNumberStr:(NSString *)orderNumberStr {
    self.orderNumberLabel.text = orderNumberStr;
}

- (void)updateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(43);
    }];
    [self.copysButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(60, 35));
    }];
    [self.verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.copysButton.mas_left);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(12.5);
        make.width.mas_equalTo(0.5f);
    }];
    
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.verticalLineView.mas_left).mas_offset(-15);
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(15);
    }];
   
    [super updateConstraints];
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"订单号";
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textColor = [ManagerEngine getColor:@"323232"];
    }
    return _titleLabel;
}
- (UILabel *)orderNumberLabel {
    if (!_orderNumberLabel) {
        _orderNumberLabel = [[UILabel alloc]init];
        _orderNumberLabel.text = @"61273979808093149678139";
        _orderNumberLabel.font = [UIFont systemFontOfSize:14.f];
        _orderNumberLabel.textColor = [ManagerEngine getColor:@"323232"];
    }
    return _orderNumberLabel;
}
- (UIView *)verticalLineView {
    if (!_verticalLineView) {
        _verticalLineView = [[UIView alloc]init];
        _verticalLineView.backgroundColor = [ManagerEngine getColor:@"dbd8d8"];
    }
    return _verticalLineView;
}
- (UIButton *)copysButton {
    if (!_copysButton) {
        _copysButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_copysButton setTitle:@"复制" forState:UIControlStateNormal];
        [_copysButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        @weakify(self);
        [[_copysButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = self.orderNumberLabel.text;
            [SVProgressHUD showSuccessWithStatus:@"复制成功"];
        }];
    }
    return _copysButton;
}
@end
