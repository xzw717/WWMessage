//
//  MyTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MyTableViewCell.h"
#import "RewardsRecordViewController.h"
@interface MyTableViewCell()



@property (nonatomic,strong) UILabel * todayBonusLabel;

@property (nonatomic,strong) UILabel * todayBonusLabelS;

@property (nonatomic,strong) UILabel * todayCashLabel;

@property (nonatomic,strong) UILabel * todayCashLabelS;

@property (nonatomic,strong) UILabel * allZHLabel;

@property (nonatomic,strong) UILabel * allZHLabelS;

@property (nonatomic, strong) UILabel * moreLabel;

@property (nonatomic, strong) UIView * linkView;

@end

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [RACObserve(self, model)subscribeNext:^(MyModel *model) {
            if ([NameSingle shareInstance].peugeotid == 6) {
//                [self.rewardIncomeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.width.mas_equalTo(WIDTH / 4);
//                }];
            } else {
//                [self.rewardIncomeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.width.mas_equalTo(0);
//                }];
            }
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
- (void)setCellReward:(NSString *)cellReward {
    _cellReward = cellReward;
//    self.rewardIncomeLabel.text = cellReward ? [ManagerEngine retainScale:cellReward afterPoint:2] : @"0.00";
//    [self.rewardIncomeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(WIDTH / 4);
//    }];
}

- (void)clickReward {
    RewardsRecordViewController *rewardsRecordVC = [[RewardsRecordViewController alloc]init];
    [[ManagerEngine currentViewControll].navigationController pushViewController:rewardsRecordVC animated:YES];
}

- (UILabel *)todayBonusLabel {
    if ( _todayBonusLabel == nil ) {
        _todayBonusLabel = [[UILabel alloc]init];
        _todayBonusLabel.font = [UIFont systemFontOfSize:17.f];
        _todayBonusLabel.textAlignment = NSTextAlignmentCenter;
        _todayBonusLabel.textColor = [ManagerEngine getColor:@"12b312"];
        [self.contentView addSubview:_todayBonusLabel];
        
    }
    return _todayBonusLabel;
}
- (UILabel *)todayCashLabel {
    if ( _todayCashLabel == nil ) {
        _todayCashLabel = [[UILabel alloc]init];
        _todayCashLabel.font = [UIFont systemFontOfSize:17.f];
        _todayCashLabel.textAlignment = NSTextAlignmentCenter;
        _todayCashLabel.textColor = [ManagerEngine getColor:@"12b312"];
        [self.contentView addSubview:_todayCashLabel];
    }
    return _todayCashLabel;
}

- (UILabel *)allZHLabel {
    if ( _allZHLabel == nil ) {
        _allZHLabel = [[UILabel alloc]init];
        _allZHLabel.font = [UIFont systemFontOfSize:17.f];
        _allZHLabel.textAlignment = NSTextAlignmentCenter;
        _allZHLabel.textColor = [ManagerEngine getColor:@"18abf5"];
        [self.contentView addSubview:_allZHLabel];
    }
    return _allZHLabel;
}

- (UILabel *)todayBonusLabelS {
    if ( _todayBonusLabelS == nil ) {
        _todayBonusLabelS = [[UILabel alloc]init];
        _todayBonusLabelS.font = [UIFont systemFontOfSize:15.f];
        _todayBonusLabelS.text = @"当日积分收入";
        _todayBonusLabelS.textAlignment = NSTextAlignmentCenter;
        _todayBonusLabelS.textColor = [ManagerEngine getColor:@"323232"];
        [self.contentView addSubview:_todayBonusLabelS];
    }
    return _todayBonusLabelS;
}

- (UILabel *)todayCashLabelS {
    if ( _todayCashLabelS == nil ) {
        _todayCashLabelS = [[UILabel alloc]init];
        _todayCashLabelS.font = [UIFont systemFontOfSize:15.f];
        _todayCashLabelS.textAlignment = NSTextAlignmentCenter;
        _todayCashLabelS.text = @"当日现金收入";
        _todayCashLabelS.textColor = [ManagerEngine getColor:@"323232"];
        [self.contentView addSubview:_todayCashLabelS];
    }
    return _todayCashLabelS;
}

- (UILabel *)allZHLabelS {
    if ( _allZHLabelS == nil ) {
        _allZHLabelS = [[UILabel alloc]init];
        _allZHLabelS.font = [UIFont systemFontOfSize:15.f];
        _allZHLabelS.textAlignment = NSTextAlignmentCenter;
        _allZHLabelS.text = [NSString stringWithFormat:@"%@值余额",HQJValue];
        _allZHLabelS.textColor = [ManagerEngine getColor:@"323232"];
        [self.contentView addSubview:_allZHLabelS];
        
    }
    return _allZHLabelS;
}
- (UILabel *)moreLabel {
    if ( _moreLabel == nil ) {
        _moreLabel = [[UILabel alloc]init];
        _moreLabel.font = [UIFont systemFontOfSize:16.f];
        _moreLabel.textAlignment = NSTextAlignmentCenter;
        _moreLabel.text = @"更多";
        _moreLabel.textColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickReward)];
        [self.contentView addSubview:_moreLabel];
    }
    return _moreLabel;
}

- (UIView *)linkView {
    if (!_linkView){
        _linkView = [[UIView alloc]init];
        _linkView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
        [self.contentView addSubview:_linkView];
    }
    return _linkView;;
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
    
    //    CGFloat todayBonusSWidth = [ManagerEngine setTextWidthStr:self.todayBonusLabelS.text andFont:[UIFont systemFontOfSize:S_RatioH(15.f)]];
    //
    //    CGFloat todayCashSWidth = [ManagerEngine setTextWidthStr:self.todayCashLabelS.text andFont:[UIFont systemFontOfSize:S_RatioH(15.f)]];
    //
    //    CGFloat ZHSWidth = [ManagerEngine setTextWidthStr:self.allZHLabelS.text andFont:[UIFont systemFontOfSize:S_RatioH(15.f)]];
    //
    //    CGFloat SpacerWidth  = (WIDTH - 15 * 2 - ZHSWidth - todayBonusSWidth - todayCashSWidth) / 2;
    CGFloat oneLabelWith = [NameSingle shareInstance].peugeotid == 6 ? WIDTH / 4 : 0;
    //    CGFloat labelWith = [NameSingle shareInstance].peugeotid == 6 ? WIDTH / 4 : WIDTH /3;
    
    self.moreLabel.hidden = self.linkView.hidden =  [NameSingle shareInstance].peugeotid == 6 ? NO : YES;
    //    [self.rewardIncomeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(0);
    //        make.top.mas_equalTo(16);
    //        make.width.mas_equalTo(oneLabelWith);
    //    }];
    //    [self.rewardIncomeLabelS mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(self.rewardIncomeLabel.mas_bottom).mas_offset(10);
    //        make.left.right.mas_equalTo(self.rewardIncomeLabel);
    //    }];
    [self.todayBonusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(16);
        make.width.mas_equalTo(oneLabelWith);
        
    }];
    
    [self.todayBonusLabelS mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.todayBonusLabel.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(self.todayBonusLabel);
    }];
    [self.todayCashLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.todayBonusLabel.mas_right);
        make.width.top.mas_equalTo(self.todayBonusLabel);
    }];
    [self.todayCashLabelS mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.todayCashLabel.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(self.todayCashLabel);
    }];
    [self.allZHLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.todayCashLabel.mas_right);
        make.width.top.mas_equalTo(self.todayCashLabel);
    }];
    [self.allZHLabelS mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.allZHLabel.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(self.allZHLabel);
    }];
    
    [self.moreLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
          make.centerY.mas_equalTo(self.contentView);
          make.width.mas_equalTo(self.allZHLabel);
        make.right.mas_equalTo(0);
    }];
    [self.linkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.moreLabel.mas_left);
        make.centerY.mas_equalTo(self.contentView);
        make.top.mas_equalTo(16);
        make.bottom.mas_equalTo(-16);
        make.width.mas_equalTo(.5f);
    }];
    //    if ([NameSingle shareInstance].peugeotid == 6) {
    //        self.rewardIncomeLabel.hidden = NO;
    //        self.rewardIncomeLabel.hidden = NO;
    //
    //        self.rewardIncomeLabel.sd_layout.
    //        leftSpaceToView(self,0).
    //        topSpaceToView(self,16).
    //        heightIs(18).
    //        widthIs(labelWith);
    //
    //
    //        self.rewardIncomeLabelS.sd_layout.
    //        leftEqualToView(self.rewardIncomeLabel).
    //        topSpaceToView(self.rewardIncomeLabel,10).
    //        heightIs(15).
    //        widthIs(labelWith);
    //
    //
    //
    //        self.todayBonusLabel.sd_layout.
    //           leftSpaceToView(self.rewardIncomeLabel,0).
    //           topSpaceToView(self,16).
    //           heightIs(18).
    //           widthIs(labelWith);
    //    } else {
    //        self.rewardIncomeLabel.hidden = YES;
    //        self.rewardIncomeLabel.hidden = YES;
    //
    //      self.todayBonusLabel.sd_layout.
    //           leftSpaceToView(self,0).
    //           topSpaceToView(self,16).
    //           heightIs(18).
    //           widthIs(labelWith);
    //    }
    //
    //
    //    self.todayBonusLabelS.sd_layout.
    //    leftEqualToView(self.todayBonusLabel).
    //    topSpaceToView(self.todayBonusLabel,10).
    //    heightIs(15).
    //    widthIs(labelWith);
    //
    //
    //
    //    self.todayCashLabel.sd_layout.
    //    leftSpaceToView(self.todayBonusLabel,0).
    //    topEqualToView(self.todayBonusLabel).
    //    heightIs(18).
    //    widthIs(labelWith);
    //
    //    self.todayCashLabelS.sd_layout.
    //    leftSpaceToView(self.todayBonusLabelS,0).
    //    topEqualToView(self.todayBonusLabelS).
    //    heightIs(15).
    //    widthIs(labelWith);
    //
    //    self.allZHLabel.sd_layout.
    //    leftSpaceToView(self.todayCashLabel,0).
    //    topEqualToView(self.todayBonusLabel).
    //    widthIs(labelWith);
    //
    //    self.allZHLabelS.sd_layout.
    //    leftEqualToView(self.allZHLabel).
    //    topEqualToView(self.todayBonusLabelS).
    //    heightIs(15).
    //    widthIs(labelWith);
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
