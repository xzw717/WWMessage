//
//  SelectBankCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/27.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SelectBankCell.h"
@interface SelectBankCell ()
@property (nonatomic,strong)UIImageView *titleImageView;
@property (nonatomic,strong)ZW_ChangeFigureColorLabel *bankNameLabel;
@property (nonatomic,strong)ZW_Label *userNameLabel;


@end
@implementation SelectBankCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.lineView];

    }
    return self;
}

-(UIImageView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
        [self addSubview:_titleImageView];
    }
    
    return _titleImageView;
}


-(ZW_ChangeFigureColorLabel *)bankNameLabel {
    if (!_bankNameLabel) {
        _bankNameLabel = [[ZW_ChangeFigureColorLabel alloc]initWithStr:@"" addSubView:self];
    }
    
    return _bankNameLabel;
}

-(ZW_Label *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _userNameLabel.textColor = [ManagerEngine getColor:@"999999"];
        _userNameLabel.font = [UIFont systemFontOfSize:15.0];
    }
    
    return _userNameLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
        _lineView.hidden = YES;
    }
    return _lineView;
}

-(void)setView {
    
    self.titleImageView.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self,17).heightIs(33).widthIs(33);
    
    CGFloat bankNameWidth = [ManagerEngine setTextWidthStr:self.bankNameLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.bankNameLabel.sd_layout.leftSpaceToView(self.titleImageView,10).topSpaceToView(self,14).heightIs(17).widthIs(bankNameWidth);
    CGFloat userNameWidth = [ManagerEngine setTextWidthStr:self.userNameLabel.text andFont:[UIFont systemFontOfSize:15.0]];
    self.userNameLabel.sd_layout.leftSpaceToView(self.titleImageView,10).topSpaceToView(self.bankNameLabel,8).heightIs(15).widthIs(userNameWidth);
    self.lineView.sd_layout.bottomEqualToView(self).rightSpaceToView(self, 0).leftSpaceToView(self, kEDGE).heightIs(0.5);
    

}

-(void)setModel:(SelectBankModel *)model {
    _model = model;
    
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.bankDetail[@"bankIcon"]]];
    
    self.bankNameLabel.zw_color = [ManagerEngine getColor:@"999999"];
  
    self.bankNameLabel.needChangeStr = [NSString stringWithFormat:@"(尾号%@)",[self cardNumberInercept:model.bankCard]];
  
    self.bankNameLabel.text = [NSString stringWithFormat:@"%@(尾号%@)",model.bankDetail[@"bankName"],[self cardNumberInercept:model.bankCard]];
    
    self.userNameLabel.text = model.bankDetail[@"bankName"];
    
    
    
    [self setView];
}

- (NSString *)cardNumberInercept:(NSString *)number {
    return  [number substringFromIndex:number.length- 4];
}

@end
