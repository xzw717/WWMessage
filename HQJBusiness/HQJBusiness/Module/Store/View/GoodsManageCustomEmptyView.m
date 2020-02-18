//
//  GoodsManageCustomEmptyView.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/11.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsManageCustomEmptyView.h"
@interface GoodsManageCustomEmptyView ()
@property (nonatomic, strong) UIImageView *emptyImageView;
@property (nonatomic, strong) UILabel *emptyLabel;
@property (nonatomic, strong) UIButton *emptyButton;

@end
@implementation GoodsManageCustomEmptyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self goodsManageCustomEmptyView_addSubView];
        [self goodsManageCustomEmptyView_layoutSubView];
    }
    return self;
}

- (void)clickBtn{
    if (self.customEmptyViewDelegate && [self.customEmptyViewDelegate respondsToSelector:@selector(clickEmptyViewbutton)]) {
        [self.customEmptyViewDelegate clickEmptyViewbutton];

    }
}

- (void)goodsManageCustomEmptyView_addSubView {
    [self addSubview:self.emptyImageView];
    [self addSubview:self.emptyLabel];
    [self addSubview:self.emptyButton];
}
- (void)goodsManageCustomEmptyView_layoutSubView {
    [self.emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
    [self.emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.emptyLabel.mas_top).mas_offset(-49 / 3.f);
        make.centerX.mas_equalTo(self.emptyLabel);
        make.width.mas_equalTo(604 / 3.f);
        make.height.mas_equalTo(504 / 3.f);

    }];
    [self.emptyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.emptyLabel.mas_bottom).mas_offset(196 / 3.f);
        make.centerX.mas_equalTo(self.emptyLabel);
        make.width.mas_equalTo(564 / 3.f);
        make.height.mas_equalTo(145 / 3.f);
    }];
    
    
    
}
- (UIImageView *)emptyImageView {
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc]init];
        _emptyImageView.image = [UIImage imageNamed:@"commoditymanagement_emptypages"];
    }
    return _emptyImageView;
}
- (UILabel *)emptyLabel {
    if (!_emptyLabel) {
        _emptyLabel = [[UILabel alloc]init];
        _emptyLabel.text = @"亲，暂时没有数据哟！";
        _emptyLabel.textColor = [ManagerEngine getColor:@"939191"];
        _emptyLabel.font = [UIFont systemFontOfSize:48 / 3.f];
    }
    return _emptyLabel;
}
- (UIButton *)emptyButton {
    if (!_emptyButton) {
        _emptyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _emptyButton.backgroundColor = DefaultAPPColor;
        [_emptyButton setTitle:@"添加商品" forState:UIControlStateNormal];
        [_emptyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _emptyButton.layer.masksToBounds = YES;
        _emptyButton.layer.cornerRadius = 73 / 3.f;
        [_emptyButton addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emptyButton;
}

@end
