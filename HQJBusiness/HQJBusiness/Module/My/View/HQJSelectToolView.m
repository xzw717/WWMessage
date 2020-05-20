//
//  HQJSelectToolView.m
//  WuWuMap
//
//  Created by mymac on 2020/4/15.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HQJSelectToolView.h"
@interface HQJSelectToolView ()
#define btnWidth   WIDTH / self.titArray.count
@property (nonatomic, strong) NSMutableArray <NSString *>*titArray;
@property (nonatomic, strong) UIView *linkView;
@property (nonatomic, strong) UIButton *btns;
@end
@implementation HQJSelectToolView

- (instancetype)initWithTitleAry:(NSArray <NSString *>*)ary {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titArray = [NSMutableArray arrayWithArray:ary];
        [self setSubView];
        
    }
    return self;
}
- (void)clickBtn:(UIButton *)btn {
   
    [UIView animateWithDuration:0.25 animations:^{
        self.linkView.frame = CGRectMake((btnWidth - btn.currentTitle.length * NewProportion(48)) / 2 + btn.mj_x , self.linkView.mj_y, btn.currentTitle.length * NewProportion(48), self.linkView.mj_h);
        [self.btns setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor: DefaultAPPColor forState:UIControlStateNormal];
          self.btns = btn;
    }];
    !self.index?:self.index(btn.tag);
    
}
- (void)setSubView {
    
    [self addSubview:self.linkView];
//    CGFloat btnWidth = S_SCREEN_WIDTH / self.titArray.count;
    
    self.linkView.frame = CGRectMake((btnWidth - [self.titArray[0] length] * NewProportion(48)) / 2,NewProportion(132) - 2, [self.titArray[0] length] * NewProportion(48), 2);
    for (NSInteger i = 0; i <self.titArray.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(btnWidth * i, 0, btnWidth, NewProportion(132));
        [button setTitle:self.titArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self addSubview:button];
        if (i == 0) {
             self.btns = button;
            [self.btns setTitleColor: DefaultAPPColor forState:UIControlStateNormal];
        }
       
    }
    
    
}
- (UIView *)linkView {
    if (!_linkView) {
        _linkView = [[UIView alloc]init];
        _linkView.backgroundColor = DefaultAPPColor;
        _linkView.layer.masksToBounds = YES;
        _linkView.layer.cornerRadius = 1.f;
    }
    return _linkView;
}
@end
