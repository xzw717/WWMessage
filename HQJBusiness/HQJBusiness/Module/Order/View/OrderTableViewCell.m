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
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) ZW_Label *nameLabel;
@property (nonatomic, strong) ZW_StateLabel *stateLabel;
@property (nonatomic, strong) ZW_Label *amountLabel; /// 金额
@property (nonatomic, strong) ZW_Label *priceLabel;
@property (nonatomic, strong) ZW_Label *countLabel;
@property (nonatomic, strong) UIImageView *headerImageView;
//@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation OrderTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [ManagerEngine getColor:@"eef0f6"];
        [self.contentView addSubview:self.maskView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)setOrderGoodsModel:(GoodsModel *)orderGoodsModel {
    _orderGoodsModel  = orderGoodsModel;
//    self.countLabel.hidden = NO;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HQJBImageDomainName,orderGoodsModel.mainpicture]] placeholderImage:[UIImage imageNamed:@"default_image"]];
    self.nameLabel.text = orderGoodsModel.goodsname;
    self.countLabel.text =  [NSString stringWithFormat:@"商品数量：%ld",(long)orderGoodsModel.goodscount];
    self.nameLabel.text =  [NSString stringWithFormat:@"¥%.2f",orderGoodsModel.goodsprice];

}

- (void)setOrderModel:(OrderModel *)orderModel {
    _orderModel = orderModel;
//    self.countLabel.hidden = YES;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HQJBImageDomainName,orderModel.shoppicture]] placeholderImage:[UIImage imageNamed:@"default_image"]];
    double changeTime = self.orderModel.date  / 1000;
    self.nameLabel.text = [NSString stringWithFormat:@"下单时间：%@",[ManagerEngine switchTimer:changeTime]];
    self.countLabel.text = [NSString stringWithFormat:@"商品数量：%ld",(long)orderModel.count];
}

- (void)setOrderDate:(NSString *)orderDate {
    _orderDate = orderDate;
//    self.priceLabel.text = [NSString stringWithFormat:@"日期：%@",[ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%@",orderDate]]];
    
}

- (void)updateConstraints {
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(30));
        make.right.mas_equalTo(self.contentView.mas_right).offset(- NewProportion(30));
        make.top.bottom.mas_equalTo(self.contentView);
    }];
//    self.bottomLineView.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(0.5);
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(40));
        make.centerY.mas_equalTo(self.maskView);
        make.width.height.mas_equalTo(NewProportion(151));
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(NewProportion(34));
        make.top.mas_equalTo(self.headerImageView);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countLabel);
        make.top.mas_equalTo(self.countLabel.mas_bottom).mas_offset(NewProportion(47));
    }];
  
//    self.headerImageView.sd_layout.leftSpaceToView(self.maskView, 15).topSpaceToView(self.maskView, 15).widthIs(S_RatioW(70.3125)).heightIs(S_RatioW(70.3125));
//    self.nameLabel.sd_layout.leftSpaceToView(self.headerImageView, 10).topEqualToView(self.headerImageView).heightIs(15);
////    self.amountLabel.sd_layout.leftEqualToView(self.nameLabel).topSpaceToView(self.countLabel, 20).heightIs(15);
//    self.priceLabel.sd_layout.leftEqualToView(self.nameLabel).bottomEqualToView(self.headerImageView).heightIs(14);
//    self.countLabel.sd_layout.rightSpaceToView(self.maskView, 15 ).bottomEqualToView( self.priceLabel).heightIs(14);
//
//    CGFloat maxwidth = WIDTH - 15 - 10 - 15 - S_RatioW(150);
//    [self.amountLabel setSingleLineAutoResizeWithMaxWidth:maxwidth];
//    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:maxwidth];
//    [self.countLabel setSingleLineAutoResizeWithMaxWidth:maxwidth];
//    [self.priceLabel setSingleLineAutoResizeWithMaxWidth:maxwidth];

    
    
    [super updateConstraints];
}

-(ZW_Label *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[ZW_Label alloc]initWithStr:@"dadasdasdasd" addSubView:self.maskView];
        _nameLabel.font =[UIFont systemFontOfSize:NewProportion(38)];
        _nameLabel.textColor = [ManagerEngine getColor:@"333333"];

    }
    
    return _nameLabel;
}

-(ZW_Label *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [[ZW_Label alloc]initWithStr:@"总价是：13213" addSubView:self.maskView];
        _amountLabel.font = [UIFont systemFontOfSize:S_RatioW(14.f)];
        _amountLabel.textColor = [ManagerEngine getColor:@"999999"];
        
    }
    return _amountLabel ;
}
-(ZW_Label *)priceLabel {
    
    if (!_priceLabel) {
        _priceLabel = [[ZW_Label alloc]initWithStr:@"时间是12341546" addSubView:self.maskView];
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
        _countLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self.maskView];
        _countLabel.font = [UIFont systemFontOfSize:NewProportion(48.f)];
        _countLabel.textColor = [ManagerEngine getColor:@"111111"];
    }
    return _countLabel;
}

//- (UIView *)bottomLineView {
//    if (!_bottomLineView) {
//        _bottomLineView = [[UIView alloc]init];
//        _bottomLineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
//        [self.contentView addSubview:_bottomLineView];
//    }
//    return _bottomLineView;
//}
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        [_maskView setBackgroundColor:[UIColor whiteColor]];
    }
    return _maskView;
}



@end
