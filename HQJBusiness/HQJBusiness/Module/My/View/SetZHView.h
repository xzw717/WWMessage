//
//  SetZHView.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/17.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetZHView : UIView
@property (nonatomic,strong)ZW_TextField * proportionTextField;
@property (nonatomic,assign)NSInteger cellIndexPath;
@property (nonatomic,strong)ZW_ChangeFigureColorLabel * detaileLabel;
@property (nonatomic,strong)NSString *detaileLabelStr;

-(void)setTitleStr:(NSString *)titleStr andplaceholderStr:(NSString *)placeholderStr;
@end
