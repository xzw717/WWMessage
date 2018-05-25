//
//  OrderTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2017/8/18.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "ZW_StateLabel.h"
@interface OrderTableViewCell ()
@property (nonatomic, strong) ZW_Label *nameLabel;
@property (nonatomic, strong) ZW_StateLabel *stateLabel;
@property (nonatomic, strong) ZW_Label *amountLabel; /// 金额
@property (nonatomic, strong) ZW_Label *priceLabel;
@property (nonatomic, strong) ZW_Label *countLabel;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation OrderTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)setOrderGoodsModel:(GoodsModel *)orderGoodsModel {
    _orderGoodsModel  = orderGoodsModel;
    self.countLabel.hidden = NO;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageTest_URL,orderGoodsModel.mainpicture]] placeholderImage:[UIImage imageNamed:@"default_image"]];
    self.nameLabel.text = orderGoodsModel.goodsname;
    self.countLabel.text =  [NSString stringWithFormat:@"x%ld",(long)orderGoodsModel.goodscount];
    self.priceLabel.text =  [NSString stringWithFormat:@"¥%.2f",orderGoodsModel.goodsprice];

}

- (void)setOrderModel:(OrderModel *)orderModel {
    _orderModel = orderModel;
    self.countLabel.hidden = YES;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageTest_URL,orderModel.shoppicture]] placeholderImage:[UIImage imageNamed:@"default_image"]];
    self.nameLabel.text = @"匿名";
    self.priceLabel.text = [NSString stringWithFormat:@"转账金额：¥%.2f",orderModel.price];
}

- (void)setOrderDate:(NSString *)orderDate {
    _orderDate = orderDate;
//    self.priceLabel.text = [NSString stringWithFormat:@"日期：%@",[ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%@",orderDate]]];
    
}

- (void)updateConstraints {
    self.bottomLineView.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(0.5);
    self.headerImageView.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 15).widthIs(S_RatioW(70.3125)).heightIs(S_RatioW(70.3125));
    self.nameLabel.sd_layout.leftSpaceToView(self.headerImageView, 10).topEqualToView(self.headerImageView).heightIs(15);
//    self.amountLabel.sd_layout.leftEqualToView(self.nameLabel).topSpaceToView(self.countLabel, 20).heightIs(15);
    self.priceLabel.sd_layout.leftEqualToView(self.nameLabel).bottomEqualToView(self.headerImageView).heightIs(14);
    self.countLabel.sd_layout.rightSpaceToView(self.contentView, 15 ).bottomEqualToView( self.priceLabel).heightIs(14);

    CGFloat maxwidth = WIDTH - 15 - 10 - 15 - S_RatioW(150);
    [self.amountLabel setSingleLineAutoResizeWithMaxWidth:maxwidth];
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:maxwidth];
    [self.countLabel setSingleLineAutoResizeWithMaxWidth:maxwidth];
    [self.priceLabel setSingleLineAutoResizeWithMaxWidth:maxwidth];

    
    
    [super updateConstraints];
}

-(ZW_Label *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[ZW_Label alloc]initWithStr:@"dadasdasdasd" addSubView:self.contentView];
        _nameLabel.font =[UIFont systemFontOfSize:S_RatioW(15.f)];
    }
    
    return _nameLabel;
}

-(ZW_Label *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [[ZW_Label alloc]initWithStr:@"总价是：13213" addSubView:self.contentView];
        _amountLabel.font = [UIFont systemFontOfSize:S_RatioW(14.f)];
        _amountLabel.textColor = [ManagerEngine getColor:@"999999"];
        
    }
    return _amountLabel ;
}
-(ZW_Label *)priceLabel {
    
    if (!_priceLabel) {
        _priceLabel = [[ZW_Label alloc]initWithStr:@"时间是12341546" addSubView:self.contentView];
        _priceLabel.font = [UIFont systemFontOfSize:S_RatioW(14.f)];
        _priceLabel.textColor = [ManagerEngine getColor:@"999999"];
        
    }
    return _priceLabel ;
}

-(UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_headerImageView];
    }
    return _headerImageView;
}

- (ZW_Label *)countLabel {
    if (!_countLabel) {
        _countLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self.contentView];
        _countLabel.font = [UIFont systemFontOfSize:S_RatioW(14.f)];
        _countLabel.textColor = [ManagerEngine getColor:@"999999"];
    }
    return _countLabel;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
        [self.contentView addSubview:_bottomLineView];
    }
    return _bottomLineView;
}



@end
