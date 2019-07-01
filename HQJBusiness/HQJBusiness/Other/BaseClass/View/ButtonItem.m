//
//  ButtonItem.m
//  WuWuMap
//
//  Created by MyMac on 2017/7/19.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ButtonItem.h"
#import "UIView+SDExtension.h"

@implementation ButtonItem

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (!_backImageView && frame.size.height != 0 ) {
        
        self.tintColor = [UIColor clearColor];
        
        _backImageView = [[UIImageView alloc]initWithFrame:self.frame];
        _backImageView.image = [UIImage imageNamed:@"icon_circle"];
        [self addSubview:_backImageView];
        
        _signImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.sd_width - 5, self.sd_width - 5)];
        _signImageView.contentMode = UIViewContentModeScaleAspectFill;
        _signImageView.center = _backImageView.center;
        [self addSubview:_signImageView];
    }

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      
    }
    return self;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if ( selected && self.tag == 2367836766246 ) {
        _signImageView.image = [UIImage imageNamed:@"icon_collect_full"];
    }else{
        _signImageView.image = [UIImage imageNamed:@"icon_collect_empty"];
    }
}

- (void)setSignImageStr:(NSString *)signImageStr {
   
}

- (void)setSignImageView:(UIImageView *)signImageView {
    _signImageView = signImageView;
   
}

- (void)setBackImageView:(UIImageView *)backImageView {
 
}

@end
