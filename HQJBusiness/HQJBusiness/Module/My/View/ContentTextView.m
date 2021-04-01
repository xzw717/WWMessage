//
//  ContentTextView.m
//  WuWuLive
//
//  Created by mymac on 2020/7/13.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ContentTextView.h"

@implementation ContentTextView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self) {
        
        [self buildingDefaultParamsAndAddObserver];
    }
    
    return self;
    
}

- (void)buildingDefaultParamsAndAddObserver {
    _placeholderFont = [UIFont systemFontOfSize:16];
    _placeholderColor = [UIColor grayColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)textChange:(NSNotification *)notification {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (self.text.length > 0) { } else {
        NSDictionary *dictionary = @{NSFontAttributeName: _placeholderFont, NSForegroundColorAttributeName: _placeholderColor};
        [self.placeholder drawInRect:CGRectMake(5, 6, self.bounds.size.width, self.bounds.size.height) withAttributes:dictionary];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self setNeedsDisplay];
}
#pragma mark -
#pragma mark - setter methods
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

@end
