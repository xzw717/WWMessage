//
//  CircleView.h
//  IDLFaceSDKDemoOC
//
//  Created by Tong,Shasha on 2017/8/31.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ZZImageBlcok)(void);

@interface ZZImageContainer : UIView

@property (nonatomic, copy) ZZImageBlcok confirmBlock;
@property (nonatomic, copy) ZZImageBlcok cancelBlock;
@property (nonatomic, strong) UIImage *dataImage;
@end
