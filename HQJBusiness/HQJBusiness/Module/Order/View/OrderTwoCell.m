//
//  OrderTwoCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/27.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderTwoCell.h"
#import "ZW_StateLabel.h"

@interface OrderTwoCell()
@property (nonatomic,strong)UIView *headerView;

@property (nonatomic,strong)ZW_Label *nameLabel;

@property (nonatomic,strong)ZW_StateLabel *stateLabel;

@property (nonatomic,strong)UIImageView *labelImage;

@property (nonatomic,strong)UIView *lineView;

@property (nonatomic,strong)UIImageView *titleImageView;

@property (nonatomic,strong)ZW_Label *goodsNameLabel;

@property (nonatomic,strong)ZW_Label *countLabel;

@property (nonatomic,strong)ZW_Label *priceLabel;

@property (nonatomic,strong)ZW_Label *timerLabel;

@end
@implementation OrderTwoCell


-(UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]init];
        _headerView.backgroundColor = DefaultBackgroundColor;
        [self addSubview:_headerView];
    }
    
    return _headerView;
}

-(ZW_Label *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
    }
    
    return _nameLabel;
}

-(ZW_StateLabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[ZW_StateLabel alloc]initWithStr:@"" addSubView:self];
    }
    return _stateLabel;
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
        [self addSubview:_lineView];
    }
    
    return _lineView;
}
-(UIImageView *)labelImage {
    if (!_labelImage) {
        _labelImage = [[UIImageView alloc]init];
        _labelImage.image = [UIImage imageNamed:@"ad_commodities"];
        [self addSubview:_labelImage];
    }
    
    
    return _labelImage;
}

-(UIImageView *)titleImageView {
    
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
        [self addSubview:_titleImageView];
    }
    
    return _titleImageView;
}

-(ZW_Label *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
    }
    
    return _goodsNameLabel;
}

-(ZW_Label *)countLabel {
    if (!_countLabel) {
        _countLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _countLabel.textColor = [ManagerEngine getColor:@"999999"];
        _countLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _countLabel;
}

-(ZW_Label *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _priceLabel.textColor = [ManagerEngine getColor:@"999999"];
        _priceLabel.font = [UIFont systemFontOfSize:14.0];
    }
    
    
    return _priceLabel;
}

-(ZW_Label *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _timerLabel.textColor = [ManagerEngine getColor:@"999999"];
        _timerLabel.font = [UIFont systemFontOfSize:14.0];
    }
    
    return _timerLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ];
    if(self){
        
    }return self;
}

-(void)setView {
    self.headerView.sd_layout.leftSpaceToView(self,0).topSpaceToView(self,0).heightIs(10).widthIs(WIDTH);
    
    CGFloat nameWidth = [ManagerEngine setTextWidthStr:self.nameLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.nameLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self.headerView,(40 - 17) / 2).heightIs(17).widthIs(nameWidth);
    
    CGFloat stateWidth = [ManagerEngine setTextWidthStr:self.stateLabel.text andFont:[UIFont systemFontOfSize:10.0]];
    self.stateLabel.sd_layout.leftSpaceToView(self.nameLabel,5).topEqualToView(self.nameLabel).heightIs(17).widthIs(stateWidth + 4);
    
    
    
    self.lineView.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self.headerView,40).heightIs(0.5).widthIs(WIDTH - kEDGE);
    
    self.titleImageView.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self.lineView,kEDGE).heightIs(100).widthIs(110);
    
    
    CGFloat goodsWidth = [ManagerEngine setTextWidthStr:self.goodsNameLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.goodsNameLabel.sd_layout.leftSpaceToView(self.titleImageView,10).topSpaceToView(self.lineView,21).heightIs(17).widthIs(goodsWidth);
    
    CGFloat countWidth = [ManagerEngine setTextWidthStr:self.countLabel.text andFont:[UIFont systemFontOfSize:14.0]];
    self.countLabel.sd_layout.leftEqualToView(self.goodsNameLabel).topSpaceToView(self.goodsNameLabel,12).heightIs(14).widthIs(countWidth);
    
    CGFloat priceWidth = [ManagerEngine setTextWidthStr:self.priceLabel.text andFont:[UIFont systemFontOfSize:14.0]];
    self.priceLabel.sd_layout.leftEqualToView(self.countLabel).topSpaceToView(self.countLabel,12).heightIs(14).widthIs(priceWidth);
    
    CGFloat timerWidth = [ManagerEngine setTextWidthStr:self.timerLabel.text andFont:[UIFont systemFontOfSize:14.0]];
    self.timerLabel.sd_layout.leftEqualToView(self.priceLabel).topSpaceToView(self.priceLabel,12).heightIs(14).widthIs(timerWidth);
    
}

-(void)setModel:(OrderModel *)model {
    _model = model;
    
    if (model.username) {
        self.nameLabel.text = model.username;
    } else {
        self.nameLabel.text = @"匿名";
    }
    
    
    self.stateLabel.text = model.state;
    
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageTest_URL,model.goodspicture]] placeholderImage:[UIImage imageNamed:@"default_image"]];
    
    self.goodsNameLabel.text = model.name;
    
    self.countLabel.text = [NSString stringWithFormat:@"数量：%ld",(long)model.count];
    
    self.priceLabel.text = [NSString stringWithFormat:@"总价：¥%.2f",model.price];
    
    self.timerLabel.text = [ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%ld",(long)model.date]];
    
    [self setView];
    if (model.type == 4 ) {
        self.labelImage.hidden = NO;
        self.labelImage.sd_layout.leftSpaceToView(self,WIDTH - 114 / 2).topSpaceToView(self.headerView,0).heightIs(114 / 2).widthIs(114 / 2);
        
    } else {
        self.labelImage.hidden = YES;

    }
}


@end
