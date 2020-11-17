//
//  noticeView.m
//  HQJFacilitator
//
//  Created by mymac on 2016/10/10.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "NoticeView.h"
@interface NoticeView ()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *NewTitleLabel;
@property (nonatomic, assign)NSInteger timerIntrger;
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong)  NSTimer *timer;

@end
@implementation NoticeView


-(UILabel *)titleLabel {
    if ( _titleLabel == nil ) {
        _titleLabel =  [[UILabel alloc]init];
        [self.backGroundView addSubview:_titleLabel];
    }
    
    
    return _titleLabel;
}
-(UILabel *)NewTitleLabel {
    if ( _NewTitleLabel == nil ) {
        _NewTitleLabel = [[UILabel alloc]init];
        [self.backGroundView addSubview:_NewTitleLabel];

    }
    
    
    
    return _NewTitleLabel;
}
-(instancetype)initWithFrame:(CGRect)frame withNav:(BOOL)nav  {

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        self.backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, frame.size.height)];
        if (nav == YES) {
            
             self.backGroundView.backgroundColor  = DefaultAPPColor;
             [self.backGroundView addSubview:self.activityIndicator];

        } else {
            
            self.backGroundView.backgroundColor  = [ManagerEngine getColor:@"fff2b2"];
        }
        
        [self addSubview:self.backGroundView];

        
    }
    
    
    
    return self;
}

-(void)setTitleStr:(NSString *)titleStr andisNav:(BOOL)nav andColor:(UIColor *)color{
    if (_timer) {
        _timer = nil;

        [_timer invalidate];
    }
    
         UIColor *textColor;
        UIFont *font;
        CGFloat labelY = 0.0;   //  --- 文字所在视图 Y 轴的位置
 
    if (nav == YES) {
        textColor= [UIColor whiteColor];
        font = [UIFont systemFontOfSize:18.0];
        
        labelY = NavigationControllerHeight - 15.f - 18.f;
        self.titleLabel.text = titleStr;

        if ([titleStr isEqualToString:@""] || titleStr == nil) {
            [self.activityIndicator startAnimating];
        } else {
            [self.activityIndicator stopAnimating];
        }
    } else {
        textColor = [UIColor blackColor];
        font = [UIFont systemFontOfSize:15.0];
        labelY = (self.frame.size.height - 15.0) / 2.0 ;
    }
    self.titleLabel.textColor = textColor;
    self.NewTitleLabel.textColor = textColor;
    self.titleLabel.font = font;
    self.NewTitleLabel.font = font;
    CGFloat titleWidth = [ManagerEngine setTextWidthStr:titleStr andFont:font];
    _timerIntrger = titleStr.length/3;
    if (titleWidth + kEDGE * 2 > WIDTH) {    //  --- 字数超过屏幕
        self.titleLabel.frame = CGRectMake(kEDGE , labelY, titleWidth, 20);
        self.NewTitleLabel.frame =CGRectMake(self.titleLabel.frame.origin.x + titleWidth + kEDGE, self.titleLabel.frame.origin.y , titleWidth, 20);
        self.NewTitleLabel.text = titleStr;
        _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(animationStar) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        
    } else {                           //   --
         self.titleLabel.frame = CGRectMake((WIDTH - kEDGE * 2 - titleWidth)/2 + kEDGE, labelY, titleWidth, 20);
    }
    
    if (nav == NO) {
        
        NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"."];
        
        NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:titleStr];
        for (int i = 0; i < titleStr.length; i ++) {
            //这里的小技巧，每次只截取一个字符的范围
            NSString *a = [titleStr substringWithRange:NSMakeRange(i, 1)];
            //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
            if ([number containsObject:a]) {
                [attributeString setAttributes:@{NSForegroundColorAttributeName:[ManagerEngine getColor:@"f54949"],NSFontAttributeName:font,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(i, 1)];
            }
        }
        //完成查找数字，最后将带有字体下划线的字符串显示在UILabel上
        self.titleLabel.attributedText = attributeString;

    }
    
    
    //  --  两端的遮罩 View
    for (NSInteger i=0; i<2; i++) {
        UIView *view = [self.backGroundView viewWithTag:i + 10023];
        if (!view) {
            view = [[UIView alloc]init];
            view.frame = CGRectMake(i%2*(15+WIDTH-30), 0, kEDGE, self.frame.size.height);
            view.backgroundColor = color;
            view.tag = 10023 + i;
            [self.backGroundView addSubview:view];
        }
     
    }
    

    
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator ) {
      _activityIndicator = [[UIActivityIndicatorView alloc] init];
      _activityIndicator.center = CGPointMake(self.center.x, self.center.y + 10);
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    }
    return _activityIndicator;
}


-(void)animationStar {
    
    CGRect titleFrame = self.titleLabel.frame;
    CGRect newTitleFrame = self.NewTitleLabel.frame;
    [UIView animateWithDuration:_timerIntrger delay:3.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.titleLabel.frame = CGRectMake(-self.titleLabel.frame.size.width, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, 20);
        self.NewTitleLabel.frame = CGRectMake(15, self.titleLabel.frame.origin.y, self.NewTitleLabel.frame.size.width, 20);
        
    } completion:^(BOOL finished) {
        self.titleLabel.frame = titleFrame ;
        self.NewTitleLabel.frame = newTitleFrame ;
    }];
    
}


-(void)dismssPopView {
  
    for (UIView *view in self.backGroundView.subviews) {
    
        [view removeFromSuperview];
    }
    
    [self removeFromSuperview];
    
}
@end
