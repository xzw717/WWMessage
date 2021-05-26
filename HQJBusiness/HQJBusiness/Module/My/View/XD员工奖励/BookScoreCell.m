//
//  BookScoreCell.m
//  WuWuMap
//
//  Created by 姚志中 on 2020/11/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "BookScoreCell.h"
@interface BookScoreCell ()
@property (nonatomic, strong) UILabel *orderLabel;
//@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation BookScoreCell

/// 2021-5-25 许峰说把订单号隐藏
//- (UILabel *)orderLabel {
//    if (!_orderLabel) {
//        _orderLabel = [[UILabel alloc]init];
//        _orderLabel.font = [UIFont systemFontOfSize:16];
//        _orderLabel.textColor = [ManagerEngine getColor:@"777777"];
//        _orderLabel.textAlignment = NSTextAlignmentLeft;
//    }
//    return _orderLabel;
//}
//- (UIView *)lineView{
//    if (!_lineView) {
//        _lineView = [[UIView alloc]init];
//        _lineView.backgroundColor = [ManagerEngine getColor:@"777777"];
//    }
//    return _lineView;
//}
- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.font = [UIFont systemFontOfSize:16];
        _typeLabel.textColor = [UIColor blackColor];
        _typeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _typeLabel;
}
- (UILabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [[UILabel alloc]init];
        _amountLabel.font = [UIFont systemFontOfSize:17];
        _amountLabel.textColor = [UIColor blackColor];
        _amountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _amountLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [ManagerEngine getColor:@"777777"];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

//        [self.contentView addSubview:self.orderLabel];
//        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.typeLabel];
        [self.contentView addSubview:self.amountLabel];
        [self.contentView addSubview:self.timeLabel];
        [self layoutTheSubviews];
    }
    
    
    
    return self;
}



- (void)layoutTheSubviews {
//    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.mas_equalTo(5);
//        make.width.mas_equalTo(WIDTH - 15);
//        make.height.mas_equalTo(20);
//    }];
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.mas_equalTo(self.orderLabel.mas_bottom);
//        make.width.equalTo(self.orderLabel);
//        make.height.mas_equalTo(0.3f);
//    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(5);
        make.width.mas_equalTo(WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeLabel.right);
        make.top.mas_equalTo(self.orderLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.amountLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20);
    }];
}
- (void)setModel:(BooKScoreModel *)model{
//    self.orderLabel.text = [NSString stringWithFormat:@"订单号：%@",model.orderNo];
    self.typeLabel.text = model.uname;
    self.amountLabel.text = model.activityScore;
    self.timeLabel.text = [ManagerEngine zzReverseSwitchTimer:model.createTime];
}

@end
