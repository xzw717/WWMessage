//
//  MineHeadView.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/2.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ContactManagerHeadView.h"
#define  HeadHeight  132/3.f
#define  ButtonSpace 70.f/3.f
#define  LineSpace 39.f/3.f

@interface ContactItemView : UIView

@end


@interface ContactItemView ()

@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIView *bottomView;
@end


@implementation ContactItemView
#pragma lazy-load
-(UILabel *)nameLabel {
    if ( _nameLabel == nil ) {
        _nameLabel =  [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:16.f];
        _nameLabel.textAlignment =NSTextAlignmentCenter;
        _nameLabel.textColor = [ManagerEngine getColor:@"464648"];
        _nameLabel.text = @"已签合同";
        [self addSubview:_nameLabel];
    }

    return _nameLabel;
}
- (UIView *)bottomView{
    if ( _bottomView == nil ) {
        _bottomView =  [[UIView alloc]init];
        _bottomView.hidden = YES;
        _bottomView.backgroundColor = DefaultAPPColor;
        [self addSubview:_bottomView];
    }
    return _bottomView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame ];
    if (self) {
        self.userInteractionEnabled = YES;
        [self layoutTheSubViews];
    }
    return self;
}

- (void)layoutTheSubViews{

    self.nameLabel.sd_layout.centerXEqualToView(self).centerYEqualToView(self).heightIs(20.f).widthIs(WIDTH/3);
    self.bottomView.sd_layout.centerXEqualToView(self).bottomEqualToView(self).heightIs(2.f).widthIs(WIDTH/3 - 80/3);
}

@end




@interface ContactManagerHeadView ()

@property (nonatomic,strong)NSArray *titleArray;

@property (nonatomic,strong)ContactItemView *itemView;

@end


@implementation ContactManagerHeadView


#pragma lazy-load

- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray{
    self = [super initWithFrame:frame ];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleArray = titleArray;
        [self addTheSubViews];
    }
    return self;
}
- (void)addTheSubViews{
    
    CGFloat JGGMinX = 0;//起始x值
    CGFloat JGGMinY = 0;//起始y值
    CGFloat SPspace = 0;//水平距离
    CGFloat ItemWidth = WIDTH / _titleArray.count;
    
    for (NSInteger i = 0; i < _titleArray.count; i ++) {
        CGFloat x =  JGGMinX + i % _titleArray.count * (ItemWidth + SPspace);
        CGFloat y =  JGGMinY + i / _titleArray.count * HeadHeight;
        ContactItemView *itemView = [[ContactItemView alloc]initWithFrame:CGRectMake(x, y, ItemWidth, HeadHeight)];
        itemView.nameLabel.text = _titleArray[i];
        if (i == self.selectIndex) {
            itemView.nameLabel.textColor = DefaultAPPColor;
            itemView.nameLabel.font = [UIFont boldSystemFontOfSize:16.f];
            itemView.bottomView.hidden = NO;
        }
        itemView.tag = 1000 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemViewClick:)];
        [itemView addGestureRecognizer:tap];
        [self addSubview:itemView];
    }
}
- (void)itemViewClick:(UITapGestureRecognizer *)tap{
    ContactItemView *itemView = (ContactItemView *)tap.view;
    for (ContactItemView *view in self.subviews) {
        if ([view isEqual:itemView]) {
            [self itemViewSelected:view];
        }else{
            [self itemViewUnSelected:view];
        }
    }
    !self.itemBlock? :self.itemBlock(itemView.tag - 1000);
}
- (void)itemViewSelected:(ContactItemView *)itemView{
    itemView.nameLabel.textColor = DefaultAPPColor;
    itemView.nameLabel.font = [UIFont boldSystemFontOfSize:16.f];
    itemView.bottomView.hidden = NO;
}
- (void)itemViewUnSelected:(ContactItemView *)itemView{
    itemView.nameLabel.textColor = [ManagerEngine getColor:@"464648"];
    itemView.nameLabel.font = [UIFont systemFontOfSize:16.f];
    itemView.bottomView.hidden = YES;
}

@end
