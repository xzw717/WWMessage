//
//  ZGRelayoutButton.m
//  HQJBusiness
//
//  Created by 姚 on 2019/6/26.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZGRelayoutButton.h"


@implementation ZGRelayoutButton

- (void)setType:(ZGRelayoutButtonType)type {
    _type = type;
    
    if (type != ZGRelayoutButtonTypeNomal) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

//重写父类方法,改变标题和image的坐标
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    if (self.type == ZGRelayoutButtonTypeLeft) {
        
        CGFloat x = contentRect.size.width - self.offset - self.imageSize.width ;
        CGFloat y =  contentRect.size.height -  self.imageSize.height;
        y = y/2;
        
        
        CGRect rect = CGRectMake(x,y,self.imageSize.width,self.imageSize.height);
        
        return rect;
    } else if (self.type == ZGRelayoutButtonTypeBottom) {
        
        CGFloat x =  contentRect.size.width -  self.imageSize.width;
        
        CGFloat  y=   self.offset   ;
        
        x = x / 2;
        
        CGRect rect = CGRectMake(x,y,self.imageSize.width,self.imageSize.height);
        
        return rect;
        
    } else {
        return [super imageRectForContentRect:contentRect];
    }
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    if (self.type == ZGRelayoutButtonTypeLeft) {
        
        return CGRectMake(0, 0, contentRect.size.width - self.offset - self.imageSize.width , contentRect.size.height);
        
        
    } else if (self.type == ZGRelayoutButtonTypeBottom) {
        
        return CGRectMake(0,   self.offset + self.imageSize.height , contentRect.size.width , contentRect.size.height - self.offset - self.imageSize.height );
        
    } else {
        return [super titleRectForContentRect:contentRect];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
