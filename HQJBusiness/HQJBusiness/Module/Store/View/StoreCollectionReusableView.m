//
//  StoreCollectionReusableView.m
//  HQJBusiness
//
//  Created by mymac on 2019/8/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreCollectionReusableView.h"
@interface StoreCollectionReusableView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *cellTitleLabel;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UIImageView  *rightArrowImageView;
@property (nonatomic, strong) UIButton *baseButton;
@end
@implementation StoreCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGRect viewFrame = CGRectMake(NewProportion(30) / 2, 8, WIDTH - NewProportion(30) * 2, NewProportion(150));
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewFrame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(NewProportion(30), NewProportion(30))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = viewFrame;
        maskLayer.path = maskPath.CGPath;
        
        self.layer.mask = maskLayer;
        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.path = maskPath.CGPath;
        pathLayer.fillColor = nil; // 默认为blackColor
        [self.layer addSublayer:pathLayer];
        
        
        self.backgroundColor = [UIColor whiteColor];
        [self myCollectionReusableView_createView];
    }
    return self;
}
- (void)allorder {

}
- (void)setItemAry:(NSArray<NSString *> *)itemAry {
    CGRect viewFrame;
    if ([[itemAry lastObject] isEqualToString:@"开店宝典"]) {
        viewFrame = CGRectMake(NewProportion(30) / 2, 8, WIDTH - NewProportion(30) * 2-2, NewProportion(150));
    
    } else {
       viewFrame = CGRectMake(NewProportion(30) / 2, 8, WIDTH - NewProportion(30) * 2, NewProportion(150));
  
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewFrame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(NewProportion(30), NewProportion(30))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = viewFrame;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = maskPath.CGPath;
    pathLayer.fillColor = nil; // 默认为blackColor
    self.titleImageView.image = [UIImage imageNamed:[itemAry firstObject]];
    self.cellTitleLabel.text = [itemAry lastObject];
}
- (void)myCollectionReusableView_createView {
    [self addSubview:self.baseButton];
    [self addSubview:self.cellTitleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.titleImageView];
    [self addSubview:self.rightArrowImageView];

    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-NewProportion(45));
        make.left.mas_equalTo(NewProportion(40)+ NewProportion(30));
//        make.width.mas_equalTo(22);
//        make.height.mas_equalTo(22);

    }];
    [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleImageView);
        make.left.mas_equalTo(self.titleImageView.mas_right).mas_offset(NewProportion(19));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.rightArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-NewProportion(40) - NewProportion(30));
        make.centerY.mas_equalTo(self.cellTitleLabel);
    }];
    [self.baseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

- (UIImageView *)titleImageView {
    if(!_titleImageView){
        _titleImageView = [[UIImageView alloc]init];
    }
    return _titleImageView;
}

- (UILabel *)cellTitleLabel {
    if (_cellTitleLabel == nil) {
        _cellTitleLabel = [[UILabel alloc]init];
        _cellTitleLabel.font = [UIFont systemFontOfSize:NewProportion(48) weight:UIFontWeightBold];
        _cellTitleLabel.textColor = [ManagerEngine getColor:@"323232"];
        _cellTitleLabel.text = @"我的订单";
    }
    return _cellTitleLabel;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [ManagerEngine getColor:@"dcdcdc"];
    }
    
    return _lineView;
}

- (UIImageView *)rightArrowImageView {
    if(!_rightArrowImageView){
        _rightArrowImageView = [[UIImageView alloc]init];
        _rightArrowImageView.image = [UIImage imageNamed:@"store_rightArrow"];
    }
    return _rightArrowImageView;
}

- (UIButton *)baseButton {
    if (!_baseButton) {
        _baseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        @weakify(self);
        [[_baseButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            !self.clickBtn ? :self.clickBtn();
        }];
    }
    return _baseButton;
}
@end
