//
//  noticeView.h
//  HQJFacilitator
//
//  Created by mymac on 2016/10/10.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeView : UIView

@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic, strong)  UIActivityIndicatorView *activityIndicator;
/**
 初始化

 @param frame 位置
 @return 实例对象
 */
-(instancetype)initWithFrame:(CGRect)frame  withNav:(BOOL)nav ;

-(void)setTitleStr:(NSString *)titleStr andisNav:(BOOL)nav andColor:(UIColor *)color;

/**
 删除子视图移除本视图
 */
-(void)dismssPopView;

@end
