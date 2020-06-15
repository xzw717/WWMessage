//
//  CircleView.m
//  IDLFaceSDKDemoOC
//
//  Created by Tong,Shasha on 2017/8/31.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "LivenessImagesView.h"
#define kLastWindow [UIApplication sharedApplication].keyWindow
#define ImageSpace 10

#define ImageWidth (WIDTH - 5 * ImageSpace)/4

@interface LivenessImagesView ()

@property (nonatomic,strong) NSMutableArray *faceArray;

@end

@implementation LivenessImagesView

- (instancetype)initWithFrame:(CGRect)frame andImages:(NSMutableArray *)faceArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.faceArray = faceArray;
        [self layoutTheSubviews];
    }
    return self;
}
- (void)layoutTheSubviews{
    
    for (NSInteger i = 0; i < self.faceArray.count ; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ImageSpace + i * (ImageSpace + ImageWidth), 0, ImageWidth, ImageWidth *1.5)];
        imageView.image = self.faceArray[i];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i + 1000;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClicked:)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
    }
}

- (void)imageViewClicked:(UITapGestureRecognizer *)tap{
    
}
@end
