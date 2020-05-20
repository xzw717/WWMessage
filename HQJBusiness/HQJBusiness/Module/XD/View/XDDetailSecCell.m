//
//  MyTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//


@interface XDItemView : UIView
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UILabel * nameLabel;
@end
@interface XDItemView ()

@end

@implementation XDItemView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutTheSubViews];
    }
    return self;
}
-(UILabel *)nameLabel {
    if ( _nameLabel == nil ) {
        _nameLabel =  [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:40/3];
        _nameLabel.textColor = [ManagerEngine getColor:@"333333"];
        [self addSubview:_nameLabel];
        
    }

    return _nameLabel;
}
- (UIImageView *)imageView{
    if ( _imageView == nil ) {
        _imageView =  [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"tick"];
        
        [self addSubview:_imageView];
        
    }
    return _imageView;
}
- (void)layoutTheSubViews{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(12,12));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(12);
    }];
    
}

@end

#import "XDDetailSecCell.h"
#import "XDDetailViewModel.h"

@interface XDDetailSecCell()

@property (nonatomic,strong) UILabel * descLabel;
@end

@implementation XDDetailSecCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    }
    
    return self;
}

- (void)setDataArray:(NSArray *)dataArray{
    
    CGFloat x = 50/3,y = 10,temp;
    for (int i = 0; i < dataArray.count; i ++) {
        NSString *result = [XDDetailViewModel secDataArray][[dataArray[i] integerValue]];
        CGFloat width = [ManagerEngine setTextWidthStr:result andFont:[UIFont systemFontOfSize:40/3]] + 22;
        XDItemView *itemView = [[XDItemView alloc]initWithFrame:CGRectMake(x, y, width, 12)];
        itemView.nameLabel.text = result;
        [self addSubview:itemView];
        x = x + width + 100/3;
        if (i < dataArray.count - 1) {
            NSString *nextStr = [XDDetailViewModel secDataArray][[dataArray[i+1] integerValue]];
            CGFloat nextWidth = [ManagerEngine setTextWidthStr:nextStr andFont:[UIFont systemFontOfSize:40/3]] + 12;
            temp = x + nextWidth;
            if (temp>WIDTH-50/3) {
                y+=24;
                x = 50/3;
            }
        }
    }
    
    
    
}
- (void)addSubview:(UIView *)view
{
    if (![view isKindOfClass:[NSClassFromString(@"_UITableViewCellSeparatorView") class]] && view)
        [super addSubview:view];
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
