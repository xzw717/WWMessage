//
//  OrderNoteCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/10/22.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderNoteCell.h"
@interface OrderNoteCell ()

@end
@implementation OrderNoteCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.noteLabel];
        [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(-12);
            make.bottom.mas_equalTo(-18);

        }];
    }
    
    return self;
}
- (CGFloat)orderNoteHeight {
    CGFloat w = WIDTH - (15  + 12) * 2;
    CGSize labelsize  = [self.noteLabel.text
                         boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX)
                         options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f weight:UIFontWeightMedium]}
                         context:nil].size;
    //    CGFloat f = [];
    return labelsize.height + 15 + 18 ;
}
-(UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.text = @"爱上电视都老卡商家的拉克丝VC，女，暂存asdjljasdflk是聚隆科技卢卡斯丢爱福家阿拉山口的荆防颗粒撒豆腐皮欧赔七日杀";
        _noteLabel.numberOfLines = 0;
        _noteLabel.font = [UIFont systemFontOfSize:12.f weight:UIFontWeightMedium];
        _noteLabel.textColor = [ManagerEngine getColor:@"585858"];
    }
    
    return _noteLabel;
}
@end
