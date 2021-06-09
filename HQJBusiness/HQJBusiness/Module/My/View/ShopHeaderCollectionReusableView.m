//
//  ShopHeaderCollectionReusableView.m
//  HQJBusiness
//
//  Created by Ethan on 2021/6/3.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopHeaderCollectionReusableView.h"
#import "UIView+RoundedCorners.h"

@interface ShopHeaderCollectionReusableView ()
@property (nonatomic, strong) UIView  *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView  *lineView;
@end
@implementation ShopHeaderCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
        [self layoutView];
    }
    return self;
}
- (void)setSp_sectionTitle:(NSString *)sp_sectionTitle {
    _sp_sectionTitle = sp_sectionTitle;
    self.titleLabel.text = sp_sectionTitle;
}
- (void)addView {
    [self addSubview:self.bgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
}
- (void)layoutView {
    self.bgView.frame = CGRectMake(15, 0, WIDTH - 15 * 2, 128.f/3);
    [self.bgView hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0,  WIDTH - 15 * 2, 128.f/3) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:10.f];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView);
        make.left.mas_equalTo(self.bgView.mas_left).mas_offset(17);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.bgView);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).mas_offset(-1);

        make.height.mas_equalTo(0.5);
    }];
}
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
//        _bgView.layer.cornerRadius = 10.f;
//        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:48.f/3 weight:UIFontWeightBold];
        _titleLabel.textColor = [ManagerEngine getColor:@"1b1b1b"];
        _titleLabel.text = @"店铺管理";
    }
    return _titleLabel;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [ManagerEngine getColor:@"dcdcdc"];
    }
    return _lineView;
}
@end
