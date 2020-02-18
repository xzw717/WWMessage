//
//  PhotoView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/14.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UIView
@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, strong) UIButton *photoDeleteButton;
@property (nonatomic, assign) CGFloat uploadProgress;
@end
