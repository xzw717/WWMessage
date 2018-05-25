//
//  TabbarManager.h
//  WuWuMap
//
//  Created by mymac on 2017/1/16.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabbarManager : NSObject



/*********** 状态  ************/
@property (nonatomic,assign)  BOOL isDownLoad;


+(instancetype) shareInstance;

//-(void)GoMainView;


-(void) setTabbar;
@end
