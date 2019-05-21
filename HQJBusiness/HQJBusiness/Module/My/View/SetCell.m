//
//  SetCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/5/20.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SetCell.h"
@interface SetCell ()
@end

@implementation SetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.setSwitch];
        [self.setSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.contentView);
            
        }];
    }
    return self;
}
- (UISwitch *)setSwitch {
    if (!_setSwitch) {
        _setSwitch = [[UISwitch alloc]init];
        [_setSwitch addTarget:self action:@selector(swChange:) forControlEvents:UIControlEventValueChanged];

    }
    return _setSwitch;
}
- (void) swChange:(UISwitch*) sw{
    !self.clickSwitchBlock ? : self.clickSwitchBlock(sw.on);
}

@end
