//
//  TabBarBannerViewModel.m
//  WuWuMap
//
//  Created by mymac on 2017/1/18.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "TabBarBannerViewModel.h"
#import "TabBarBannerModel.h"
@interface TabBarBannerViewModel()

@end
@implementation TabBarBannerViewModel
+(void)pictureRequst:(void(^)(id sender))pictureBlock {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@system/banner.action?type=2",OrderTest_URL];
    HQJLog(@"图片：%@",urlStr);

    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        NSArray *resultMsgArray = dic[@"resultMsg"];
        NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:resultMsgArray.count];
        for (NSDictionary *dicOne in resultMsgArray) {
            
            TabBarBannerModel *model = [TabBarBannerModel mj_objectWithKeyValues:dicOne];
            [modelArray addObject:model];
        }
        pictureBlock(modelArray);
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
  
    
}

+(void)tabbarPictureRequst:(void(^)(id sender))tabbarBlock {
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@system/icon.action?type=2",OrderTest_URL];
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        NSArray *resultMsgArray = dic[@"resultMsg"];
        
        tabbarBlock(resultMsgArray);

    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
       
    
}


@end
