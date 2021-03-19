//
//  AddUnionActivityViewModel.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/2.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddUnionActivityViewModel.h"

@implementation AddUnionActivityViewModel
+ (void)getTempData:(NSString *)url completion:(void(^)(NSDictionary *dic))completion{
    
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:url parameters:nil complete:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] == 49000) {
            !completion ? : completion(dic);
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        }
        
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
}
+ (void)getMerchantByMobile:(NSString *)mobile completion:(void(^)(NSDictionary *dic))completion{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBUnionCouponDomain,HQJBGetMerchantByMobileInterface];
    NSDictionary *parameter = @{@"mobile":mobile};
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:parameter complete:^(NSDictionary *dic) {
        !completion ? : completion(dic);
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
}
+ (void)getCouponTypes:(void(^)(NSDictionary *dic))completion{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBUnionCouponDomain,HQJBGetTypesInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:nil complete:^(NSDictionary *dic) {
        !completion ? : completion(dic);
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
}

+ (void)uploadImage:(UIImage *)image andUrl:(NSString *)url alertText:(NSString *)text completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error,UIImage *image))completionBlock{
    
    NSData *imgData = [ManagerEngine reSizeImageData:image maxImageSize:WIDTH maxSizeWithKB:200.0];
    
    NSString *dataStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

    NSDictionary * parameter = @{@"file":dataStr};
    NSLog(@"dataDic = %@",parameter);
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:parameter];
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    if (text) {
        [ZGProgressHUD showMessage:text];
    }
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer]requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    [request addValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval= 30;
    [request setHTTPBody:data];
    HQJLog(@"HTTPBody:%@",request.HTTPBody);
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                      @"text/html",
                                                                      @"text/json",
                                                                      @"text/plain",
                                                                      @"text/javascript",
                                                                      @"text/xml",
                                                                      @"image/jpeg",
                                                                      @"image/png",
                                                                      @"application/octet-stream"]];
    manager.responseSerializer = responseSerializer;
    
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [ZGProgressHUD hideHUD];
        if (completionBlock) {
            completionBlock(response,responseObject,error,image);
        }
    }] resume];
}
+ (void)addUnionActivity:(AddUnionModel *)model andActivityId:(NSString *)activityId completion:(void(^)(NSDictionary *dic))completion{
    if (!model.activityName||model.activityName.length>30) {
        [SVProgressHUD showErrorWithStatus:@"联盟活动名称为30个汉字以内"];
        return;
    }
    if (!model.start) {
        [SVProgressHUD showErrorWithStatus:@"开始时间不能为空"];
        return;
    }
    if (!model.end) {
        [SVProgressHUD showErrorWithStatus:@"结束时间不能为空"];
        return;
    }
    NSString *start = [model.start stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *end = [model.end stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (start.integerValue > end.integerValue) {
        [SVProgressHUD showErrorWithStatus:@"开始时间不能大于结束时间"];
        return;
    }
    if (!model.maxCount||![ManagerEngine isNumber:model.maxCount]) {
        [SVProgressHUD showErrorWithStatus:@"联盟商家上限不能为空且应为纯数字"];
        return;
    }
    if (!model.merchantCount||![ManagerEngine isNumber:model.merchantCount]||model.merchantCount.integerValue < 3) {
        [SVProgressHUD showErrorWithStatus:@"联盟成立数量不能为空且不能小于3"];
        return;
    }
    if (!model.area) {
        [SVProgressHUD showErrorWithStatus:@"商家区域不能为空"];
        return;
    }
    if (!model.merchantType) {
        [SVProgressHUD showErrorWithStatus:@"商家类型不能为空"];
        return;
    }
    if (!model.industry) {
        [SVProgressHUD showErrorWithStatus:@"商家分类不能为空"];
        return;
    }
    if (!model.couponType) {
        [SVProgressHUD showErrorWithStatus:@"优惠券类型不能为空"];
        return;
    }
    if (!model.banner) {
        [SVProgressHUD showErrorWithStatus:@"活动图片不能为空"];
        return;
    }
//    if (!model.pushSettings) {
//        [SVProgressHUD showErrorWithStatus:@"推送时间不能为空"];
//        return;
//    }
    if (!model.isHost) {
        [SVProgressHUD showErrorWithStatus:@"发券方不能为空"];
        return;
    }
    if (!model.rule) {
        [SVProgressHUD showErrorWithStatus:@"规则说明不能为空"];
        return;
    }
    
    if (!model.couponName) {
        [SVProgressHUD showErrorWithStatus:@"优惠券名称不能为空"];
        return;
    }
    if (!model.typeId) {
        [SVProgressHUD showErrorWithStatus:@"联盟券类型不能为空且应为纯数字"];
        return;
    }
    if (!model.reducePrice||![ManagerEngine isNumber:model.reducePrice]) {
        [SVProgressHUD showErrorWithStatus:@"联盟券面额不能为空且应为纯数字"];
        return;
    }
    if (!model.minPrice||![ManagerEngine isNumber:model.minPrice]) {
        [SVProgressHUD showErrorWithStatus:@"使用条件不能为空且应为纯数字"];
        return;
    }
    if (!model.count||![ManagerEngine isNumber:model.count]) {
        [SVProgressHUD showErrorWithStatus:@"发行量不能为空且应为纯数字"];
        return;
    }
    if (!model.receiveNumber||![ManagerEngine isNumber:model.receiveNumber]) {
        [SVProgressHUD showErrorWithStatus:@"每人限领不能为空且应为纯数字"];
        return;
    }
    if (model.startTime&&model.endTime) {
        NSString *startTime = [model.startTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSString *endTime = [model.endTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
        if (startTime.integerValue > endTime.integerValue) {
            [SVProgressHUD showErrorWithStatus:@"优惠券开始时间不能大于结束时间"];
            return;
        }
    }

    
    NSDictionary *dict;
    if (![[self getTrueField:activityId] isEqualToString:@""]) {
        dict = @{@"userId":MmberidStr,@"activityName":[self getTrueField:model.activityName],@"start":[self getTrueField:model.start],@"end":[self getTrueField:model.end],@"banner":[self getTrueField:model.banner],@"area":[self getTrueField:model.area],@"merchantCount":[self getTrueField:model.merchantCount],@"maxCount":[self getTrueField:model.maxCount],@"industry":model.industry,@"pushSettings":@"0",@"merchantType":[self getTrueField:model.merchantType],@"mid":[self getTrueField:model.mid],@"couponType":[self getTrueField:model.couponType],@"rule":[self getTrueField:model.rule],@"isHost":[self getTrueField:model.isHost],@"couponName":[self getTrueField:model.couponName],@"reducePrice":[self getTrueField:model.reducePrice],@"minPrice":[self getTrueField:model.minPrice],@"typeId":[self getTrueField:model.typeId],@"count":[self getTrueField:model.count],@"receiveNumber":[self getTrueField:model.receiveNumber],@"startTime":[self getTrueField:model.startTime],@"endTime":[self getTrueField:model.endTime],@"mobile":[self getTrueField:model.mobile],@"hash":HashCode};
    }else{
        dict = @{@"userId":MmberidStr,@"activityName":[self getTrueField:model.activityName],@"start":[self getTrueField:model.start],@"end":[self getTrueField:model.end],@"banner":[self getTrueField:model.banner],@"area":[self getTrueField:model.areaId],@"merchantCount":[self getTrueField:model.merchantCount],@"maxCount":[self getTrueField:model.maxCount],@"industry":model.industryId,@"pushSettings":@"0",@"merchantType":[self getTrueField:model.merchantTypeId],@"mid":[self getTrueField:model.midId],@"couponType":[self getTrueField:model.couponType],@"rule":[self getTrueField:model.rule],@"isHost":[self getTrueField:model.isHostId],@"couponName":[self getTrueField:model.couponName],@"reducePrice":[self getTrueField:model.reducePrice],@"minPrice":[self getTrueField:model.minPrice],@"typeId":[self getTrueField:model.typeId],@"count":[self getTrueField:model.count],@"receiveNumber":[self getTrueField:model.receiveNumber],@"startTime":[self getTrueField:model.startTime],@"endTime":[self getTrueField:model.endTime],@"mobile":[self getTrueField:model.mobile],@"hash":HashCode};
    }
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:dict];
    [parameter setObject:[[self getTrueField:activityId] isEqualToString:@""]?@"0":activityId forKey:@"id"];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBUnionCouponDomain,HQJBAddActivityInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:parameter complete:^(NSDictionary *dic) {
        !completion ? : completion(dic);
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
    
}
+ (void)getActivityById:(NSString *)activityId completion:(void(^)(NSDictionary *dic))completion{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBUnionCouponDomain,HQJBGetActivityByIdInterface];
    NSDictionary * parameter = @{@"activityId":activityId,@"merchantId":MmberidStr,@"hash":HashCode};
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:parameter complete:^(NSDictionary *dic) {
        !completion ? : completion(dic);

    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
}
+ (void)getActivityInfoById:(NSString *)activityId completion:(void(^)(NSDictionary *dic))completion{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBUnionCouponDomain,HQJBGetActivityInfoByIdInterface];
    NSDictionary * parameter = @{@"activityId":activityId,@"merchantId":MmberidStr,@"hash":HashCode};
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:parameter complete:^(NSDictionary *dic) {
        !completion ? : completion(dic);

    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
}
+ (NSString *)getUrlEncode:(NSString *)field{
    return [field stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]];
}
+ (NSString *)getTrueField:(NSString *)field{
    if (!field) {
        return @"";
    }
    if ([field isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if (!field.length) {
        return @"";
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [field stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return @"";
    }
    return field;
}

+ (NSArray *)getDataArray{
    return @[@[@[@"0",@"* 联盟名称：",@"30个汉字以内",@"",@"activityName"],@[@"1",@"* 开始时间：",@"选择开始时间",@"start"],@[@"1",@"* 结束时间：",@"选择结束时间",@"end"],@[@"0",@"* 联盟商家上限：",@"大于3的整数",@"个",@"maxCount"],@[@"0",@"* 联盟成立数量：",@"大于3且小于等于联盟商家上限数字",@"个",@"merchantCount"]]
             ,@[@"4",@"* 商家区域：",@"选择商家区域",@"area"],@[@"4",@"* 商家类型：",@"选择商家类型",@"merchantType"],@[@"4",@"指定商家：",@"选择指定商家",@"mid"],@[@"4",@"* 商家分类：",@"选择商家分类",@"industry"],
             
             @[@[@"2",@"* 优惠券类型：",@"",@"couponType"],@[@"3",@"* 活动图片：",@"banner"],@[@"2",@"* 推送时间：",@"消费后",@"pushSettings"]],
             @[@[@"2",@"* 发券方：",@"发起人,参与人",@"isHost"],@[@"0",@"* 联盟券类型：",@"选择联盟券类型",@"",@"typeId"],@[@"0",@"* 联盟券名称：",@" 请输入优惠券名称",@"",@"couponName"],@[@"0",@"* 联盟券面额：",@"1 - 500",@"",@"reducePrice"],@[@"0",@"* 使用条件：",@"最低订单金额",@"元",@"minPrice"],@[@"0",@"* 发行数量：",@"1 - 10000",@"张",@"count"],@[@"0",@"* 每人限领：",@"1 （默认一张，可修改）",@"张",@"receiveNumber"],@[@"1",@"开始时间：",@"选择开始时间",@"startTime"],@[@"1",@"结束时间：",@"选择结束时间",@"endTime"]],
  @[@[@"5",@"* 规则说明：",@"输入规则说明",@"rule"]]];
//    ,店铺收藏券
}
+ (NSArray *)getEditDataArray{
    return @[@[@[@"0",@"* 联盟名称：",@"30个汉字以内",@"",@"activityName"],@[@"1",@"* 开始时间：",@"选择开始时间",@"start"],@[@"1",@"* 结束时间：",@"选择结束时间",@"end"],@[@"0",@"* 联盟商家上限：",@"大于3的整数",@"个",@"maxCount"],@[@"0",@"* 联盟成立数量：",@"大于3且小于等于联盟商家上限数字",@"个",@"merchantCount"]],
             
             @[@[@"0",@"* 联盟券类型：",@"选择联盟券类型",@"",@"typeId"],@[@"0",@"* 联盟券名称：",@" 请输入优惠券名称",@"",@"couponName"],@[@"0",@"* 联盟券面额：",@"1 - 500",@"",@"reducePrice"],@[@"0",@"* 使用条件：",@"最低订单金额",@"元",@"minPrice"],@[@"0",@"* 发行数量：",@"1 - 10000",@"张",@"count"],@[@"0",@"* 每人限领：",@"1 （默认一张，可修改）",@"张",@"receiveNumber"],@[@"1",@"开始时间：",@"选择开始时间",@"startTime"],@[@"1",@"结束时间：",@"选择结束时间",@"endTime"]],
  @[@[@"5",@"* 规则说明：",@"输入规则说明",@"rule"]]];
}
@end
