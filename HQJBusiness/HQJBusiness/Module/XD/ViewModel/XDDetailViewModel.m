//
//  XDDetailViewModel.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/18.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDDetailViewModel.h"

@implementation XDDetailViewModel

+ (NSArray *)firDataArray{
    return @[@[@"标识企业",@"实现基础的产品赋码印码，可实现扫码展示页自定义，展示数据自定义"],@[@"活动营销",@"以标识为基准，实现企业活动面向消费者的直推，通过发放微信红包，吸引客户更多了解企业产品"],@[@"大数据防伪",@"基于用户扫码数据及地理位置的综合分析，在此基础上结合企业产销存数据实现的大数据防伪功能，可做到假货实时预警，快速采集证据、定位假货据点或源头"],@[@"大数据防窜货",@"基于用户扫码数据及地理位置的综合分析，并结合企业产销存数据实现的大数据防窜功能，可实现窜货预警、证据预售收集、定位据点等功能"],@[@"流转追溯",@"配套企业内部管理产销存，可实现企业内部产销存各环节数据采集，并可自定义环节及环节采集需求"]];
}
+ (NSArray *)secDataArray{
    return @[@"【物物地图】APP使用",@"在线智能客服",@"发放牌匾",@"营销助手",@"联合活动",@"视频直播",@"营销推广",@"赠送行业培训（价值10万元）"];
}
+ (NSArray *)tempArray{

    return @[@[@[@0],@[@0,@1]],@[@[@0,@1],@[@0,@1,@2]],@[@[@0,@1],@[@0,@1,@2,@3,@4,@7]],@[@[@0,@1,@2,@3,@4],@[@0,@1,@2,@3,@4,@5,@6,@7]],@[@[@0,@1,@2,@3,@4],@[@0,@1,@2,@3,@4,@5,@6,@7]]];
}
+ (NSArray *)priceArray{
    return @[@"2980",@"4980",@"9980",@"19800",@"49900"];
}
+ (CGFloat)getStringHeight:(NSString *)text{
    CGFloat w = WIDTH - 156/3;
    CGSize labelsize  = [text
                         boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX)
                         options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:40/3]}
                         context:nil].size;
    return labelsize.height + 1;
}
+ (CGFloat)getSecCellHeight:(NSArray *)dataArray{
    CGFloat x = 50/3,y = 10,temp;
    for (int i = 0; i < dataArray.count; i ++) {
        NSString *result = [XDDetailViewModel secDataArray][[dataArray[i] integerValue]];
        CGFloat width = [ManagerEngine setTextWidthStr:result andFont:[UIFont systemFontOfSize:40/3]] + 12;
        x = x + width + 100;
        if (i < dataArray.count - 1) {
            NSString *nextStr = [XDDetailViewModel secDataArray][[dataArray[i+1] integerValue]];
            CGFloat nextWidth = [ManagerEngine setTextWidthStr:nextStr andFont:[UIFont systemFontOfSize:40/3]] + 12;
            temp = x + nextWidth;
            if (temp>WIDTH-50/3) {
                y+=24;
                x = 50/3;
            }
        }
    }
    return y + 32;
}
@end
