//
//  StoreMainCollectionViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/8/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreMainCollectionViewCell.h"
#import "StoreModel.h"
#import "MyModel.h"
@interface StoreMainCollectionViewCell ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation StoreMainCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self addSubview:self.earnPointsImageView];
        //        [self addSubview:self.titleLabel];
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(NewProportion(65));
            make.centerX.mas_equalTo(self.contentView);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(NewProportion(50));
            make.bottom.mas_equalTo(-NewProportion(65));

            make.centerX.mas_equalTo(self.contentView);
            
        }];
        
//        [RACObserve(self, model)subscribeNext:^(MyModel *model) {
//
//            if (model.incomeBToday) {
//                self.todayBonusLabel.text = [NSString stringWithFormat:@"+%@",[ManagerEngine retainScale:model.incomeBToday afterPoint:2]];
//                self.todayCashLabel.text = [NSString stringWithFormat:@"+%@",[ManagerEngine retainScale:model.incomCToday afterPoint:2]];
//                self.allZHLabel.text = [NSString stringWithFormat:@"%@",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",model.zh] afterPoint:2]];
//            } else {
//
//                self.todayBonusLabel.text = @"+0.00";
//                self.todayCashLabel.text = @"+0.00";
//                self.allZHLabel.text = @"0.00";
//
//            }
//        }];
//
    }
    return self;
}
- (void)setStoreTitleStr:(NSString *)storeTitleStr {
    _storeTitleStr = storeTitleStr;
    self.titleLabel.text = storeTitleStr;
}
- (void)setMmodel:(MyModel *)mmodel {
     if (mmodel.incomeBToday) {
         if ([self.storeTitleStr isEqualToString:@"今日积分"]) {
             self.contentLabel.text =  [NSString stringWithFormat:@"%@",[ManagerEngine retainScale:mmodel.incomeBToday afterPoint:2]];
         } else if ([self.storeTitleStr isEqualToString:@"今日现金"]) {
             self.contentLabel.text = [NSString stringWithFormat:@"+%@",[ManagerEngine retainScale:mmodel.incomCToday afterPoint:2]];
         } else if ([self.storeTitleStr isEqualToString:@"今日RY值支出"]) {
             self.contentLabel.text =  [NSString stringWithFormat:@"%@",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",mmodel.zh] afterPoint:2]];
         } else  {
             self.contentLabel.text =  @"";
             
         }
     } else {
         self.contentLabel.text =  @"0.00";

     }
   
}
- (void)setModel:(StoreModel *)model {
    
    if ([self.storeTitleStr isEqualToString:@"今日订单数"]) {
        self.contentLabel.text = model.todayCounts ? model.todayCounts : @"0";
    } else if ([self.storeTitleStr isEqualToString:@"商品订单"]) {
        self.contentLabel.text = model.goodsCounts ? model.goodsCounts : @"0";
    } else if ([self.storeTitleStr isEqualToString:@"收款订单"]) {
        self.contentLabel.text = model.receivablesCounts ? model.receivablesCounts : @"0";
    } else if ([self.storeTitleStr isEqualToString:@"已核销订单"]) {
        self.contentLabel.text = model.verifiedCounts ? model.verifiedCounts : @"0";
    } else if ([self.storeTitleStr isEqualToString:@"待付款"]) {
        self.contentLabel.text = model.paymentCounts ? model.paymentCounts : @"0";
    } else if ([self.storeTitleStr isEqualToString:@"待评价"]) {
        self.contentLabel.text = model.evaluateCounts ? model.evaluateCounts : @"0";
    } else if ([self.storeTitleStr isEqualToString:@"待核销订单"]) {
        self.contentLabel.text = model.unwrittenCounts ? model.unwrittenCounts : @"0";
    } else if ([self.storeTitleStr isEqualToString:@"出售中"]) {
        self.contentLabel.text =  @"0";
    } else if ([self.storeTitleStr isEqualToString:@"已下架"]) {
        self.contentLabel.text =  @"0";
    } else if ([self.storeTitleStr isEqualToString:@"草稿中"]) {
        self.contentLabel.text =  @"0";
    } else {
        self.contentLabel.text = @"";

    }
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [ManagerEngine getColor:@"333333"];
        _contentLabel.font = [UIFont systemFontOfSize:52/3.f weight:UIFontWeightBold];
        _contentLabel.text = @"1111111";
    }
    return _contentLabel;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [ManagerEngine getColor:@"606266"];
        _titleLabel.font = [UIFont systemFontOfSize:38/3.f weight:UIFontWeightMedium];
        _titleLabel.text = @"22222";

    }
    return _titleLabel;
}
@end
