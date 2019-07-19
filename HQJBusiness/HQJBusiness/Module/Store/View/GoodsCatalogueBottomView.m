//
//  GoodsCatalogueBottomView.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/17.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsCatalogueBottomView.h"
@interface GoodsCatalogueBottomView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UIButton *addButton;
@end
@implementation GoodsCatalogueBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self goodsCatalogueBottomView_addSubView];
        [self goodsCatalogueBottomView_layoutSubView];
    }
    return self;
}
- (void)goodsCatalogueBottomView_addSubView {
    [self addSubview:self.titleLabel];
    [self addSubview:self.titleTextField];
    [self addSubview:self.addButton];

}
- (void)goodsCatalogueBottomView_layoutSubView {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(44 /3.f);
        make.left.mas_equalTo(72 / 3.f);
    }];
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(66 / 3.f);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(60 / 3.f);
        make.height.mas_equalTo(112 / 3.f);
        make.bottom.mas_equalTo(- 70 / 3.f);
        make.right.mas_equalTo(self.addButton.mas_left).mas_offset(- 30 / 3.f);
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- 66 / 3.f);
        make.top.bottom.mas_equalTo(self.titleTextField);
        make.width.mas_equalTo(233 / 3.f);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"添加商品目录";
        _titleLabel.textColor = [ManagerEngine getColor:@"909399"];
        _titleLabel.font = [UIFont systemFontOfSize:40 / 3.f];
    }
    return _titleLabel;
}
- (UITextField *)titleTextField {
    if (!_titleTextField) {
        _titleTextField = [[UITextField alloc]init];
        _titleTextField.placeholder = @"请输入商品目录名称";
        _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
        _titleTextField.textColor = [ManagerEngine getColor:@"909399"];
        _titleTextField.font = [UIFont systemFontOfSize:48 / 3.f];
    }
    return _titleTextField;
}
- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitle:@"添加" forState:UIControlStateNormal];
        _addButton.backgroundColor = DefaultAPPColor;
        _addButton.layer.masksToBounds = YES;
        _addButton.layer.cornerRadius = 20 / 3.f;
        _addButton.titleLabel.font = [UIFont systemFontOfSize:48 / 3.f];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        @weakify(self);
        [_addButton bk_addEventHandler:^(id  _Nonnull sender) {
            @strongify(self);
            if (self.bottomDelegate && [self.bottomDelegate respondsToSelector:@selector(bootomViewWithText:)]) {
                [self.bottomDelegate bootomViewWithText:self.titleTextField.text];
            }
            !self.textBlock ? : self.textBlock(self.titleTextField.text);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
@end
