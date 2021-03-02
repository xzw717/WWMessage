//
//  AddUnionSectionView.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/5.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UnionDetailSectionView.h"
#import "UIView+RoundedCorners.h"
#define LeftMargin 10
@interface UnionDetailSectionView ()
@property (nonatomic, strong) UILabel *nameLabel;
@end
@implementation UnionDetailSectionView
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.text = @"活动信息：";
        [_nameLabel hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0, WIDTH - 20, 40) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:10.f];
    }
    return _nameLabel;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.nameLabel];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)updateConstraints {
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(LeftMargin);
        make.right.mas_equalTo(-LeftMargin);
        make.bottom.mas_equalTo(self);
    }];
    
    [super updateConstraints];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
