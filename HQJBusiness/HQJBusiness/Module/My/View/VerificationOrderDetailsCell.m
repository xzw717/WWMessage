//
//  VerificationOrderDetailsCell.m
//  HQJBusiness
//
//  Created by mymac on 2017/9/14.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "VerificationOrderDetailsCell.h"
@interface VerificationOrderDetailsCell ()
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *countLabel;
@end

@implementation VerificationOrderDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
        [self setLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

 
    }
    return self;
}

- (void)settitleImage:(NSString *)imageStr name:(NSString *)name price:(NSString *)price count:(NSString *)count {
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HQJBImageDomainName,imageStr]] placeholderImage:[UIImage imageNamed:@"default_image"]];
    self.nameLabel.text = name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[price doubleValue]];
    self.countLabel.text = [NSString stringWithFormat:@"x%@",count];
}

- (void)addView {
    [self addSubview:self.titleImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.countLabel];
}

- (void)setLayout {
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:WIDTH - kEDGE * 2 - 61.5];
    [self.priceLabel setSingleLineAutoResizeWithMaxWidth:(WIDTH - kEDGE * 2 - 61.5)/2];
    [self.countLabel setSingleLineAutoResizeWithMaxWidth:(WIDTH - kEDGE * 2 - 61.5)/2];

    self.titleImageView.sd_layout.leftSpaceToView(self, kEDGE).centerYEqualToView(self).heightIs(274/3.f).widthEqualToHeight();
    self.nameLabel.sd_layout.leftSpaceToView(self.titleImageView, kEDGE).topEqualToView(self.titleImageView).heightIs(15);
    self.priceLabel.sd_layout.leftEqualToView(self.nameLabel).bottomEqualToView(self.titleImageView).heightIs(11);
    self.countLabel.sd_layout.rightSpaceToView(self, kEDGE).bottomEqualToView(self.priceLabel).heightIs(11);
}

- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
        _titleImageView.layer.masksToBounds = YES;
        _titleImageView.layer.cornerRadius = 5.f;
    }
    return _titleImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:40/3.f];
        _nameLabel.text = @"鸭腿饭";
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:40/3.f];
        _priceLabel.text = @"¥898";
    }
    return _priceLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textColor = [ManagerEngine getColor:@"8E8E8E"];
        _countLabel.font = [UIFont systemFontOfSize:36/3.f];
        _countLabel.text = @"x100";
    }
    return _countLabel;
}


@end
