//
//  MyHeaderView.m
//  HQJBusiness
//
//  Created by Ethan on 2021/6/8.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MyHeaderView.h"
@interface MyHeaderView ()
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *qualificationLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end
@implementation MyHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = DefaultAPPColor;
        [self addSubview:self.headerImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.qualificationLabel];
        [self addSubview:self.arrowImageView];
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(20.f);
            make.width.height.mas_equalTo(66.66f);
            
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headerImageView.mas_right).mas_offset(13.33f);
            make.top.mas_equalTo(28.33f);

        }];
        [self.qualificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(10.f);
            make.width.mas_equalTo(100.f);
            make.height.mas_equalTo(20.f);
        }];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(-16.66f);
            make.width.height.mas_equalTo(16.66f);
        }];

        
    }
    return self;
}
- (void)shopName:(NSString *)name shopRole:(NSString *)role {
    self.titleLabel.text = name;
    self.qualificationLabel.text = role;
    CGFloat width1=[role boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.width;
    [self.qualificationLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width1 + 20);
    }];

}
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.image = [UIImage imageNamed:@"Portrait_LYMYGTT"];
        _headerImageView.layer.cornerRadius = 5.f;
        _headerImageView.layer.masksToBounds = YES;
    }
    return _headerImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text =  [NameSingle shareInstance].name;
    }
    return _titleLabel;
}

- (UILabel *)qualificationLabel {
    if (!_qualificationLabel) {
        _qualificationLabel = [[UILabel alloc]init];
        _qualificationLabel.font = [UIFont systemFontOfSize:12.f];
        _qualificationLabel.textColor = [UIColor whiteColor];
        _qualificationLabel.textAlignment = NSTextAlignmentCenter;
        _qualificationLabel.layer.cornerRadius = 10.f;
        _qualificationLabel.layer.masksToBounds = YES;
        _qualificationLabel.layer.borderWidth = 0.5f;
        _qualificationLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        _qualificationLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        _qualificationLabel.text  =  [NameSingle shareInstance].role;
//        @"股份 ● XD商家";
    }
    return _qualificationLabel;
}


- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"iocn_Select-right-1"];
    }
    return _arrowImageView;
}


@end
