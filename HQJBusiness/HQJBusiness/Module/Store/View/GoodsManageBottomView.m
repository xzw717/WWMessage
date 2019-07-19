//
//  GoodsManageBottomView.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/10.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsManageBottomView.h"
@interface GoodsManageBottomView ()
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UILabel *allSelectLabel;
@property (nonatomic, strong) UIButton *operationButton;
@end
@implementation GoodsManageBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self goodsManageBottomView_addsubView];
        [self goodsManageBottomView_layoutView];
    }
    return self;
}
- (void)setIsMAllSelect:(BOOL)isMAllSelect {
    _isMAllSelect = isMAllSelect;
    [self btnImageState:isMAllSelect];

}
- (void)btnImageState:(BOOL)isLight {
    if (isLight == YES) {
        [self.selectButton setImage:[UIImage imageNamed:@"commoditymanagement_button_select"] forState:UIControlStateNormal];
        
    } else {
        [self.selectButton setImage:[UIImage imageNamed:@"commoditymanagement_button_unselect"] forState:UIControlStateNormal];
        
    }
}
- (void)clickSelectBtn {
    self.selectButton.selected = !self.selectButton.selected;
    [self btnImageState:self.selectButton.selected];
    !self.allSelect ? : self.allSelect(self.selectButton.selected);
}
- (void)clickOperationButton {
    !self.operationBlock ? :self.operationBlock();
}

- (void)goodsManageBottomView_addsubView {
    [self addSubview:self.selectButton];
    [self addSubview:self.allSelectLabel];
    [self addSubview:self.operationButton];

}
- (void)goodsManageBottomView_layoutView {
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(47 / 3.f);
        make.left.mas_equalTo(76 / 3.f);
        make.width.height.mas_equalTo(56 / 3.f);
    }];
    [self.allSelectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.selectButton);
        make.left.mas_equalTo(self.selectButton.mas_right).mas_offset(49 / 3.f);
    }];
    [self.operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-60 / 3.f);
        make.centerY.mas_equalTo(self.selectButton);
        make.width.mas_equalTo(224 / 3.f);
        make.height.mas_equalTo(82 / 3.f);
    }];
}
- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.selectButton setImage:[UIImage imageNamed:@"commoditymanagement_button_unselect"] forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(clickSelectBtn) forControlEvents:UIControlEventTouchUpInside];

    }
    return _selectButton;
}
- (UILabel *)allSelectLabel {
    if (!_allSelectLabel) {
        _allSelectLabel = [[UILabel alloc]init];
        _allSelectLabel.font = [UIFont systemFontOfSize:38 / 3.f];
        _allSelectLabel.textColor = [ManagerEngine getColor:@"333333"];
        _allSelectLabel.text = @"全选";
        _allSelectLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSelectBtn)];
        [_allSelectLabel addGestureRecognizer:tap];
    }
    return _allSelectLabel;
}
- (UIButton *)operationButton {
    if (!_operationButton) {
        _operationButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _operationButton.layer.masksToBounds = YES;
        _operationButton.layer.cornerRadius = 41 / 3.f;
        _operationButton.layer.borderColor = RedColor.CGColor;
        _operationButton.layer.borderWidth = .5f;
        [_operationButton setTitle:@"删除" forState:UIControlStateNormal];
        _operationButton.titleLabel.font = [UIFont systemFontOfSize:38 / 3.f];
        [_operationButton setTitleColor:RedColor forState:UIControlStateNormal];
        [_operationButton addTarget:self action:@selector(clickOperationButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _operationButton;
}
@end
