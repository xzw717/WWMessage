//
//  MyTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MyTableViewCell.h"

@interface MyTableViewCell()
@property (nonatomic,strong) UILabel * todayBonusLabel;

@property (nonatomic,strong) UILabel * todayBonusLabelS;

@property (nonatomic,strong) UILabel * todayCashLabel;

@property (nonatomic,strong) UILabel * todayCashLabelS;

@property (nonatomic,strong) UILabel * allZHLabel;

@property (nonatomic,strong) UILabel * allZHLabelS;

@end

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [RACObserve(self, model)subscribeNext:^(MyModel *model) {
            
            if (model.incomeBToday) {
                self.todayBonusLabel.text = [NSString stringWithFormat:@"+%@",[ManagerEngine retainScale:model.incomeBToday afterPoint:2]];
                self.todayCashLabel.text = [NSString stringWithFormat:@"+%@",[ManagerEngine retainScale:model.incomCToday afterPoint:2]];
                self.allZHLabel.text = [NSString stringWithFormat:@"%@",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",model.zh] afterPoint:2]];
            } else {

                self.todayBonusLabel.text = @"+0.00";
                self.todayCashLabel.text = @"+0.00";
                self.allZHLabel.text = @"0.00";
                
            }
        }];
        
        
    }
    
    return self;
}

- (UILabel *)todayBonusLabel {
    if ( _todayBonusLabel == nil ) {
        _todayBonusLabel = [[UILabel alloc]init];
        _todayBonusLabel.font = [UIFont systemFontOfSize:S_RatioH(17.f)];
        _todayBonusLabel.textAlignment = NSTextAlignmentCenter;
        _todayBonusLabel.textColor = [ManagerEngine getColor:@"12b312"];
        [self addSubview:_todayBonusLabel];

    }
    return _todayBonusLabel;
}
- (UILabel *)todayCashLabel {
    if ( _todayCashLabel == nil ) {
        _todayCashLabel = [[UILabel alloc]init];
        _todayCashLabel.font = [UIFont systemFontOfSize:S_RatioH(17.f)];
        _todayCashLabel.textAlignment = NSTextAlignmentCenter;
        _todayCashLabel.textColor = [ManagerEngine getColor:@"12b312"];
        [self addSubview:_todayCashLabel];
    }
    return _todayCashLabel;
}

- (UILabel *)allZHLabel {
    if ( _allZHLabel == nil ) {
        _allZHLabel = [[UILabel alloc]init];
        _allZHLabel.font = [UIFont systemFontOfSize:S_RatioH(17.f)];
        _allZHLabel.textAlignment = NSTextAlignmentCenter;
        _allZHLabel.textColor = [ManagerEngine getColor:@"18abf5"];
        [self addSubview:_allZHLabel];
    }
    return _allZHLabel;
}

- (UILabel *)todayBonusLabelS {
    if ( _todayBonusLabelS == nil ) {
        _todayBonusLabelS = [[UILabel alloc]init];
        _todayBonusLabelS.font = [UIFont systemFontOfSize:S_RatioH(15.f)];
        _todayBonusLabelS.text = @"当日积分收入";
        _todayBonusLabelS.textAlignment = NSTextAlignmentCenter;
        _todayBonusLabelS.textColor = [ManagerEngine getColor:@"323232"];
        [self addSubview:_todayBonusLabelS];
    }
    return _todayBonusLabelS;
}

- (UILabel *)todayCashLabelS {
    if ( _todayCashLabelS == nil ) {
        _todayCashLabelS = [[UILabel alloc]init];
        _todayCashLabelS.font = [UIFont systemFontOfSize:S_RatioH(15.f)];
        _todayCashLabelS.textAlignment = NSTextAlignmentCenter;
        _todayCashLabelS.text = @"当日现金收入";
        _todayCashLabelS.textColor = [ManagerEngine getColor:@"323232"];
        [self addSubview:_todayCashLabelS];
    }
    return _todayCashLabelS;
}

- (UILabel *)allZHLabelS {
    if ( _allZHLabelS == nil ) {
        _allZHLabelS = [[UILabel alloc]init];
        _allZHLabelS.font = [UIFont systemFontOfSize:S_RatioH(15.f)];
        _allZHLabelS.textAlignment = NSTextAlignmentCenter;
        _allZHLabelS.text = @"RY值余额";
        _allZHLabelS.textColor = [ManagerEngine getColor:@"323232"];
        [self addSubview:_allZHLabelS];
        
    }
    return _allZHLabelS;
}

-(void)layoutSubviews {
    [self setViewFrame];
    [super layoutSubviews];
}

- (void)setViewFrame {
    
//    [self.todayCashLabel sd_resetLayout];
//    [self.todayCashLabelS sd_resetLayout];
//    [self.todayBonusLabel sd_resetLayout];
//    [self.todayBonusLabelS sd_resetLayout];
    
    CGFloat todayBonusSWidth = [ManagerEngine setTextWidthStr:self.todayBonusLabelS.text andFont:[UIFont systemFontOfSize:S_RatioH(15.f)]];

    CGFloat todayCashSWidth = [ManagerEngine setTextWidthStr:self.todayCashLabelS.text andFont:[UIFont systemFontOfSize:S_RatioH(15.f)]];
    
    CGFloat ZHSWidth = [ManagerEngine setTextWidthStr:self.allZHLabelS.text andFont:[UIFont systemFontOfSize:S_RatioH(15.f)]];
    
    CGFloat SpacerWidth  = (WIDTH - 15 * 2 - ZHSWidth - todayBonusSWidth - todayCashSWidth) / 2;

   
    
    
    self.todayBonusLabel.sd_layout.
    leftSpaceToView(self,0).
    topSpaceToView(self,16).
    heightIs(18).
    widthIs(WIDTH / 3);
    
    
    self.todayBonusLabelS.sd_layout.
    leftEqualToView(self.todayBonusLabel).
    topSpaceToView(self.todayBonusLabel,10).
    heightIs(15).
    widthIs(WIDTH / 3);
    
    self.todayCashLabel.sd_layout.
    leftSpaceToView(self.todayBonusLabel,0).
    topEqualToView(self.todayBonusLabel).
    heightIs(18).
    widthIs(WIDTH / 3);
    
    self.todayCashLabelS.sd_layout.
    leftSpaceToView(self.todayBonusLabelS,0).
    topEqualToView(self.todayBonusLabelS).
    heightIs(15).
    widthIs(WIDTH / 3);
    
    self.allZHLabel.sd_layout.
    leftSpaceToView(self.todayCashLabel,0).
    topEqualToView(self.todayBonusLabel).
    widthIs(WIDTH / 3);
    
    self.allZHLabelS.sd_layout.
    leftEqualToView(self.allZHLabel).
    topEqualToView(self.todayBonusLabelS).
    heightIs(15).
    widthIs(WIDTH / 3);
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
