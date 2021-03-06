//
//  OrderTableViewHeader.m
//  HQJBusiness
//
//  Created by mymac on 2017/8/17.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderTableViewHeader.h"
@interface OrderTableViewHeader ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) ZW_Label *stateLabel;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;
@end
@implementation OrderTableViewHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.stateLabel];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)setState:(NSString *)state orderNumber:(NSString *)orderNumber {
    self.stateLabel.text = [NSString stringWithFormat:@" %@ ",state];
    if ([state isEqualToString:@"待使用"]) {
        self.stateLabel.textColor = [ManagerEngine getColor:@"f58700"];
    } else if([state isEqualToString:@"待评价"]) {
        
        self.stateLabel.textColor = [ManagerEngine getColor:@"1ab2ff"];
        
    } else if([state isEqualToString:@"退款中"]) {
        
        self.stateLabel.textColor = [ManagerEngine getColor:@"ff5500"];
        
    } else if([state isEqualToString:@"订单取消"]) {
        
        self.stateLabel.textColor = [ManagerEngine getColor:@"ff0000"];
        
    } else {
        
        self.stateLabel.textColor = [ManagerEngine getColor:@"29cc29"];
        
    }
    self.nameLabel.text = [NSString stringWithFormat:@"订单编号:%@",orderNumber];

}


-(void)updateConstraints {
    self.topLineView.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).heightIs(10);
    self.bottomLineView.sd_layout.leftSpaceToView(self.contentView, kEDGE).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(0.5);
    self.nameLabel.sd_layout.leftSpaceToView(self.contentView, kEDGE).rightSpaceToView(self.stateLabel, kEDGE).centerYIs(self.contentView.centerY_sd + 5).heightIs(kEDGE);
    self.stateLabel.sd_layout.rightSpaceToView(self.contentView, kEDGE).centerYIs(self.contentView.centerY_sd + 5).heightIs(13);
    [self.stateLabel setSingleLineAutoResizeWithMaxWidth:180];
    [super updateConstraints];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:11.f];
        _nameLabel.textColor = [ManagerEngine getColor:@"999999"];
    }
    return _nameLabel;
}
- (ZW_Label *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[ZW_Label alloc]init];
        _stateLabel.font = [UIFont systemFontOfSize:12.f];
    }
    return _stateLabel;
}

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc]init];
        _topLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_topLineView];
    }
    return _topLineView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
        [self.contentView addSubview:_bottomLineView];
    }
    return _bottomLineView;
}
@end
