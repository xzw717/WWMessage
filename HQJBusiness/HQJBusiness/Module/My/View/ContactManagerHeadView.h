//
//  ContactManagerHeadView.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/21.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
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

