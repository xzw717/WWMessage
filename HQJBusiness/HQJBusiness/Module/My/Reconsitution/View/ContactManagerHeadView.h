//
//  MineHeadView.h
//  HQJBusiness
//
//  Created by 姚 on 2019/7/2.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^itemClickBlock)(NSInteger selectedIndex);

@interface ContactManagerHeadView : UIView

- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray;

@property(nonatomic,assign)NSInteger selectIndex;//初始选中的index
@property(nonatomic,copy)itemClickBlock itemBlock;
@end

NS_ASSUME_NONNULL_END
