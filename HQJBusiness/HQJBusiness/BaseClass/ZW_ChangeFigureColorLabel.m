//
//  ZW_ChangeFigureColorLabel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/18.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_ChangeFigureColorLabel.h"

@implementation ZW_ChangeFigureColorLabel




-(void)setText:(NSString *)text {
    [super setText:text];
   
    if (!_needChangeStr) {
        if (!_zw_number) {
            _zw_number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"."];
        }
        NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:text];
        for (int i = 0; i < text.length; i ++) {
            //这里的小技巧，每次只截取一个字符的范围
            NSString *a = [text substringWithRange:NSMakeRange(i, 1)];
            //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
            if (!_zw_color) {
                _zw_color = [ManagerEngine getColor:@"18abf5"];
            }
            if ([_zw_number containsObject:a]) {
                [attributeString setAttributes:@{NSForegroundColorAttributeName:_zw_color,NSFontAttributeName:self.font,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(i, 1)];
            }
            
        }
        //完成查找数字，最后将带有字体下划线的字符串显示在UILabel上
        self.attributedText = attributeString;
    }else {
        NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:text];

        NSRange range = [text rangeOfString:_needChangeStr];

        [attributeString setAttributes:@{NSForegroundColorAttributeName:_zw_color,NSFontAttributeName:self.font,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:range];
        
        self.attributedText = attributeString;
    }
    
    
    
    
}


@end
