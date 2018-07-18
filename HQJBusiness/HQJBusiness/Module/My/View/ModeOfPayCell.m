//
//  ModeOfPayCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/15.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ModeOfPayCell.h"

@implementation ModeOfPayCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    
    }
    
    return self;
}

-(void)setIsArrearage:(BOOL)isArrearage {
//    @"微信支付",@"icon_wechat_pay_normal", @"银联支付",@"union_pay",  测试 刘海燕说：让微信和银联不可选

    if (isArrearage) {
        self.titleLabelArray = @[@[@"支付宝支付",
                                   @"积分支付(余额不足)"]];
        self.titleImageViewArray = @[@[@"icon_alipay_normal",
                                       @"icon_integration_normal"]];
    } else {
        
//         @"微信支付",@"icon_wechat_pay_normal",@"银联支付" @"union_pay"
        self.titleLabelArray = @[@[@"积分支付",
                                  @"支付宝支付"]];
        self.titleImageViewArray = @[@[@"icon_integration_normal",
                                       @"icon_alipay_normal"]];
    }
 
    
    
}
-(void)setCellIndexPath:(NSIndexPath *)cellIndexPath {
    
    
    self.titleImageView.image = [UIImage imageNamed:self.titleImageViewArray[cellIndexPath.section][cellIndexPath.row]];
    self.titleLabel.text = self.titleLabelArray[cellIndexPath.section][cellIndexPath.row];
    
    self.titleLabel.font = [UIFont systemFontOfSize:15.0];
    
    CGFloat labelWidth = [ManagerEngine setTextWidthStr:self.titleLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.titleImageView.sd_layout.leftSpaceToView(self,15).topSpaceToView(self,(self.frame.size.height - 24)/2).heightIs(24).widthIs(24);
    self.titleLabel.sd_layout.leftSpaceToView(self.titleImageView,10).topSpaceToView(self,(self.frame.size.height - 17)/2).heightIs(17).widthIs(labelWidth);
    
    
    if ([self.titleLabel.text isEqualToString:@"积分支付(余额不足)"]) {
        
        self.titleLabel.textColor = [ManagerEngine getColor:@"999999"];
        
        self.userInteractionEnabled = NO;
    }
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
