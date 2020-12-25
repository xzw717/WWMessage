//
//  DetailCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "DetailCell.h"
#import "BookScoreViewController.h"
@interface DetailCell ()
@property (nonatomic,strong)ZW_ChangeFigureColorLabel *nameLabel;
@property (nonatomic,strong)ZW_Label *timerLabel;
@property (nonatomic,strong)ZW_Label *amountLabel;
@property (nonatomic,strong)ZW_Label *amountDetailsLabel;
@property (nonatomic,strong)ZW_Label *couponLabel;
@property (nonatomic,strong)ZW_Label *actualLabel;
@property (nonatomic,strong)ZW_Label *activityScoreLabel;

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
        _amountLabel.font = [UIFont systemFontOfSize:15.0];
        
    }
    
    return _amountLabel;
}
-(ZW_Label *)activityScoreLabel {
    if ( _activityScoreLabel == nil ) {
        _activityScoreLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _activityScoreLabel.textColor = [ManagerEngine getColor:@"18abf5"];
        _activityScoreLabel.font = [UIFont systemFontOfSize:12.0];
        _activityScoreLabel.textAlignment = NSTextAlignmentRight;
        _activityScoreLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goactivityScore)];
        
        [_activityScoreLabel addGestureRecognizer:tap];
    }
    
    return _activityScoreLabel;
}
-(ZW_Label *)amountDetailsLabel {
    if ( _amountDetailsLabel == nil ) {
        _amountDetailsLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _amountDetailsLabel.font = [UIFont systemFontOfSize:12.0];
        _amountDetailsLabel.textColor = [ManagerEngine getColor:@"999999"];
    }
    
    return _amountDetailsLabel;
}

-(ZW_Label *)couponLabel {
    if ( _couponLabel == nil ) {
        _couponLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _couponLabel.font = [UIFont systemFontOfSize:12.0];
        _couponLabel.textColor = [ManagerEngine getColor:@"ff4949"];
        _couponLabel.textAlignment = NSTextAlignmentRight;
    }
    return _couponLabel;
}
-(ZW_Label *)actualLabel {
    if ( _actualLabel == nil ) {
        _actualLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _actualLabel.font = [UIFont systemFontOfSize:12.0];
        _actualLabel.textColor = [ManagerEngine getColor:@"999999"];
        _actualLabel.textAlignment = NSTextAlignmentRight;
    }
    return _actualLabel;
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
    if (page == 1 || page == 5 ) {
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
            self.amountDetailsLabel.text = [NSString stringWithFormat:@"(+%@元)",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",fabs(model.amount.doubleValue / 2)] afterPoint:2]];
            
        } else {
            NSString *symbol;
            if (page == 0) {
                symbol = @"-";
            }else{
                symbol = @"+";
            }
            //            NSLog(@"%@===%@===%@",[NSString stringWithFormat:@"%f",fabs(model.zh.doubleValue)],model.zh,[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",fabs(model.zh.doubleValue)] afterPoint:5]);
            
            self.amountDetailsLabel.text = [NSString stringWithFormat:@"(%@值:%@%@)",HQJValue,symbol,[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",fabs(model.zh.doubleValue)] afterPoint:5]];
        }
    }
    if (page == 2 || page == 3) {
        self.actualLabel.hidden = NO;
        if (model.camount && model.camount.doubleValue > 0.f) {
            self.actualLabel.text = [NSString stringWithFormat:@"实际到账：%@元",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",fabs(model.camount.doubleValue)] afterPoint:2]];
        }
        self.amountLabel.text = [NSString stringWithFormat:@"-%@元",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",fabs(model.amount.doubleValue)] afterPoint:2]];
        
    } else {
        self.actualLabel.hidden = YES;
    }
    self.couponLabel.text = [NSString stringWithFormat:@"%@:-¥%@",model.couponType,model.reduction];
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
    CGFloat amountDetailsWidth = [ManagerEngine setTextWidthStr:self.amountDetailsLabel.text andFont:[UIFont systemFontOfSize:12.0]];
    if (page == 0 && [self isActivityScore:model]) {
        self.activityScoreLabel.hidden = NO;
        self.activityScoreLabel.text = [NSString stringWithFormat:@"其中预约积分%@",model.activityScore];
        self.activityScoreLabel.sd_layout.rightEqualToView(self.amountLabel).topSpaceToView(self.amountLabel,1).heightIs(20).widthIs(200);
        
        
        
        self.amountDetailsLabel.sd_layout.leftSpaceToView(self,WIDTH - kEDGE - amountDetailsWidth).topSpaceToView(self.activityScoreLabel,11).heightIs(12).widthIs(amountDetailsWidth);
        
        
        
    }else{
        self.activityScoreLabel.hidden = YES;
        
        self.amountDetailsLabel.sd_layout.leftSpaceToView(self,WIDTH - kEDGE - amountDetailsWidth).topSpaceToView(self.amountLabel,11).heightIs(12).widthIs(amountDetailsWidth);
        
    }
    CGFloat actualWidth = [ManagerEngine setTextWidthStr:self.actualLabel.text andFont:[UIFont systemFontOfSize:12.f]];
    self.actualLabel.sd_layout.rightEqualToView(self.amountDetailsLabel).topSpaceToView([self.amountDetailsLabel.text isEqualToString:@""] ? self.amountLabel : self.amountDetailsLabel, 11).heightIs(12).widthIs(actualWidth);
    
    
    self.couponLabel.sd_layout.
    rightEqualToView(self.amountDetailsLabel).
    topSpaceToView(self.amountDetailsLabel,11).
    heightIs(12).
    widthIs(WIDTH - 30);
    self.couponLabel.hidden = ![self isCoupon:model];
    
    
}
/// 判断是否是优惠券订单
- (BOOL)isCoupon:(DetailModel *)model {
    if (model.couponType && ![model.couponType isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}
/// 判断含有预约积分
- (BOOL)isActivityScore:(DetailModel *)model {
    if (model.activityScore.integerValue > 0) {
        return YES;
    } else {
        return NO;
    }
}
- (CGFloat)cellHeightWithModel:(DetailModel *)model {
    return [self isCoupon:model] ? 70 + 11 + 12.f + ([self isActivityScore:model] ? 21 : 0) : 70.f + ([self isActivityScore:model] ? 21 : 0);
}
- (void)goactivityScore{
    BookScoreViewController *vc = [[BookScoreViewController alloc]init];
    [[ManagerEngine currentViewControll].navigationController pushViewController:vc animated:YES];
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
