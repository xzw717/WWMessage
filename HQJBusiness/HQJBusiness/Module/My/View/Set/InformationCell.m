//
//  InformationCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/22.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "InformationCell.h"

@interface InformationCell ()
@property (nonatomic,strong)ZW_Label *titleLabel;
@property (nonatomic,strong)ZW_Label *dateilLabel;
@end
@implementation InformationCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleArray = @[@"商家名称：",
                        @"手机：",
                        @"地址：",
                        @"积分：",
                        @"现金：",
                        @"RY值：",
                        @"营业执照："];
        
        
    }
    
    return self;
}
-(ZW_Label *)titleLabel {
    if ( _titleLabel == nil ) {
        _titleLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
    }
    return _titleLabel;
}
-(ZW_Label *)dateilLabel {
    if ( _dateilLabel == nil ) {
        _dateilLabel = [[ZW_Label alloc]initWithStr:@"" addSubView:self];
        _dateilLabel.textColor = [ManagerEngine getColor:@"999999"];
    }
    
    return _dateilLabel;
}

-(void)setView {
    
    CGFloat titleWidth = [ManagerEngine setTextWidthStr:self.titleLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    CGFloat dateilWidth = [ManagerEngine setTextWidthStr:self.dateilLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    
    self.titleLabel.sd_layout.leftSpaceToView(self,kEDGE).topSpaceToView(self,(self.mj_h - 17) / 2).heightIs(17).widthIs(titleWidth);
    if (WIDTH - kEDGE * 3 - titleWidth - dateilWidth >0) {
        self.dateilLabel.sd_layout.leftSpaceToView(self.titleLabel,0).topEqualToView(self.titleLabel).heightIs(17).widthIs(dateilWidth);

    } else {
        
        self.dateilLabel.sd_layout.leftSpaceToView(self.titleLabel,0).topEqualToView(self.titleLabel).heightIs(17).widthIs(WIDTH - kEDGE * 3 - titleWidth);

    }
    

    
    
}


-(void)setModel:(informationModel *)model andindexPath:(NSIndexPath *)indexPath {
   
    self.titleLabel.text = self.titleArray[indexPath.row];
   
    switch (indexPath.row) {
        case 0:
            self.dateilLabel.text = model.realname;
            break;
        case 1:
            
                HQJLog(@"---model.mobile：%@", model.mobile);

            self.dateilLabel.text = model.mobile ? [model.mobile  stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"] :@"";

            break;
        case 2:
            self.dateilLabel.text = model.address;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            break;
        case 3:
            self.dateilLabel.text = model.bonus;

            break;
        case 4:
            self.dateilLabel.text = model.cash;

            break;
        case 5:
            self.dateilLabel.text = model.zh;

            break;
        case 6:
              HQJLog(@"---model.license：%@", model.license);
            if (model.license && model.license != nil && model.license.length > 13) {
                self.dateilLabel.text  = [model.license stringByReplacingCharactersInRange:NSMakeRange(4, 11) withString:@"********"];

            } else {
                self.dateilLabel.text  = @"";
            }
            break;
        default:
            break;
    }
    
    [self setView];
    
    
}


@end
