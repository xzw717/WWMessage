//
//  ToolView.h
//  HQJFacilitator
//
//  Created by mymac on 16/9/27.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ToolButtonBlcok)(UIButton *sender);
@interface ToolView : UIView
-(instancetype)initWithFrame:(CGRect)frame andTitleAry:(NSArray *)ary;
@property (nonatomic,copy)ToolButtonBlcok ToolBlock;
-(void)ClickBtn:(NSInteger)tag;
@end
