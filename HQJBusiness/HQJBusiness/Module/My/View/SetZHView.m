//
//  SetZHView.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/17.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SetZHView.h"
@interface SetZHView()<UITextFieldDelegate>
@property (nonatomic,strong)ZW_Label * titLabel;
@property (nonatomic,strong)ZW_Label * contentLabel;
@property (nonatomic,strong)ZW_Label * contentTwoLabel;

@property (nonatomic,strong)NSArray *titArray;

@end
@implementation SetZHView


-(ZW_Label *)titLabel {
    if (!_titLabel) {
        _titLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _titLabel.font = [UIFont systemFontOfSize:17.f];
    }
    
    return _titLabel ;
}

-(ZW_Label *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel = [[ZW_Label alloc]initWithStr:@"赠送消费金额" addSubView:self];
        _contentLabel.font = [UIFont systemFontOfSize:15.0];
    }
    
    return _contentLabel;
}

-(ZW_Label *)contentTwoLabel {
    if (!_contentTwoLabel) {
        _contentTwoLabel = [[ZW_Label alloc]initWithStr:@"%等额的ZH值" addSubView:self];
        _contentTwoLabel.font = [UIFont systemFontOfSize:15.0];
        
    }
    
    return _contentTwoLabel;
}

-(ZW_TextField *)proportionTextField {
    if (!_proportionTextField) {
        _proportionTextField = [[ZW_TextField alloc]initWithPlaceholder:@"" isType:isMobileType addSubView:self];
        _proportionTextField.delegate = self;
    }
    
    return _proportionTextField;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame ];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
    
}
-(ZW_ChangeFigureColorLabel *)detaileLabel {
    if (!_detaileLabel) {
        _detaileLabel =[[ZW_ChangeFigureColorLabel alloc]initWithStr:@"" addSubView:self];
        _detaileLabel.font = [UIFont systemFontOfSize:15.0];
        
        
    }
    
    
    return _detaileLabel;
}
-(void)setTitleStr:(NSString *)titleStr andplaceholderStr:(NSString *)placeholderStr {
    
    self.titLabel.text = titleStr;
    self.proportionTextField.placeholder = placeholderStr;
    
    
    CGFloat contentOneWidth = [ManagerEngine setTextWidthStr:self.contentLabel.text andFont:[UIFont systemFontOfSize:15.0]];
    CGFloat contentTwoWidth = [ManagerEngine setTextWidthStr:self.contentTwoLabel.text andFont:[UIFont systemFontOfSize:15.0]];
    CGFloat titWidth = [ManagerEngine setTextWidthStr:self.titLabel.text andFont:[UIFont systemFontOfSize:17.f]];
    
    self.titLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self,30).heightIs(17).widthIs(titWidth);
    self.contentLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self.titLabel,30).heightIs(15).widthIs(contentOneWidth);
    self.proportionTextField.sd_layout.leftSpaceToView(self.contentLabel,10).topSpaceToView(self.titLabel, 30 - (44 - 15) / 2 ).heightIs(44).widthIs(WIDTH - kEDGE * 2 - contentOneWidth - contentTwoWidth - 10 * 2);
    self.contentTwoLabel.sd_layout.leftSpaceToView(self,WIDTH - kEDGE - contentTwoWidth).topEqualToView(self.contentLabel).heightIs(15).widthIs(contentTwoWidth);
    
    CGFloat deteilWidth = [ManagerEngine setTextWidthStr:self.detaileLabel.text andFont:[UIFont systemFontOfSize:15.0]];
    self.detaileLabel.sd_layout.leftEqualToView(self.contentLabel).topSpaceToView(self.contentLabel,30).heightIs(15).widthIs(deteilWidth);
    
}

-(void)setDetaileLabelStr:(NSString *)detaileLabelStr {
    
    self.detaileLabel.text = detaileLabelStr;
    CGFloat deteilWidth = [ManagerEngine setTextWidthStr:self.detaileLabel.text andFont:[UIFont systemFontOfSize:15.0]];
    self.detaileLabel.sd_layout.leftEqualToView(self.contentLabel).topSpaceToView(self.contentLabel,30).heightIs(15).widthIs(deteilWidth);
    
    
}




@end
