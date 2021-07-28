//
//  InLogicManager.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/21.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "InLogicManager.h"
@interface InLogicManager ()
@property (nonatomic, strong) NSDictionary *resultDict;
@property (nonatomic, assign) NSInteger code;

@end
@implementation InLogicManager
- (NSString *)getButtonString{
    if (self.code != 6666) {
      switch ([self.resultDict[@"state"] integerValue]) {
            
            //1生成订单
            //2代付款
            //3付款成功(1.生成第一份合同2.去完善信息（快捷入驻）)
            //4第一份合同待签署(去签属合同)
            //5第-份合同签署成功(去生成第二-份合同)
            //6第一份合同签署失败(跳3)
            //7待签署(去签署第二份合同)
            //8签署成功(等待待审核)
            //9签署失败(跳5 )
            //10审核成功
            //11审核失败(修改信息,需要修改合同就跳5 ,或者跳8 )
        case -1://-1 不可用
            return @"不可申请";
            
        case 0://0 信息未完善
              return self.code == 0 ? @"待审核" : @"立即加入";
            
        case 3://1 信息已完善，去生成第一份合同
//            if ( self.roleValue == 7) {
                return @"签署新商业合同";
//            }
//            if ( self.roleValue == 8) {
//                return @"立即加入";
//            }
            
        case 6:
            return @"签署新商业合同";
        case 2:
        case 1://3 第一份合同签署完成，去生成订单
            return @"立即支付";
            
        case 4://4 第一份合同签署失败，重新生成第一份合同（同步骤1）
            return @"签署新商业合同";
            
        case 8://8 第二份合同签署完成，等待审核
            return @"审核中";
        case 5:
        case 7:
        case 9://9 第二份合同签署失败，重新生成第二份合同（同步骤6）
            return @"签署国物溯源协议";
        case 10://10审核成功，流程结束
            return @"审核成功";
            
        case 11://11 审核失败，修改信息 宗海兰：修改成审核失败，跳出原因
            return @"审核失败";
        case 12://11 审核失败，修改信息 宗海兰：修改成审核失败，跳出原因
            if ( self.code  == 0 || self.code == 6666 ) {
                return  @"待实名认证";

            } else {
                return @"签署新商业合同";

            }

    }
        
    } else {
        return  @"";
    }
    return @"";
}
//- (void)handleXDState:(BOOL)isShortcut{
//    
//    //1生成订单
//    //2代付款
//    //3付款成功(1.生成第一份合同2.去完善信息（快捷入驻）)
//    //4第一份合同待签署(去签属合同)
//    //5第-份合同签署成功(去生成第二-份合同)
//    //6第一份合同签署失败(跳3)
//    //7待签署(去签署第二份合同)
//    //8签署成功(等待待审核)
//    //9签署失败(跳5 )
//    //10审核成功
//    //11审核失败(修改信息,需要修改合同就跳5 ,或者跳8 )
//    
//    if (self.resultDict) {
//        switch ([self.resultDict[@"state"] integerValue]) {
//            case -1://-1 不可用
//                [SVProgressHUD showErrorWithStatus:@"当前状态暂不支持申请"];
//                break;
//                
//            case 0://0 信息未完善
//                //跳转信息填写H5页
//                [self jumpH5:[NSString stringWithFormat:@"%@%@?shopid=%@&type=1&peugeotid=6",HQJBH5UpDataDomain,HQJBNewstoreListInterface,Shopid]];
////                http://statics.wuwuditu.com/shopappH5/index.html#/xdshopmsg
//                break;
//                
//            case 3://1 付款成功，去生成第一份合同
//                if (isShortcut) {
//                    [self jumpH5:[NSString stringWithFormat:@"%@%@?shopid=%@&lat=%f&lng=%f",HQJBH5UpDataDomain,HQJBNewstoreListInterface,self.shopidString,self.latitude,self.longitude]];
//
//                } else {
//                    [self createContract:1];
//
//                }
//                
//                break;
//            case 6://4 第一份合同签署失败，重新生成第一份合同（同步骤1）
//                //去生成第一份合同
//                [self createContract:1];
//                break;
//                
//            case 4://2 第一份合同未签署，去签署第一份合同
//            case 7://7 第二份合同未签署，去签署第二份合同
//                //跳转H5去签署合同
//                [self jumpH5:self.resultDict[@"data"]];
//                break;
//                
//            case 1://3 第一份合同签署完成，去生成订单
//                [self createOreder:@"0"];
//                break;
//                
//            case 2://5 订单已生成，待付款，跳支付页准备付款
//                //跳转支付页
//                [self jumpPay];
//                
//                break;
//                
//            case 5://第1份合同签署成功(去生成第2份合同)
//            case 9://9 第二份合同签署失败，重新生成第二份合同（同步骤5）
//                //去生成第二份合同
//                [self createContract:2];
//                break;
//                
//            case 8://8 第二份合同签署完成，等待审核
//                [SVProgressHUD showSuccessWithStatus:@"等待审核"];
//                break;
//                
//            case 10://10 审核成功，流程结束
//                break;
//                
//            case 11://11 审核失败，修改信息
//            {
////                HQJWebViewController *pvc = [[HQJWebViewController alloc]init];
////                pvc.zwNavView.hidden = YES;
//                @weakify(self);
//                [HintView enrichSubviews:[NSString stringWithFormat:@"%@",self.reason] andSureTitle:@"修改" cancelTitle:@"取消" sureAction:^{
//                    @strongify(self);
//                    [SVProgressHUD showWithStatus:@"加载中"];
//                    [ManagerEngine SVPAfter:self.resultDict[@"errdata"] complete:^{
//                        [SVProgressHUD dismiss];
//                        // 跳转信息填写H5页
//                        [self jumpH5:[NSString stringWithFormat:@"%@%@?shopid=%@&type=3&peugeotid=6",HQJBH5UpDataDomain,HQJBNewstoreListInterface,Shopid]];
//                    }];
//                }];
//                
//                
//               
//                
//            }
//                break;
//            case 12://12 去生成第一份合同
//                [self createContract:1];
//                break;
//        }
//    }
//    if ([self.stateValueLabel.text isEqualToString:@"待实名认证"]) {
//        HQJWebViewController *pvc = [[HQJWebViewController alloc]init];
//        pvc.zwNavView.hidden = YES;
//        pvc.webUrlStr = [NSString stringWithFormat:@"%@%@?shopid=%@&lat=%f&lng=%f",HQJBH5UpDataDomain,HQJBNewstoreListInterface,self.shopidString,self.latitude,self.longitude];
//        [self.navigationController pushViewController:pvc animated:YES];
//
//    }
//
//    
//}
@end
