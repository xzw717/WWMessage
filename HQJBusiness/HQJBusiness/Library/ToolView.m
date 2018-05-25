//
//  ToolView.m
//  HQJFacilitator
//
//  Created by mymac on 16/9/27.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ToolView.h"
@interface ToolView ()
@property (nonatomic,strong)UIButton *oldBtn;
@property (nonatomic,strong)NSMutableArray *btnArray;
@property (nonatomic,strong)UIView *lineView;
@end
@implementation ToolView

-(instancetype)initWithFrame:(CGRect)frame andTitleAry:(NSArray *)ary {
    
    self = [super initWithFrame:frame];
    if (self) {
        _btnArray = [NSMutableArray array];
        self.backgroundColor = [ManagerEngine getColor:@"ededed"];
        [self createBtn:ary];
    }
    
    return self;
    
}

-(void)createBtn:(NSArray *)ary{
    _lineView = [[UIView alloc]init];
    _lineView.bounds = CGRectMake(0, 0,WIDTH/ary.count/2 , 2);
    _lineView.center = CGPointMake(WIDTH/ary.count/2,43);
    _lineView.backgroundColor =[ManagerEngine getColor:@"00ccb8"];
    for (NSInteger i=0; i<ary.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:ary[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = [ManagerEngine getColor:@"ededed"];
        btn.tag = i;
        [_oldBtn setTitleColor:[ManagerEngine getColor:@"00ccb8"] forState:UIControlStateNormal];
        if(i == 0  )  {
            _oldBtn = btn;
            [btn setTitleColor:[ManagerEngine getColor:@"00ccb8"] forState:UIControlStateNormal];

        }
            
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        CGFloat btnWidth = [ManagerEngine setTextWidthStr:btn.titleLabel.text andFont:[UIFont systemFontOfSize:16]];
        
        [btn bk_addEventHandler:^(UIButton *sender) {
            [_oldBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [sender setTitleColor:[ManagerEngine getColor:@"00ccb8"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.5f animations:^{
                _lineView.bounds = CGRectMake(0, 0,btnWidth , 2);
                _lineView.center =CGPointMake(sender.center.x, sender.center.y+self.frame.size.height/2);
                [sender setTitleColor:[ManagerEngine getColor:@"00ccb8"] forState:UIControlStateNormal];
                _oldBtn = sender;
                if (_ToolBlock) {
                    _ToolBlock(sender);

                }
                [self ClickBtn:sender.tag];
            }];
            
//            NSLog(@"---点击了按钮");
        } forControlEvents:UIControlEventTouchUpInside];
        btn.frame =CGRectMake(i%ary.count*WIDTH/ary.count, 0, WIDTH/ary.count, self.frame.size.height);
//        btn.backgroundColor = [UIColor whiteColor];
        [self addSubview:btn];
        
        [_btnArray addObject:btn];
        
    }
    
    [self addSubview:_lineView];
    
    
}
-(void)ClickBtn:(NSInteger)tag {
    
    for (UIButton *btn in _btnArray) {
        
        

        if (btn.tag == tag) {
            
            
//            HQJLog(@"点击是否调用此方法%@",btn.titleLabel.text);

            CGFloat btnWidth = [ManagerEngine setTextWidthStr:btn.titleLabel.text andFont:[UIFont systemFontOfSize:16]];

            [_oldBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[ManagerEngine getColor:@"00ccb8"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.5f animations:^{
                _lineView.bounds = CGRectMake(0, 0,btnWidth , 2);
                _lineView.center =CGPointMake(btn.center.x, btn.center.y+self.frame.size.height/2-1);
                [btn setTitleColor:[ManagerEngine getColor:@"00ccb8"] forState:UIControlStateNormal];
                _oldBtn = btn;
            }];
        
    }
    }
    
    
    
}
@end
