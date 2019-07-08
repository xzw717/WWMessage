//
//  OrderManageCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/5.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderManageCell.h"
@interface OrderManageCell()
@property (nonatomic, strong) UILabel *orderIdLabel;
@property (nonatomic, strong) UILabel *orderStateLabel;
//@property (nonatomic, strong) UILabel *orderidLabel;
//@property (nonatomic, strong) UILabel *orderidLabel;
//@property (nonatomic, strong) UILabel *orderidLabel;
//@property (nonatomic, strong) UILabel *orderidLabel;

@end
@implementation OrderManageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setNeedsUpdateConstraints];
    }
    return self;
}
@end
