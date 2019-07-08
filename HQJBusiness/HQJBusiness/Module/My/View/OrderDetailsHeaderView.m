//
//  OrderDetailsHeaderView.m
//  HQJBusiness
//
//  Created by mymac on 2017/9/13.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailsHeaderView.h"
@interface OrderDetailsHeaderView ()
@property (nonatomic, strong) UILabel *orderNumberLabel;
@property (nonatomic, strong) UIView *bottomLineView;
@end


@implementation OrderDetailsHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.orderNumberLabel];
//        [self addSubview:self.bottomLineView];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.orderNumberLabel.sd_layout.leftSpaceToView(self, kEDGE).centerYEqualToView(self).heightIs(10).widthIs(WIDTH - kEDGE * 2);
//        self.bottomLineView.sd_layout.leftSpaceToView(self, kEDGE).rightSpaceToView(self, 0).heightIs(0.5).topSpaceToView(self, 40);
    }
    return self;
}

- (void)setOrderNumber:(NSString *)orderNumber {
    self.orderNumberLabel.text = [NSString stringWithFormat:@"订单编号:%@",orderNumber];
}


- (UILabel *)orderNumberLabel {
    if(!_orderNumberLabel) {
        _orderNumberLabel = [[UILabel alloc]init];
        _orderNumberLabel.font = [UIFont systemFontOfSize:38/3.f];
    }
    return _orderNumberLabel;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor =[ManagerEngine getColor:@"cccccc"];
    }
    return _bottomLineView;
}
@end
