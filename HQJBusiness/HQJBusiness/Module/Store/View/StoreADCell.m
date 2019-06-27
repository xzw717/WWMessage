//
//  StoreADCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/26.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreADCell.h"
#define StoreADCelltitleFont 48 / 3.f
#define StoreADCellViewOffset 20.f
@interface StoreADCell ()
@property (nonatomic, strong) UIButton *promoteButton;
@property (nonatomic, strong) UIButton *financialButton;

@end
@implementation StoreADCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self storeADCell_addSubViwe];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)storeADCell_addSubViwe {
    [self.contentView addSubview:self.promoteButton];
    [self.contentView addSubview:self.financialButton];
}

- (void)updateConstraints {
    [self.promoteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.5);
    }];
    [self.financialButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.5);
    }];
    [super updateConstraints];
}

- (void)storeADCell_clickBtn:(UIButton *)send {
    if (self.clickADButtonBlock) {
        self.clickADButtonBlock(send.currentTitle);
    }
}

#pragma mark ---控件初始化
- (UIButton *)promoteButton {
    if (!_promoteButton) {
        _promoteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_promoteButton setTitle:@"推广中心" forState:UIControlStateNormal];
        [_promoteButton setImage:[UIImage imageNamed:@"store_promotionCenter"] forState:UIControlStateNormal];
        [_promoteButton setTitleColor:[ManagerEngine getColor:@"333333"] forState:UIControlStateNormal];
        [_promoteButton.titleLabel setFont:[UIFont systemFontOfSize:StoreADCelltitleFont]];
        [_promoteButton setImageEdgeInsets:UIEdgeInsetsMake(0, -StoreADCellViewOffset, 0, 0)];
        [_promoteButton addTarget:self action:@selector(storeADCell_clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _promoteButton;
}
- (UIButton *)financialButton {
    if (!_financialButton) {
        _financialButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_financialButton setTitle:@"物物理财" forState:UIControlStateNormal];
        [_financialButton setImage:[UIImage imageNamed:@"store_financialManagement"] forState:UIControlStateNormal];
        [_financialButton setTitleColor:[ManagerEngine getColor:@"333333"] forState:UIControlStateNormal];
        [_financialButton.titleLabel setFont:[UIFont systemFontOfSize:StoreADCelltitleFont]];
        [_financialButton setImageEdgeInsets:UIEdgeInsetsMake(0, -StoreADCellViewOffset, 0, 0)];
        [_financialButton addTarget:self action:@selector(storeADCell_clickBtn:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _financialButton;
}
@end
