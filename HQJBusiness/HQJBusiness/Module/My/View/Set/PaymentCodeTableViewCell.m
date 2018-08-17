//
//  PaymentCodeTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2017/9/27.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "PaymentCodeTableViewCell.h"
@interface PaymentCodeTableViewCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, copy  ) NSString *codeType;
@property (nonatomic, strong) UIImageView *codeImageView;

@end
@implementation PaymentCodeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (void)addSubview {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.codeImageView];
    [self.bgView addSubview:self.iconImageView];
    [self.bgView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:WIDTH / 2];
    self.codeImageView.sd_layout.rightSpaceToView(self.bgView, kEDGE).centerYEqualToView(self.bgView).heightIs(22).widthEqualToHeight();
    self.iconImageView.sd_layout.leftSpaceToView(self.bgView, 5).centerYEqualToView(self.bgView).heightIs(34).widthIs(40);
    self.titleLabel.sd_layout.leftSpaceToView(self.iconImageView, 25).centerYEqualToView(self.bgView).heightIs(15);
    
}

- (void)setTitleModel:(PaymentCodeModel *)model {
    [self setTitle:[self rankDateSource][model.useage] isAddCode:NO];
}

- (void)setPaymentCodeType:(NSString *)type  {
    self.codeType = type;
    [self setTitle:[self rankDateSource][type] isAddCode:YES];
}

- (void)setTitle:(NSString *)title isAddCode:(BOOL)isAddCode {
    if ([title isEqualToString:@"合其家"]) {
        self.bgView.layer.borderColor = [ManagerEngine getColor:@"cccccc"].CGColor;
        self.bgView.layer.borderWidth = 0.5f;
        self.titleLabel.textColor = [UIColor blackColor];
    }
    
    if (isAddCode) {
        if ([title isEqualToString:@"合其家"]) {
            self.codeImageView.image = [UIImage imageNamed:@"icon_scan_grey"] ;
           } else {
               self.codeImageView.image = [UIImage imageNamed:@"-icon_scan_white"];
           }
    } else {
        if ([title isEqualToString:@"合其家"]) {
            self.codeImageView.image = [UIImage imageNamed:@"icon_QR_grey"];
        } else {
            self.codeImageView.image = [UIImage imageNamed:@"icon_QR_white"];
        }
    }
    self.titleLabel.text = title;
    self.bgView.backgroundColor = [ManagerEngine getColor:[self setDateSource][title][@"bgColor"]];
    self.iconImageView.image = [UIImage imageNamed:[self setDateSource][title][@"iconName"]];
}

- (void)addCode {
    !self.typeBlcok ? : self.typeBlcok(self.codeType);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(kEDGE, 5, WIDTH - kEDGE * 2, 50)];
        _bgView.backgroundColor = [UIColor redColor];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 5;
    }
    return _bgView;
}

- (UIImageView *)codeImageView {
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc]init];
    }
    return _codeImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}


-  (NSDictionary *)setDateSource {
    return @{@"合其家":@{@"bgColor":@"FFFFFF",
                      @"iconName":@"icon_heqij"},
             @"支付宝":@{@"bgColor":@"439FFF",
                      @"iconName":@"icon_zhifubao"},
             @"微信支付":@{@"bgColor":@"84BB45",
                      @"iconName":@"icon_weichat"},
             @"收钱吧":@{@"bgColor":@"FFB702",
                      @"iconName":@"icon_shou"},
             @"百度钱包":@{@"bgColor":@"E91921",
                      @"iconName":@"icon_baidu"},
             @"QQ钱包":@{@"bgColor":@"FF9214",
                      @"iconName":@"icon_QQ"},
             @"京东钱包":@{@"bgColor":@"C21420",
                      @"iconName":@"icon_JD"},
             @"其他平台":@{@"bgColor":@"cccccc",
                      @"iconName":@"矩形-15"}
             };
}

- (NSDictionary *)rankDateSource {
    return @{@"1":@"合其家",
             @"2":@"支付宝",
             @"3":@"微信支付",
             @"4":@"收钱吧",
             @"5":@"百度钱包",
             @"6":@"QQ钱包",
             @"7":@"京东钱包",
             @"8":@"其他平台",};
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
