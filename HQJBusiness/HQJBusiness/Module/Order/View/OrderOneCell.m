//
//  OrderOneCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/26.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderOneCell.h"
#import "ZW_StateLabel.h"

@interface OrderOneCell ()
@property (nonatomic,strong) ZW_Label *nameLabel;
@property (nonatomic,strong) ZW_StateLabel *stateLabel;
@property (nonatomic,strong) ZW_Label *amountLabel;
@property (nonatomic,strong) ZW_Label *timerLabel;
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;

@end
@implementation OrderOneCell
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

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc]init];
        _topLineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
    }
    return _topLineView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
    }
    return _bottomLineView;
}

-(ZW_Label *)amountLabel {
    
    if (!_amountLabel) {
        _amountLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _amountLabel.font = [UIFont systemFontOfSize:14.0];
        _amountLabel.textColor = [ManagerEngine getColor:@"999999"];
        
    }
    return _amountLabel ;
}
-(ZW_Label *)timerLabel {
    
    if (!_timerLabel) {
        _timerLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _timerLabel.font = [UIFont systemFontOfSize:14.0];
        _timerLabel.textColor = [ManagerEngine getColor:@"999999"];
        
    }
    return _timerLabel ;
}
-(UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
        [self addSubview:_headerImageView];
    }
    return _headerImageView;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    
    return self;
}


-(void)setModel:(OrderModel *)model {
    _model = model;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HQJBImageDomainName,model.shoppicture]] placeholderImage:[UIImage imageNamed:@"default_image"]];
    
    if (model.username) {
        self.nameLabel.text = model.username;
    } else {
        self.nameLabel.text = @"匿名";
    }
    self.stateLabel.text = [NSString stringWithFormat:@"%@",model.state];
    if (model.type == 1) {
        
    } else {
        self.amountLabel.text = [NSString stringWithFormat:@"收款金额：¥%.2f",model.price];

    }
    
    self.timerLabel.text = [NSString stringWithFormat:@"%@",[ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%ld",(long)model.date]]];
    
    [self setView];
  
}


-(void)setView {
    
    [self.nameLabel setupAutoWidthWithRightView:self rightMargin:15.f];
    [self.stateLabel setupAutoWidthWithRightView:self rightMargin:15.f];
    [self.amountLabel setupAutoWidthWithRightView:self rightMargin:15.f];
    [self.timerLabel setupAutoWidthWithRightView:self rightMargin:15.f];
//    CGFloat nameWidth = [ManagerEngine setTextWidthStr:self.nameLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    
    
    self.topLineView.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0.5f).heightIs(0.5);
    self.bottomLineView.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0.5f).heightIs(0.5);

    self.nameLabel.sd_layout.leftSpaceToView(self.headerImageView,10).topSpaceToView(self,27).heightIs(17);
    
    CGFloat stateWidth = [ManagerEngine setTextWidthStr:self.stateLabel.text andFont:[UIFont systemFontOfSize:10.0]];
    self.stateLabel.sd_layout.leftSpaceToView(self.nameLabel,5).topSpaceToView(self,27).heightIs(17).widthIs(stateWidth + 4);
    
    
    CGFloat amountWidth = [ManagerEngine setTextWidthStr:self.amountLabel.text andFont:[UIFont systemFontOfSize:14.0]];
    self.amountLabel.sd_layout.leftEqualToView(self.nameLabel).topSpaceToView(self.nameLabel,18).heightIs(14).widthIs(amountWidth);
    
    CGFloat timerWidth = [ManagerEngine setTextWidthStr:self.timerLabel.text andFont:[UIFont systemFontOfSize:14.0]];
    self.timerLabel.sd_layout.leftEqualToView(self.nameLabel).topSpaceToView(self.amountLabel,18).heightIs(14).widthIs(timerWidth);
    
}

@end
