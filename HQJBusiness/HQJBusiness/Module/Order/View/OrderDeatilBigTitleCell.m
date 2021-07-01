//
//  OrderDeatilBigTitleCell.m
//  WuWuMap
//
//  Created by Ethan on 2021/6/21.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDeatilBigTitleCell.h"
@interface OrderDeatilBigTitleCell ()
@property (nonatomic, strong) UILabel *bigTitleLabel;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation OrderDeatilBigTitleCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.bigTitleLabel];
        [self.contentView addSubview:self.lineView];
        [self.bigTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NewProportion(60.f));
            make.centerY.mas_equalTo(self.contentView);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
            make.left.mas_equalTo(NewProportion(30.f));
            make.height.mas_equalTo(0.5f);
        }];
    }
    return self;
}
- (void)setTitleStr:(NSString *)titleStr {
    self.bigTitleLabel.text = titleStr;
}
- (UILabel *)bigTitleLabel {
    if (!_bigTitleLabel) {
        _bigTitleLabel = [[UILabel alloc]init];
        _bigTitleLabel.textColor = [ManagerEngine getColor:@"111111"];
        _bigTitleLabel.font = [UIFont systemFontOfSize:NewProportion(48) weight:UIFontWeightBold];
    }
    return _bigTitleLabel;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
        
    }
    return _lineView;
}
@end
