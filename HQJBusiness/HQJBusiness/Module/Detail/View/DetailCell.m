//
//  DetailCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "DetailCell.h"
@interface DetailCell ()
@property (nonatomic,strong)ZW_ChangeFigureColorLabel *nameLabel;
@property (nonatomic,strong)ZW_Label *timerLabel;
@property (nonatomic,strong)ZW_Label *amountLabel;
@property (nonatomic,strong)ZW_Label *amountDetailsLabel;
@end
@implementation DetailCell

-(ZW_ChangeFigureColorLabel *)nameLabel {
    if ( _nameLabel == nil ) {
        _nameLabel = [[ZW_ChangeFigureColorLabel alloc]initWithStr:@"" addSubView:self];
        _nameLabel.font = [UIFont systemFontOfSize:17.0];
    }
    
    return _nameLabel;
}

-(ZW_Label *)timerLabel {
    if ( _timerLabel == nil ) {
        _timerLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _timerLabel.font = [UIFont systemFontOfSize:12.0];
        _timerLabel.textColor = [ManagerEngine getColor:@"999999"];
    }
    return _timerLabel;
}

-(ZW_Label *)amountLabel {
    if ( _amountLabel == nil ) {
        _amountLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _amountLabel.textColor = [ManagerEngine getColor:@"18abf5"];
        _amountLabel.font = [UIFont systemFontOfSize:17.0];

    }
    
    return _amountLabel;
}
-(ZW_Label *)amountDetailsLabel {
    if ( _amountDetailsLabel == nil ) {
        _amountDetailsLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _amountDetailsLabel.font = [UIFont systemFontOfSize:12.0];
        _amountDetailsLabel.textColor = [ManagerEngine getColor:@"999999"];
    }
    
    return _amountDetailsLabel;
}


-(void)setModel:(DetailModel *)model andPaging:(NSInteger)page {
    if (page <= 1) {
        NSString *mobile = [model.tmobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.nameLabel.needChangeStr =[NSString stringWithFormat:@"(%@)",mobile];
        self.nameLabel.zw_color = [ManagerEngine getColor:@"999999"];
        self.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",model.trealname,mobile];
    } else {
        self.nameLabel.text = [NameSingle shareInstance].subCompanyName?[NameSingle shareInstance].subCompanyName:model.trealname;

    }
    self.timerLabel.text = [ManagerEngine zzReverseSwitchTimer:model.tradetime];
    if (page == 1 || page == 3 || page == 5 ) {
        //old amount
        self.amountLabel.text = [NSString stringWithFormat:@"-%@元",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",fabs(model.cash.doubleValue)] afterPoint:2]];
//        if(page == 5){
//            self.amountLabel.text = [NSString stringWithFormat:@"%ld元",model.score.integerValue * 2];
//        }
    } else {
        NSString *symbol;
        if (page == 0) {
            symbol = @"+";
        }else{
            symbol = @"-";
        }
        self.amountLabel.text = [NSString stringWithFormat:@"%@%@",symbol,[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",fabs(model.score.doubleValue)] afterPoint:5]];

    }
    if (page != 3) {
        if (page == 2) {
            //old camount
            self.amountDetailsLabel.text = [NSString stringWithFormat:@"(+%@元)",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",fabs(model.cash.doubleValue)] afterPoint:2]];

        } else {
            NSString *symbol;
            if (page == 0) {
                symbol = @"-";
            }else{
                symbol = @"+";
            }
//            NSLog(@"%@===%@===%@",[NSString stringWithFormat:@"%f",fabs(model.zh.doubleValue)],model.zh,[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",fabs(model.zh.doubleValue)] afterPoint:5]);
            
            self.amountDetailsLabel.text = [NSString stringWithFormat:@"(RY:%@%@)",symbol,[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",fabs(model.zh.doubleValue)] afterPoint:5]];
        }
    }
    
    
    CGFloat nameWidth = [ManagerEngine setTextWidthStr:self.nameLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    
    if(nameWidth > WIDTH /2){
        self.nameLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self,17).heightIs(17).widthIs(WIDTH / 2);

    } else {
        self.nameLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self,17).heightIs(17).widthIs(nameWidth);

    }
    
    
    CGFloat timerWidth = [ManagerEngine setTextWidthStr:self.timerLabel.text andFont:[UIFont systemFontOfSize:12.0]];
    self.timerLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self.nameLabel,11).heightIs(12).widthIs(timerWidth);
    
    CGFloat amountWidth = [ManagerEngine setTextWidthStr:self.amountLabel.text andFont:[UIFont systemFontOfSize:17.f]];
    self.amountLabel.sd_layout.leftSpaceToView(self,WIDTH - kEDGE - amountWidth).topEqualToView(self.nameLabel).heightIs(17).widthIs(amountWidth);
//
    CGFloat amountDetailsWidth = [ManagerEngine setTextWidthStr:self.amountDetailsLabel.text andFont:[UIFont systemFontOfSize:12.0]];
    self.amountDetailsLabel.sd_layout.leftSpaceToView(self,WIDTH - kEDGE - amountDetailsWidth).topSpaceToView(self.amountLabel,11).heightIs(12).widthIs(amountDetailsWidth);
    
    
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
