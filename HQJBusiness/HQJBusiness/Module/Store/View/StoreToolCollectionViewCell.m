//
//  StoreToolCollectionViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/8/30.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreToolCollectionViewCell.h"
@interface StoreToolCollectionViewCell ()

@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation StoreToolCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //        [self addSubview:self.earnPointsImageView];
        //        [self addSubview:self.titleLabel];
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.contentImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(NewProportion(64));
            make.centerX.mas_equalTo(self.contentView);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(NewProportion(50));
            make.bottom.mas_equalTo(-NewProportion(77));
            make.centerX.mas_equalTo(self.contentView);
            
        }];
    }
    return self;
}
//- (void)setStoreTitleStr:(NSString *)storeTitleStr {
//    _storeTitleStr = storeTitleStr;
//    self.titleLabel.text = storeTitleStr;
//}
- (void)setItemDictionary:(NSArray<NSString *> *)itemDictionary {
    self.contentImageView.image = [UIImage imageNamed:itemDictionary.lastObject];
    self.titleLabel.text = itemDictionary.firstObject;
}


- (UIImageView *)contentImageView {
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc]init];
    }
    return _contentImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [ManagerEngine getColor:@"606266"];
        _titleLabel.font = [UIFont systemFontOfSize:38/3.f weight:UIFontWeightMedium];
        
    }
    return _titleLabel;
}
@end
