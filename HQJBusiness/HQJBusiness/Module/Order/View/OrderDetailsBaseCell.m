//
//  OrderDetailsBaseCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailsBaseCell.h"

@interface OrderDetailsBaseCell ()
@property (nonatomic, strong) UIView *lineView;

@end
@implementation OrderDetailsBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [ManagerEngine getColor:@"dbd8d8"];
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}
- (void)hiddenLiane:(BOOL)isHidden {
    self.lineView.hidden = isHidden;
}
@end
