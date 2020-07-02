//
//  XDDetailBottomView.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDDetailBottomView.h"
@interface XDDetailBottomView ()

@end
@implementation XDDetailBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutTheSubviews];

    }
    
    return self;
}
- (UILabel *)priceLabel {
    if ( _priceLabel == nil ) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:20.f];
        _priceLabel.backgroundColor = [ManagerEngine getColor:@"e6e6e9"];
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_priceLabel];

    }
    return _priceLabel;
}
- (UIButton *)payButton{
    if ( _payButton == nil ) {
        _payButton = [[UIButton alloc]init];
        _payButton.backgroundColor = [ManagerEngine getColor:@"ff4949"];
        [_payButton setTitle:@"立即加入" forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:50/3];
        [self addSubview:_payButton];

    }
    return _payButton;
}
- (void)layoutTheSubviews{
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.height.mas_equalTo(self);
        make.width.mas_equalTo(self.width * 0.4);
    }];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.height.mas_equalTo(self);
        make.width.mas_equalTo(self.width * 0.6);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
