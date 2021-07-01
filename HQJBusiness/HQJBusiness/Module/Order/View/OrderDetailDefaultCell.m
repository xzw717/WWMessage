//
//  OrderDetailDefaultCell.m
//  WuWuMap
//
//  Created by Ethan on 2021/6/21.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailDefaultCell.h"
@interface OrderDetailDefaultCell ()
@property (nonatomic, strong) UIImageView *shopImageView;
@property (nonatomic, strong) UILabel *titleKeyLabel;
@property (nonatomic, strong) UIImageView *phoneImageView;
@property (nonatomic, strong) UILabel *subTitleValueLabel;
@property (nonatomic, strong) UIButton *subTitleActionButton;


@end
@implementation OrderDetailDefaultCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self addView];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)dataWithDictionary:(NSDictionary *)dict {
    self.titleKeyLabel.text = dict.allKeys[0];
    self.subTitleValueLabel.text = dict.allValues[0];
}
- (void)cellWithtype:(NSString *)type {
    if ([type isEqualToString:isCallShop]) {
        [self.titleKeyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(15.f)+ NewProportion(48.f) + NewProportion(60.f));
        }];
        [self. subTitleValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-NewProportion(60));
            make.width.mas_equalTo(WIDTH / 2.f);
        }];
        [self.subTitleValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-NewProportion(60));
            make.centerY.mas_equalTo(self.contentView);
        }];
        self.titleKeyLabel.font =  [UIFont systemFontOfSize:NewProportion(40.f) weight:UIFontWeightBold] ;
        self.shopImageView.hidden = NO;
        self.phoneImageView.hidden = NO;
        self.subTitleActionButton.hidden = YES;
        self.subTitleValueLabel.textColor =  DefaultAPPColor ;
        self.subTitleValueLabel.font = [UIFont systemFontOfSize:NewProportion(40.f)];
    } else if ([type isEqualToString:isPrice]) {
        [self.titleKeyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(60.f));
        }];
        self.titleKeyLabel.font =  [UIFont systemFontOfSize:NewProportion(40.f)] ;
        self.shopImageView.hidden = YES;
        self.phoneImageView.hidden = YES;
        self.subTitleActionButton.hidden = YES;
        self.subTitleValueLabel.textColor =  MoneyDefaultColor ;
        self.subTitleValueLabel.font = [UIFont systemFontOfSize:NewProportion(54.f) weight:UIFontWeightBold];
    } else if ([type isEqualToString:isOrderid]) {
        [self.titleKeyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(60.f));
        }];
        [self. subTitleValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.subTitleActionButton.mas_left).mas_offset(-10.f);
            make.width.mas_equalTo(WIDTH / 2.f);
        }];
        self.titleKeyLabel.font =  [UIFont systemFontOfSize:NewProportion(40.f)] ;
        self.shopImageView.hidden = YES;
        self.phoneImageView.hidden = YES;
        self.subTitleActionButton.hidden = NO;
        self.subTitleValueLabel.textColor =  [ManagerEngine getColor:@"666666"] ;
        self.subTitleValueLabel.font = [UIFont systemFontOfSize:NewProportion(40.f) weight:UIFontWeightMedium];
    } else if ([type isEqualToString:isRemake]) {
        [self.titleKeyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(60.f));
        }];
        [self.subTitleValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-NewProportion(60.f));
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(WIDTH / 2.f);

        }];
        self.titleKeyLabel.font =  [UIFont systemFontOfSize:NewProportion(40.f)] ;
        self.shopImageView.hidden = YES;
        self.phoneImageView.hidden = YES;
        self.subTitleActionButton.hidden = YES;
        self.subTitleValueLabel.textColor =  DefaultAPPColor ;
        self.subTitleValueLabel.font = [UIFont systemFontOfSize:NewProportion(54.f) weight:UIFontWeightBold];
    } else {
        [self.titleKeyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(60.f));
        }];
        [self. subTitleValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-NewProportion(60.f));

        }];
        [self.subTitleValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-NewProportion(60));
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(WIDTH / 2);

        }];
        self.titleKeyLabel.font =  [UIFont systemFontOfSize:NewProportion(40.f)] ;
        self.shopImageView.hidden = YES;
        self.phoneImageView.hidden = YES;
        self.subTitleActionButton.hidden = YES;
        self.subTitleValueLabel.textColor =  [ManagerEngine getColor:@"666666"] ;
        self.subTitleValueLabel.font = [UIFont systemFontOfSize:NewProportion(40.f) weight:UIFontWeightMedium];
    }
}



- (void)clickCopy {
    !self.orderCopy ? : self.orderCopy();
}
- (void)addView {
    [self.contentView addSubview:self.shopImageView];
    [self.contentView addSubview:self.titleKeyLabel];
    [self.contentView addSubview:self.phoneImageView];
    [self.contentView addSubview:self.subTitleValueLabel];
    [self.contentView addSubview:self.subTitleActionButton];
    
}

- (void)updateConstraints {
    [self.shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(60));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(NewProportion(48));
    }];
    [self.titleKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (self.isCallShop) {
//            make.left.mas_equalTo(self.shopImageView.mas_right).mas_offset(NewProportion(15.f));
//        } else {
            make.left.mas_equalTo(NewProportion(60));
//        }
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.subTitleValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (self.isOrderid) {
//            make.right.mas_equalTo(self.subTitleActionButton.mas_left);
//        } else {
        make.right.mas_equalTo(-NewProportion(60));
//        }
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(WIDTH / 2);

    }];
    [self.subTitleActionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-NewProportion(70));
        make.centerY.height.mas_equalTo(self.contentView);
        make.width.mas_equalTo(NewProportion(130));
    }];
    [self.phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.subTitleValueLabel.mas_left).mas_offset(-NewProportion(20));
        make.centerY.width.height.mas_equalTo(self.shopImageView);
    }];
    
    [super updateConstraints];
}

- (UIImageView *)shopImageView {
    if (!_shopImageView) {
        _shopImageView = [[UIImageView alloc]init];
        _shopImageView.image = [UIImage imageNamed:@"orderDetail_business"];
        _shopImageView.hidden = YES;
    }
    return _shopImageView;
}
- (UILabel *)titleKeyLabel {
    if (!_titleKeyLabel) {
        _titleKeyLabel = [[UILabel alloc]init];
//        _titleKeyLabel.text = @"假装是标题";
        _titleKeyLabel.textColor = [ManagerEngine getColor:@"323232"];
    }
    return _titleKeyLabel;
}
- (UIImageView *)phoneImageView {
    if (!_phoneImageView) {
        _phoneImageView = [[UIImageView alloc]init];
        _phoneImageView.image = [UIImage imageNamed:@"orderDetail_contact"];
        _phoneImageView.hidden = YES;
    }
    return _phoneImageView;
}

- (UILabel *)subTitleValueLabel {
    if (!_subTitleValueLabel) {
        _subTitleValueLabel = [[UILabel alloc]init];
//        _subTitleValueLabel.text = @"假装是内容";
        _subTitleValueLabel.numberOfLines = 0;
        _subTitleValueLabel.textColor = [ManagerEngine getColor:@"666666"];
        _subTitleValueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _subTitleValueLabel;
}
- (UIButton *)subTitleActionButton {
    if (!_subTitleActionButton) {
        _subTitleActionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subTitleActionButton setTitle:@"复制" forState:UIControlStateNormal];
        [_subTitleActionButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        _subTitleActionButton.hidden = YES;
        _subTitleActionButton.titleLabel.font = [UIFont systemFontOfSize:NewProportion(40.f)];
        [_subTitleActionButton addTarget:self action:@selector(clickCopy) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subTitleActionButton;
}
@end
