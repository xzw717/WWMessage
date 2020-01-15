//
//  DetailBaseVC.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailBaseVC : UIViewController

@property (nonatomic,assign) NSInteger  page;

@property (nonatomic,strong) NSString * type;

@property (nonatomic,assign) NSInteger typePage;

@property (nonatomic,strong) NSMutableArray *listArray;


@property (nonatomic,strong)UITableView * tableView;

-(void)requstType:(NSString *)type andPage:(NSString *)page;
@end
