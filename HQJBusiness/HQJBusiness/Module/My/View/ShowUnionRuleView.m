//
//  ShowMobileView.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/23.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShowUnionRuleView.h"
#import "AddUnionActivityViewModel.h"
@interface ShowUnionRuleView ()
//@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel  *contentLabel;
//@property (nonatomic, strong) NSString *content;
@end
@implementation ShowUnionRuleView
- (instancetype)initWithContent:(NSString *)content andFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
        if (self) {
//            self.content = content;
            [self addSubview:self.bgView];
    //        [self.bgView addSubview:self.scrollView];
            [self.bgView addSubview:self.contentLabel];
            self.contentLabel.text = content;
        }
        return self;
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    }
    return _bgView;
}
//- (UIScrollView *)scrollView{
//    if (_scrollView == nil) {
//        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
//        _scrollView.showsVerticalScrollIndicator = NO;
////        _scrollView.contentSize = CGSizeMake(0, HEIGHT+10);
//    }
//    return _scrollView;
//}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH - 100, HEIGHT - 200)];
        _contentLabel.center = self.center;
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.backgroundColor = [UIColor whiteColor];
        _contentLabel.numberOfLines = 0;
        _contentLabel.layer.masksToBounds = YES;
        _contentLabel.layer.cornerRadius = 5;
        _contentLabel.text = @"据了解，企业经营贷一般最长贷款时间为10年，由于其贷款期限较短，所以显然不可能在贷款时限需求较长的“刚需族”普及。不过对于只谋短期利益的“炒房客”而言，企业经营贷无疑是他们的最爱。据了解，企业经营贷一般最长贷款时间为10年，由于其贷款期限较短，所以显然不可能在贷款时限需求较长的“刚需族”普及。不过对于只谋短期利益的“炒房客”而言，企业经营贷无疑是他们的最爱。";
    }
    return _contentLabel;
}

- (void)show{
//    ShowUnionRuleView *view  = [[ShowUnionRuleView alloc]init];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}
@end
