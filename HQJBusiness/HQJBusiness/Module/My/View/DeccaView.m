//
//  DeccaView.m
//  HQJBusiness
//
//  Created by mymac on 2017/9/15.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "DeccaView.h"
@interface DeccaView ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@end

@implementation DeccaView

-(void)drawRect:(CGRect)rect{
    CGContextRef context=UIGraphicsGetCurrentContext();
    [self drawImage2:context];
}
-(void)drawImage2:(CGContextRef)context{
    UIImage *image=[UIImage imageNamed:@"kabg"];
    //图像绘制
    CGRect rect= CGRectMake(0, 0, 1181, 1665);
    CGContextDrawImage(context, rect, image.CGImage);
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
        [self setLayout];
    }
    return self;
}

- (void)addView {
//    [self addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.nameLabel];
}

- (void)setLayout {
    self.bgImageView.sd_layout.centerXEqualToView(self).centerYEqualToView(self).heightIs(564.f/2).widthIs(400.f/2);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:WIDTH / 2];
    self.nameLabel.sd_layout.centerXEqualToView(self.bgImageView).topSpaceToView(self.bgImageView, 150).heightIs(15);
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.image = [UIImage imageNamed:@"kabg"];
    }
    return _bgImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"叠园餐厅";
    }
    return _nameLabel;
}

@end
