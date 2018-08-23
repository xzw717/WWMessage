//
//  MyListTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MyListTableViewCell.h"


@interface MyListTableViewCell()
@property (nonatomic,strong)ZW_Label *amountOneLabel;
@property (nonatomic,strong)ZW_Label *typeLabel;
@property (nonatomic,strong)UIImageView *arrowImageView;
@property (nonatomic,strong)ZW_Label *timerLabel;
@property (nonatomic,strong)ZW_Label *amountTwoLabel;




@end

@implementation MyListTableViewCell

-(ZW_Label *)amountOneLabel {
    if ( _amountOneLabel == nil ) {
        _amountOneLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _amountOneLabel.font = [UIFont systemFontOfSize:16.0];
    }
    
    
    return _amountOneLabel;
}

-(ZW_Label *)amountTwoLabel {
    
    if ( _amountTwoLabel == nil ) {
        _amountTwoLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _amountTwoLabel.font = [UIFont systemFontOfSize:16.0];
        _amountTwoLabel.textColor = DefaultAPPColor;
    }
    return _amountTwoLabel;
}

-(ZW_Label *)typeLabel {
    if ( _typeLabel == nil ) {
        _typeLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _typeLabel.font = [UIFont systemFontOfSize:10.0];
        _typeLabel.textColor = [ManagerEngine getColor:@"999999"];
        
    }
    return _typeLabel;
}

-(UIImageView *)arrowImageView {
    if ( _arrowImageView == nil ) {
        _arrowImageView =[[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"arrow_right_gray"];
        [self addSubview:_arrowImageView];
    }
    
    
    return _arrowImageView;
}

-(ZW_Label *)timerLabel {
    if ( _timerLabel == nil ) {
        _timerLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _timerLabel.font = [UIFont systemFontOfSize:10.0];
        _timerLabel.textColor = [ManagerEngine getColor:@"999999"];
    }
    
    return _timerLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
    
}


-(void)setModel:(MyListModel *)model {
    
    NSString *oneUnitStr;
    NSString *twoUnitStr;
    NSString *oneAmountStr;
    NSString *twoAmountStr;
    if (model.camount) {
        twoAmountStr = model.camount;
        //        amountTwoLabelStr = [NSString stringWithFormat:@"%.2f",model.camount.floatValue];
    } else {
        twoAmountStr = model.amount;
        //        amountTwoLabelStr = [NSString stringWithFormat:@"%.2f",model.amount.floatValue];
    }
    if (model.tradetype.integerValue == 5) {
        oneUnitStr = @"积分";
        twoUnitStr = @"元";
        oneAmountStr = [ManagerEngine retainScale:model.amount afterPoint:5];
        twoAmountStr = [ManagerEngine retainScale:twoAmountStr afterPoint:2];
    } else if (model.tradetype.integerValue == 11){
        oneUnitStr = @"积分";
        twoUnitStr = @"RY";
        oneAmountStr = [ManagerEngine retainScale:model.amount afterPoint:5];
        twoAmountStr = [ManagerEngine retainScale:twoAmountStr afterPoint:5];
    }else if (model.tradetype.integerValue == 2){
        oneUnitStr = @"RY";
        twoUnitStr = @"元";
        oneAmountStr = [ManagerEngine retainScale:model.amount afterPoint:5];
        twoAmountStr = [ManagerEngine retainScale:twoAmountStr afterPoint:2];
    }else if (model.tradetype.integerValue == 13){
        oneUnitStr = @"元";
        twoUnitStr = @"RY";
        oneAmountStr = [ManagerEngine retainScale:model.amount afterPoint:2];
        twoAmountStr = [ManagerEngine retainScale:twoAmountStr afterPoint:5];
    }else{
        oneUnitStr = @"元";
        twoUnitStr = @"元";
        oneAmountStr = [ManagerEngine retainScale:model.amount afterPoint:2];
        twoAmountStr = [ManagerEngine retainScale:twoAmountStr afterPoint:2];
    }
    self.typeLabel.text = [NSString stringWithFormat:@"%@",model.tradeDesc];
    
    self.timerLabel.text =[ManagerEngine zzReverseSwitchTimer:model.tradetime];

    self.amountOneLabel.text = [NSString stringWithFormat:@"%@%@",oneAmountStr,oneUnitStr];
    self.amountTwoLabel.text = [NSString stringWithFormat:@"%@%@",twoAmountStr,twoUnitStr];
    if (model.tradetype.integerValue == 13){
        self.amountTwoLabel.text = [NSString stringWithFormat:@"%@%@",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",twoAmountStr.floatValue/2] afterPoint:5],twoUnitStr];
    }
    [self setView];

}



-(void)setView {
    
    CGFloat amountOneLabelWidth = [ManagerEngine setTextWidthStr:self.amountOneLabel.text andFont:[UIFont systemFontOfSize:16.0]];
    
    CGFloat typeLabelLabelWidth = [ManagerEngine setTextWidthStr:self.typeLabel.text andFont:[UIFont systemFontOfSize:10.0]];
    
    CGFloat timerLabelWidth = [ManagerEngine setTextWidthStr:self.timerLabel.text andFont:[UIFont systemFontOfSize:10.0]];
    
    CGFloat amountTwoLabelWidth = [ManagerEngine setTextWidthStr:self.amountTwoLabel.text andFont:[UIFont systemFontOfSize:16.0]];
    
    
    self.amountOneLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self,(self.mj_h - 16)/2).heightIs(16).widthIs(amountOneLabelWidth);
    
    self.typeLabel.sd_layout.leftSpaceToView(self,(self.mj_w - typeLabelLabelWidth)/2).topSpaceToView(self,kEDGE).heightIs(10).widthIs(typeLabelLabelWidth);
    
    self.arrowImageView.sd_layout.leftSpaceToView(self,(self.mj_w - 60)/2).topSpaceToView(self.typeLabel,10).heightIs(7).widthIs(60);
    
    self.timerLabel.sd_layout.leftSpaceToView(self,(self.mj_w - timerLabelWidth)/2).topSpaceToView(self.arrowImageView,10).heightIs(10).widthIs(timerLabelWidth);
    
    self.amountTwoLabel.sd_layout.leftSpaceToView(self,WIDTH - kEDGE - amountTwoLabelWidth).topEqualToView(self.amountOneLabel).heightIs(16).widthIs(amountTwoLabelWidth);
    
    
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
