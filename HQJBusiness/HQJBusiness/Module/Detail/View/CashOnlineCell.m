//
//  CashOnlineCell.m
//  HQJBusiness
//
//  Created by mymac on 2017/9/11.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "CashOnlineCell.h"
@interface CashOnlineCell ()
@property (nonatomic, strong) ZW_ChangeFigureColorLabel *nameLabel;
@property (nonatomic, strong) ZW_Label *tradetypeLabel;
@property (nonatomic, strong) ZW_Label *timeLabel;
@property (nonatomic, strong) ZW_Label *amountLabel;
@property (nonatomic, strong) ZW_Label *amountDetailsLabel;
@property (nonatomic,strong)ZW_Label *couponLabel;

@end
@implementation CashOnlineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setModel];
        [self updateConstraintsIfNeeded];
    }
    return self;
}


- (void)setModel {
    [RACObserve(self, cashModel)subscribeNext:^(DetailModel *model) {
        NSString *mobile = [model.tmobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.nameLabel.needChangeStr =[NSString stringWithFormat:@"(%@)",mobile];
        self.nameLabel.zw_color = [ManagerEngine getColor:@"999999"];
        self.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",model.trealname,mobile];

        if ([model.tradeDesc isEqualToString:@"现金消费"]) {
            self.tradetypeLabel.hidden = YES;
        } else {
            self.tradetypeLabel.hidden = NO;
        }
//        fabs(model.cash.floatValue)//fabs(model.zh.floatValue)
        self.amountDetailsLabel.hidden = self.isManualGift;
        if(self.isManualGift) {
            self.amountLabel.text = [NSString stringWithFormat:@"-%@%@值",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",fabs(model.zh.doubleValue)] afterPoint:5],HQJValue];
        } else {
            self.amountLabel.text = [NSString stringWithFormat:@"+%@元",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",fabs(model.cash.doubleValue)] afterPoint:2]];
            self.amountDetailsLabel.text = [NSString stringWithFormat:@"(%@值:-%@)",HQJValue,[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",fabs(model.zh.doubleValue)] afterPoint:5]];
        }
 
        self.couponLabel.text = [NSString stringWithFormat:@"%@:-¥%@",model.couponType,model.reduction];
        self.timeLabel.text = [ManagerEngine zzReverseSwitchTimer:model.tradetime];
        self.tradetypeLabel.text = [NSString stringWithFormat:@"支付方式：%@",model.tradeDesc];
        [self setlayoutOnline:[model.tradeDesc isEqualToString:@"现金消费"] ? NO : YES];
      
           self.couponLabel.hidden = ![self isCoupon:model];
    }];
}
/// 判断是否是优惠券订单
- (BOOL)isCoupon:(DetailModel *)model {
    if (model.couponType && ![model.couponType isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}
//- (CGFloat)cellHeightWithModel:(DetailModel *)model {
//    return [self isCoupon:model] ? 90 + 11 + 12.f : 90.f;
//}


- (void)setlayoutOnline:(BOOL)isOnline {
    
    CGFloat nameWidth = [ManagerEngine setTextWidthStr:self.nameLabel.text andFont:[UIFont systemFontOfSize:17.f]];
    
    if(nameWidth > WIDTH /2){
        self.nameLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self,17).heightIs(17).widthIs(WIDTH / 2);
        
    } else {
        self.nameLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self,17).heightIs(17).widthIs(nameWidth);
        
    }
    CGFloat timerWidth = [ManagerEngine setTextWidthStr:self.timeLabel.text andFont:[UIFont systemFontOfSize:12.0]];

    if (isOnline) {
        CGFloat tradetypeWidth = [ManagerEngine setTextWidthStr:self.tradetypeLabel.text andFont:[UIFont systemFontOfSize:12.0]];
        self.tradetypeLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self.nameLabel,11).heightIs(12).widthIs(tradetypeWidth);

        self.timeLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self.tradetypeLabel,11).heightIs(12).widthIs(timerWidth);
    } else {
    
        self.timeLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self.nameLabel,11).heightIs(12).widthIs(timerWidth);
    }

    
    CGFloat amountWidth = [ManagerEngine setTextWidthStr:self.amountLabel.text andFont:[UIFont systemFontOfSize:17.f]];
    self.amountLabel.sd_layout.leftSpaceToView(self,WIDTH - kEDGE - amountWidth).topEqualToView(self.nameLabel).heightIs(17).widthIs(amountWidth);
    //
    CGFloat amountDetailsWidth = [ManagerEngine setTextWidthStr:self.amountDetailsLabel.text andFont:[UIFont systemFontOfSize:12.0]];
    self.amountDetailsLabel.sd_layout.leftSpaceToView(self,WIDTH - kEDGE - amountDetailsWidth).topSpaceToView(self.amountLabel,11).heightIs(12).widthIs(amountDetailsWidth);
    self.couponLabel.sd_layout.
             rightEqualToView(self.amountDetailsLabel).
             topSpaceToView(self.amountDetailsLabel,11).
             heightIs(12).
             widthIs(WIDTH - 30);
    
}


- (ZW_ChangeFigureColorLabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[ZW_ChangeFigureColorLabel alloc]initWithStr:@"" addSubView:self];
        _nameLabel.font = [UIFont systemFontOfSize:17.0];

    }
    return _nameLabel;
}
-(ZW_Label *)timeLabel {
    if ( _timeLabel == nil ) {
        _timeLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        _timeLabel.textColor = [ManagerEngine getColor:@"999999"];
    }
    return _timeLabel;
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

- (ZW_Label *)tradetypeLabel {
    if ( _tradetypeLabel == nil ) {
        _tradetypeLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _tradetypeLabel.font = [UIFont systemFontOfSize:12.0];
        _tradetypeLabel.textColor = [ManagerEngine getColor:@"999999"];
    }
    return _tradetypeLabel;
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

@end
