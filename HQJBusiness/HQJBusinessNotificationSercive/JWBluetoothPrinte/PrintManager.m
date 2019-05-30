//
//  PrintManager.m
//  HQJBusinessNotificationSercive
//
//  Created by mymac on 2019/5/30.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "PrintManager.h"
#import "JWBluetoothManage.h"
@implementation PrintManager

+ (void)autoPrint {
    JWBluetoothManage * manage = [JWBluetoothManage sharedInstance];
    [manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [PrintManager printe];
            });
            
        }else{
        }
    }];
    
    
}

+ (void)printe:(id)model {
//    if ([JWBluetoothManage sharedInstance].stage != JWScanStageCharacteristics) {
//        return;
//    }
//    JWPrinter *printer = [[JWPrinter alloc] init];
//    NSString *str1 = @"物物地图";
//    NSString *str2 = @"Wuwu Map";
//    NSString *str3 = @"订单详情";
//    [printer appendText:str1 alignment:HLTextAlignmentCenter];
//    [printer appendText:str2 alignment:HLTextAlignmentCenter];
//    [printer appendText:str3 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
//    [printer appendSeperatorLine];
//
//    [printer appendText:@"用户信息" alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
//    [printer appendText:[self.pushModel.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]  alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
//    [printer appendSeperatorLine];
//
//    [printer appendText:@"订单详情" alignment:HLTextAlignmentLeft];
//    for (RemotePushGoodsModel *goodsmdoel in self.pushModel.list.list) {
//        [printer appendLeftText:goodsmdoel.name middleText:[NSString stringWithFormat:@"x%@",goodsmdoel.num] rightText:[NSString stringWithFormat:@"%.2f",[goodsmdoel.money floatValue]] isTitle:NO];
//
//    }
//
//    [printer appendSeperatorLine];
//
//    [printer appendTitle:@"总计商品数" value:[NSString stringWithFormat:@"%@",self.pushModel.totalquantity]];
//    [printer appendTitle:@"金    额" value:[NSString stringWithFormat:@"￥%.2f",[self.pushModel.totalmoney floatValue]]];
//
//    [printer appendSeperatorLine];
//    [printer appendTitle:@"订单编号" value:[NSString stringWithFormat:@"%@",self.pushModel.orderid]];
//    [printer appendTitle:@"下单时间" value:self.pushModel.ordertime];
//    [printer appendFooter:@"感谢您选择【物物地图】，欢迎您再次光临!"];
//    [printer appendNewLine];
//    [printer appendNewLine];
//    [printer appendNewLine];
//    NSData *mainData = [printer getFinalData];
//    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
//        if (completion) {
//            NSLog(@"打印成功");
//        }else{
//            NSLog(@"写入错误---:%@",error);
//        }
//    }];
}

@end
