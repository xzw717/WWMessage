//
//  OrderDetailsCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailsOneCell.h"
@interface OrderDetailsOneCell ()
@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation OrderDetailsOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        //        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(10);
        }];
    }
    return self;
}
- (void)setStatess:(NSString *)statess {
    self.titleLabel.text = statess;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [ManagerEngine getColor:@"323232"];
        _titleLabel.font = [UIFont systemFontOfSize:17.f weight:UIFontWeightBold];
        
    }
    return _titleLabel;
}
@end
