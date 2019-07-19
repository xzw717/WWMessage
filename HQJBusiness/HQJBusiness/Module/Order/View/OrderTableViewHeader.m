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
@property (nonatomic, strong) UIView *rectCornerBackgroundView;
@end
@implementation OrderTableViewHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
//        self.contentView.backgroundColor = DefaultBackgroundColor;
        [self.contentView addSubview:self.rectCornerBackgroundView];
        [self.rectCornerBackgroundView addSubview:self.nameLabel];
        [self.rectCornerBackgroundView addSubview:self.stateLabel];
        
        [self setNeedsUpdateConstraints];

    }
    return self;
}

- (void)setState:(NSString *)state orderNumber:(NSString *)orderNumber {
    self.stateLabel.text = [NSString stringWithFormat:@" %@ ",state];
    self.nameLabel.text = [NSString stringWithFormat:@"订单编号:%@",orderNumber];

}


-(void)updateConstraints {
    self.rectCornerBackgroundView.frame = CGRectMake(0, 10, WIDTH - 20, 44);
    self.topLineView.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).heightIs(10);
//    self.bottomLineView.sd_layout.leftSpaceToView(self.contentView, kEDGE).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(0.5);
    self.nameLabel.sd_layout.leftSpaceToView(self.rectCornerBackgroundView, kEDGE).rightSpaceToView(self.stateLabel, kEDGE).centerYIs(self.rectCornerBackgroundView.centerY_sd).heightIs(kEDGE);
    self.stateLabel.sd_layout.rightSpaceToView(self.rectCornerBackgroundView, kEDGE).centerYIs(self.rectCornerBackgroundView.centerY_sd ).heightIs(13);
    [self.stateLabel setSingleLineAutoResizeWithMaxWidth:180];
    [self.rectCornerBackgroundView cornerRadiusWithType:UIRectCornerTopLeft | UIRectCornerTopRight radiusCount:TableViewCellCornerRadius];

    [super updateConstraints];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:38/3.f];
        _nameLabel.textColor = [ManagerEngine getColor:@"333333"];
    }
    return _nameLabel;
}
- (ZW_Label *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[ZW_Label alloc]init];
        _stateLabel.font = [UIFont systemFontOfSize:40/3.f];
        _stateLabel.textColor = RedColor;
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
//        [self.contentView addSubview:_bottomLineView];
    }
    return _bottomLineView;
}
- (UIView *)rectCornerBackgroundView {
    if (!_rectCornerBackgroundView) {
        _rectCornerBackgroundView = [[UIView alloc]init];
        _rectCornerBackgroundView.backgroundColor = [UIColor whiteColor];
        
    }
    return _rectCornerBackgroundView;
}
@end
