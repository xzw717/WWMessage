//
//  OrderDetailFootView.m
//  HQJBusiness
//
//  Created by mymac on 2017/9/13.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailFootView.h"
@interface OrderDetailFootView ()
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *countTotalPricesLabel;
@end
@implementation OrderDetailFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.timeLabel];
        [self addSubview:self.countTotalPricesLabel];
        [self addSubview:self.bottomLineView];
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:WIDTH /2 - kEDGE];
        [self.countTotalPricesLabel setSingleLineAutoResizeWithMaxWidth:WIDTH /2 - kEDGE];
        self.timeLabel.sd_layout.leftSpaceToView(self, kEDGE).centerYEqualToView(self).heightIs(10);
        self.countTotalPricesLabel.sd_layout.rightSpaceToView(self, kEDGE).centerYEqualToView(self).heightIs(10);
        self.bottomLineView.sd_layout.leftSpaceToView(self, kEDGE).rightSpaceToView(self, 0).topSpaceToView(self, 1).heightIs(0.5);
    }
    return self;
}
- (void)orderTime:(NSString *)time count:(NSString *)count allPrice:(NSString *)price {
    self.timeLabel.text = time;
    self.countTotalPricesLabel.text = [NSString stringWithFormat:@"数量：%@   合计：¥%@",count,price];
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:10.f];
        _timeLabel.text = @"-456465--4654---454-65--";
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

- (UILabel *)countTotalPricesLabel {
    if (!_countTotalPricesLabel) {
        _countTotalPricesLabel = [[UILabel alloc]init];
        _countTotalPricesLabel.font = [UIFont systemFontOfSize:11.f];
        _countTotalPricesLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _countTotalPricesLabel;
}
- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor =[ManagerEngine getColor:@"cccccc"];
    }
    return _bottomLineView;
}
@end
