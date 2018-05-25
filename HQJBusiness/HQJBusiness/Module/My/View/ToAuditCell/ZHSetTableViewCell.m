//
//  ZHSetTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/21.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZHSetTableViewCell.h"
@interface ZHSetTableViewCell()

@property (nonatomic,strong)ZW_Label *oneTitleLable;
@property (nonatomic,strong)ZW_Label *oneNumerical;
@property (nonatomic,strong)ZW_Label *oneTimerLabel;

@property (nonatomic,strong)UIView *lineView;

@property (nonatomic,strong)ZW_Label *twoTitleLable;
@property (nonatomic,strong)ZW_Label *twoNumerical;
@property (nonatomic,strong)ZW_Label *twoTimerLabel;
@end
@implementation ZHSetTableViewCell
-(ZW_Label *)oneTitleLable {
    if (!_oneTitleLable) {
        _oneTitleLable = [[ZW_Label alloc]initWithStr:@"积分消费时，赠送ZH值比例：" addSubView:self];
        _oneTitleLable.font = [UIFont systemFontOfSize:16.0];
        _oneTitleLable.hidden = YES;

    }
    return _oneTitleLable;
}


-(ZW_Label *)oneNumerical {
    if (!_oneNumerical) {
        _oneNumerical = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _oneNumerical.font = [UIFont systemFontOfSize:18.0];
        _oneNumerical.textColor = DefaultAPPColor;
        _oneNumerical.hidden = YES;
    }
    return _oneNumerical;
}

-(ZW_Label *)oneTimerLabel {
    if (!_oneTimerLabel) {
        _oneTimerLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _oneTimerLabel.font = [UIFont systemFontOfSize:12.0];
        _oneTimerLabel.textColor = [ManagerEngine getColor:@"999999"];
        _oneTimerLabel.hidden = YES;
    }
    return _oneTimerLabel;
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
        _lineView.hidden = YES;
        [self addSubview:_lineView];
    }
    
    
    return _lineView;
}




-(ZW_Label *)twoTitleLable {
    if (!_twoTitleLable) {
        _twoTitleLable = [[ZW_Label alloc]initWithStr:@"现金消费时，赠送ZH值比例：" addSubView:self];
        _twoTitleLable.font = [UIFont systemFontOfSize:16.0];
        _twoTitleLable.hidden = YES;
    }
    return _twoTitleLable;
}


-(ZW_Label *)twoNumerical {
    if (!_twoNumerical) {
        _twoNumerical = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _twoNumerical.font = [UIFont systemFontOfSize:18.0];
        _twoNumerical.textColor = DefaultAPPColor;
//        _twoNumerical.hidden = YES;


    }
    return _twoNumerical;
}

-(ZW_Label *)twoTimerLabel {
    if (!_twoTimerLabel) {
        _twoTimerLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _twoTimerLabel.font = [UIFont systemFontOfSize:12.0];
        _twoTimerLabel.textColor = [ManagerEngine getColor:@"999999"];
//        _twoTimerLabel.hidden = YES;
    }
    return _twoTimerLabel;
}





-(void)setModel:(ZHSetModel *)model {
    
    _model = model;
    self.oneNumerical.text =  [NSString stringWithFormat:@"%.2f%%",[model.bonusZH doubleValue] * 100];
    
    self.oneTimerLabel.text = [NSString stringWithFormat:@"%@",model.addtime];
    
    
    self.twoNumerical.text=  [NSString stringWithFormat:@"%.2f%%",[model.cashZH doubleValue] * 100];
    
    self.twoTimerLabel.text = [NSString stringWithFormat:@"%@",model.addtime];
    
    CGFloat titleWidth = [ManagerEngine setTextWidthStr:self.oneTitleLable.text andFont:[UIFont systemFontOfSize:16]];
    CGFloat oneNumerWith = [ManagerEngine setTextWidthStr:self.oneNumerical.text andFont:[UIFont systemFontOfSize:18.0]];
    
    CGFloat twoNumerWith = [ManagerEngine setTextWidthStr:self.twoNumerical.text andFont:[UIFont systemFontOfSize:18.0]];
    
    CGFloat timerWidth = [ManagerEngine setTextWidthStr:self.oneTimerLabel.text andFont:[UIFont systemFontOfSize:12.0]];
 
    
    
    
    
    if([model.cashZH floatValue] == 0 ){
        
        
        
        
        self.oneTitleLable.sd_layout.leftSpaceToView(self,18).topSpaceToView(self,20).heightIs(16).widthIs(titleWidth);
        self.oneNumerical .sd_layout.leftSpaceToView(self.oneTitleLable,0).topSpaceToView(self,18).heightIs(18).widthIs(oneNumerWith);
        self.oneTimerLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self.oneTitleLable,10).heightIs(12).widthIs(timerWidth);
        
        self.oneTitleLable.hidden = NO;
        self.oneNumerical.hidden  = NO;
        self.oneTimerLabel.hidden = NO;
        
        self.twoTitleLable.hidden = YES;
        self.twoTitleLable.hidden = YES;
        self.twoTitleLable.hidden = YES;
        self.lineView.hidden = YES;
        
    
        
    } else if ([model.bonusZH floatValue] == 0) {
        
        self.twoTitleLable.sd_layout.leftSpaceToView(self,18).topSpaceToView(self,20).heightIs(16).widthIs(titleWidth);
        self.twoNumerical .sd_layout.leftSpaceToView(self.twoTitleLable,0).topSpaceToView(self,18).heightIs(18).widthIs(twoNumerWith);
        self.twoTimerLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self.twoTitleLable,10).heightIs(12).widthIs(timerWidth);
        
        self.twoTitleLable.hidden = NO;
        self.twoTitleLable.hidden = NO;
        self.twoTitleLable.hidden = NO;
        
        self.oneTitleLable.hidden = YES;
        self.oneNumerical.hidden  = YES;
        self.oneTimerLabel.hidden = YES;
        self.lineView.hidden = YES;
    } else {
        
      
        
        self.oneTitleLable.sd_layout.leftSpaceToView(self,18).topSpaceToView(self,20).heightIs(16).widthIs(titleWidth);
        self.oneNumerical .sd_layout.leftSpaceToView(self.oneTitleLable,0).topEqualToView(self.oneTitleLable).heightIs(18).widthIs(oneNumerWith);
        self.oneTimerLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self.oneTitleLable,10).heightIs(12).widthIs(timerWidth);
        
        
        self.lineView.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self,70).heightIs(0.5).widthIs(self.mj_w - kEDGE);
        
        
        self.twoTitleLable.sd_layout.leftSpaceToView(self,18).topSpaceToView(self.lineView,20).heightIs(16).widthIs(titleWidth);
        self.twoNumerical .sd_layout.leftSpaceToView(self.twoTitleLable,0).topEqualToView(self.twoTitleLable).heightIs(18).widthIs(twoNumerWith);
        self.twoTimerLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self.twoTitleLable,10).heightIs(12).widthIs(timerWidth);

     
        self.oneTitleLable.hidden = NO;
        self.oneNumerical.hidden  = NO;
        self.oneTimerLabel.hidden = NO;
        
        self.twoTitleLable.hidden = NO;
        self.twoTitleLable.hidden = NO;
        self.twoTitleLable.hidden = NO;
        self.lineView.hidden = NO;
        
        
    }
    
    
}



-(void)setChildView {
    
    
    
    
    
    
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       

    }
    return self;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
