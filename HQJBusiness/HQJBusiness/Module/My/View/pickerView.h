//
//  pickerView.h
//  HQJFacilitator
//
//  Created by mymac on 2016/10/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^selectBlock)(id clickBlock);

@interface pickerView : UIView
@property (nonatomic,copy)selectBlock senderBlock;

/**
 初始化弹出视图

 @param frame 位置
 @param ary   列表的数据源

 @return 实例化对象
 */
-(instancetype)initWithFrame:(CGRect)frame andTitleAry:(NSMutableArray *)ary;



/**
 展示
 */
-(void)showView;

/**
 隐藏
 */
-(void)hiddenView;


/**
 刷新数据
 */
-(void)refreshData;
@end
